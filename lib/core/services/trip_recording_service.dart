import 'dart:async';
import 'dart:developer';
import 'package:drift/drift.dart' as drift;
import '../../features/analytics/data/trips_dao.dart';
import '../../features/live_dashboard/data/realtime_data_model.dart';
import '../database/database.dart';
import 'obd_service/iobd_service.dart';
import 'foreground_task_handler.dart';

import 'package:geolocator/geolocator.dart';

class TripRecordingService {
  final IObdScanner _obdScanner;
  final TripsDao _tripsDao;

  int _zeroRpmCounter = 0;
  final int _zeroRpmThreshold = 5;

  bool _isPolling = false;
  int? _currentTripId;
  int? _activeCarId;
  int _tickCounter = 0;
  bool _isInitialMileageFetched = false;
  int? _lastKnownMileage;
  int? _startTripMileage;

  double? _smoothedFuelLevel;
  final double _fuelSmoothingAlpha = 0.05; // 5% confidence in new data, 95% in old

  // CACHE FOR SLOW PARAMETERS
  int _cachedCoolantTemp = 0;
  int _cachedEngineOilTemp = 0;
  int _cachedIat = 0;
  int _cachedFuelLevel = 0;
  String _cachedBattery = "--";

  // Counter for slow loop
  int _slowPollCounter = 0;
  final int _slowPollInterval = 5; // We poll slow parameters once every 5 cycles (approximately every 5 seconds)

  int? get lastKnownMileage => _lastKnownMileage;

  StreamSubscription<Position>? _positionSubscription;
  Position? _currentPosition;

  StreamSubscription<RealtimeData>? _telemetrySubscription;

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

    ForegroundTaskManager.start();

    _telemetrySubscription = realtimeDataStream.listen((data) {
      ForegroundTaskManager.sendTelemetry(data.rpm, data.speed);
    });

    _isPolling = true;
    _runPollingLoop();
  }

  void stopPolling() {
    _isPolling = false;

    _positionSubscription?.cancel();
    _positionSubscription = null;
    _currentPosition = null;

    _telemetrySubscription?.cancel();
    _telemetrySubscription = null;
    ForegroundTaskManager.stop();
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
      if (position.accuracy <= 25.0) {
        _currentPosition = position;
      }
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
    _smoothedFuelLevel = null;
    _zeroRpmCounter = 0;
  }

  Future<void> stopRecordingToDatabase() async {
    if (_currentTripId == null) return;

    try {
      // Calculate the trip distance
      int tripDistance = 0;
      if (_startTripMileage != null && _lastKnownMileage != null) {
        if (_lastKnownMileage! >= _startTripMileage!) {
          // Normal trip
          tripDistance = _lastKnownMileage! - _startTripMileage!;
        } else {
          // If errors (Check Engine) were reset right during the trip
          tripDistance = _lastKnownMileage!;
        }
      }

      // Update the trip in the database
      await _tripsDao.updateTrip(
        _currentTripId!,
        TripsCompanion(
          endTimestamp: drift.Value(DateTime.now().millisecondsSinceEpoch),
          totalDistance: drift.Value(tripDistance),
        ),
      );

      // 3. Save last points
      if (_pointsBatch.isNotEmpty) {
        await _flushBatch();
      }

    } catch (e) {
      log("Error stopping trip recording: $e");
    } finally {
      // Clear variables
      _currentTripId = null;
      _startTripMileage = null;
      // We do NOT clear _lastKnownMileage because CarBloc needs it!
    }
  }


  Future<void> _onTick() async {
    try {
      int currentRpm = await _obdScanner.readEngineRpm();
      int currentSpeed = await _obdScanner.readVehicleSpeed();
      int currentLoad = await _obdScanner.readEngineLoad();
      int currentThrottle = await _obdScanner.readThrottlePosition();
      double currentMaf = await _obdScanner.readMAF();


      _slowPollCounter++;
      if (_slowPollCounter >= _slowPollInterval) {
        _cachedCoolantTemp = await _obdScanner.readCoolantTemp();
        _cachedEngineOilTemp = await _obdScanner.readEngineOilTemp();
        _cachedIat = await _obdScanner.readIntakeAirTemp();
        _cachedBattery = await _obdScanner.readBatteryVoltage();

        int rawFuel = await _obdScanner.readFuelLevel();

        if (rawFuel > 0) {
          if (_smoothedFuelLevel == null) {
            // On the first read, we trust the data 100% to set a starting point
            _smoothedFuelLevel = rawFuel.toDouble();
          } else {
            _smoothedFuelLevel = (_fuelSmoothingAlpha * rawFuel) + ((1 - _fuelSmoothingAlpha) * _smoothedFuelLevel!);
          }
          _cachedFuelLevel = _smoothedFuelLevel!.round();
        }

        _slowPollCounter = 0;
      }


      final currentData = RealtimeData(
        speed: currentSpeed,
        rpm: currentRpm,
        engineLoad: currentLoad,
        throttlePosition: currentThrottle,
        maf: currentMaf,

        coolantTemp: _cachedCoolantTemp,
        engineOilTemp: _cachedEngineOilTemp,
        intakeAirTemp: _cachedIat,
        fuelLevel: _cachedFuelLevel,
        batteryVoltage: _cachedBattery,
        timestamp: DateTime.now(),
      );

      if (currentRpm > 0) {
        if (!_isInitialMileageFetched || _tickCounter >= 60) {

          int? distance = await _obdScanner.readDistanceSinceCodesCleared();

          if (distance != null) {
            _lastKnownMileage = distance; // Cache the successful result
            _startTripMileage ??= distance;
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
        // FUSE
        if (currentData.rpm == 0) {
          _zeroRpmCounter++;

          if (_zeroRpmCounter >= _zeroRpmThreshold) {
            log("Engine definitely stopped (RPM = 0 for 5 ticks). Finishing trip...");
            await stopRecordingToDatabase();
            _tripStatusController.add(false);
            return;
          } else {
            log("Warning: RPM is 0, ignoring glitch (Tick $_zeroRpmCounter/$_zeroRpmThreshold)");
            return; // Skip saving this "buggy" point, but don't kill the trip!
          }
        } else {
          // If there are revolutions - reset the glitch counter
          _zeroRpmCounter = 0;
        }



        if (_shouldSavePoint(currentData)) {
          _pointsBatch.add(TripPointsCompanion.insert(
            tripId: _currentTripId!,
            timestamp: currentData.timestamp.millisecondsSinceEpoch,
            speed: currentData.speed,
            rpm: currentData.rpm,
            throttlePosition: currentData.throttlePosition,
            coolantTemp: currentData.coolantTemp,
            engineOilTemp: drift.Value(currentData.engineOilTemp),
            intakeAirTemp: drift.Value(currentData.intakeAirTemp),
            fuelLevel: drift.Value(currentData.fuelLevel),
            maf: drift.Value(currentData.maf),
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