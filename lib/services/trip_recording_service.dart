import 'dart:async';
import 'dart:developer';
import 'package:drift/drift.dart' as drift;
import '../../data/database/database.dart';
import '../../data/models/realtime_data_model.dart';
import '../data/database/daos/trips_dao.dart';
import 'obd_service/iobd_service.dart';

import 'package:geolocator/geolocator.dart';
import 'package:drift/drift.dart' as drift;

class TripRecordingService {
  final IObdScanner _obdScanner;
  final TripsDao _tripsDao;

  bool _isPolling = false;
  int? _currentTripId;
  int? _activeCarId;
  int _tickCounter = 0;
  bool _isInitialMileageFetched = false;
  int? _lastKnownMileage;

  int? get lastKnownMileage => _lastKnownMileage;

  StreamSubscription<Position>? _positionSubscription;
  Position? _currentPosition;

  // list for batching
  final List<TripPointsCompanion> _pointsBatch = [];
  static const int _batchSizeLimit = 60;

  RealtimeData? _lastSavedPoint;

  final _dataController = StreamController<RealtimeData>.broadcast();
  Stream<RealtimeData> get realtimeDataStream => _dataController.stream;

  final _tripStatusController = StreamController<bool>.broadcast();
  Stream<bool> get isTripActiveStream => _tripStatusController.stream;

  TripRecordingService(this._obdScanner, this._tripsDao);

  void startPolling(int carId) {
    _activeCarId = carId;
    if (_isPolling) return;

    _startLocationTracking();


    _isPolling = true;
    _runPollingLoop();
  }

  void stopPolling() {
    _isPolling = false;

    _positionSubscription?.cancel();
    _positionSubscription = null;
    _currentPosition = null;
  }

  Future<void> _startLocationTracking() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return; // if GPS is off on phone

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    if (permission == LocationPermission.deniedForever) return;

    _positionSubscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 5,
      ),
    ).listen((Position position) {
      _currentPosition = position;
    });
  }

  Future<void> startRecordingToDatabase() async {
    if (_currentTripId != null || _activeCarId == null) return;

    // Create a new trip session in the database
    _currentTripId = await _tripsDao.startTrip(TripsCompanion.insert(
      carId: _activeCarId!,
      startTimestamp: DateTime.now().millisecondsSinceEpoch,
    ));

    _lastSavedPoint = null;
    _pointsBatch.clear();
  }

  Future<void> stopRecordingToDatabase() async {
    await _flushBatch();

    if (_currentTripId != null) {
      await _tripsDao.updateTripFields(
        _currentTripId!,
        DateTime.now().millisecondsSinceEpoch,
      );
      _currentTripId = null;
    }
  }


  Future<void> _onTick() async {
    try {
      int currentRpm = await _obdScanner.readEngineRpm();
      int currentSpeed = await _obdScanner.readVehicleSpeed();
      int currentTemp = await _obdScanner.readCoolantTemp();
      int currentLoad = await _obdScanner.readEngineLoad();
      int currentThrottle = await _obdScanner.readThrottlePosition();

      final currentData = RealtimeData(
        speed: currentSpeed,
        rpm: currentRpm,
        coolantTemp: currentTemp,
        engineLoad: currentLoad,
        throttlePosition: currentThrottle,
        timestamp: DateTime.now(),
      );

      if (currentRpm > 0) {
        if (!_isInitialMileageFetched || _tickCounter >= 60) {

          int? distance = await _obdScanner.readDistanceSinceCodesCleared();

          if (distance != null) {
            _lastKnownMileage = distance; // Cache the successful result
          }

          _isInitialMileageFetched = true;
          _tickCounter = 0; // Reset the counter after the request
        }

        _tickCounter++;
      } else {
        // If the engine is turned off, we reset the flag for the next trip.
        // We do NOT reset the _lastKnownMileage variable, because the BLoC needs it for saving!
        _isInitialMileageFetched = false;
        _tickCounter = 0;
      }

      _dataController.add(currentData);

      // RECORD TO DATABASE ONLY IF TripId != null (engine started)
      if (_currentTripId != null) {

        if (currentData.rpm == 0) {
          log("Engine stopped (RPM = 0). Finishing trip...");
          await stopRecordingToDatabase();
          _tripStatusController.add(false); // end of trip
          return; // finish and don`t save the last point
        }


        if (_shouldSavePoint(currentData)) {
          _pointsBatch.add(TripPointsCompanion.insert(
            tripId: _currentTripId!,
            timestamp: currentData.timestamp.millisecondsSinceEpoch,
            speed: currentData.speed,
            rpm: currentData.rpm,
            throttlePosition: currentData.throttlePosition,
            engineTemp: currentData.coolantTemp,
            latitude: drift.Value(_currentPosition?.latitude),
            longitude: drift.Value(_currentPosition?.longitude),
          ));

          _lastSavedPoint = currentData;

          // Save the batch to the database if it's full
          if (_pointsBatch.length >= _batchSizeLimit) {
            await _flushBatch();
          }
        }
      }
    } catch (e) {
      log("Error reading telemetry: $e");
    }
  }

  bool _shouldSavePoint(RealtimeData current) {
    if (_lastSavedPoint == null) return true;

    final timeElapsed = current.timestamp.difference(_lastSavedPoint!.timestamp).inSeconds;
    final speedDelta = (current.speed - _lastSavedPoint!.speed).abs();
    final rpmDelta = (current.rpm - _lastSavedPoint!.rpm).abs();

    if (speedDelta > 2 || rpmDelta > 50 || timeElapsed >= 30) {
      return true;
    }

    return false;
  }

  Future<void> _flushBatch() async {
    if (_pointsBatch.isEmpty) return;

    await _tripsDao.insertTripPointsBatch(List.from(_pointsBatch));
    _pointsBatch.clear();
  }

  Future<void> _runPollingLoop() async {
    while (_isPolling) {
      final startTime = DateTime.now();

      // Wait for the COMPLETE completion of all commands to the adapter
      await _onTick();

      if (!_isPolling) break;

      // Calculate the time spent interacting with the car
      final elapsed = DateTime.now().difference(startTime);

      // We need a 1-second interval.
      // If the request took 400ms, we wait another 600ms.
      // If the request took 1.2 seconds (the adapter was slow), we start the next one immediately.
      final delay = const Duration(seconds: 1) - elapsed;

      if (delay > Duration.zero) {
      await Future.delayed(delay);
      }
    }
  }
}