import 'dart:async';
import '../../data/database/daos.dart';
import '../../data/database/database.dart';
import '../../data/models/realtime_data_model.dart';
import 'iobd_service.dart';


class TripRecordingService {
  final IObdScanner _obdScanner;
  final TripsDao _tripsDao;

  Timer? _pollingTimer;
  int? _currentTripId;

  // list for batching
  final List<TripPointsCompanion> _pointsBatch = [];
  static const int _batchSizeLimit = 60;

  RealtimeData? _lastSavedPoint;

  final _dataController = StreamController<RealtimeData>.broadcast();
  Stream<RealtimeData> get realtimeDataStream => _dataController.stream;

  // Constructor for the class with parameters _obdScanner and _tripsDao
  TripRecordingService(this._obdScanner, this._tripsDao);

  Future<void> startTrip(int carId) async {
    if (_currentTripId != null) return;

    // Create a new session in the database
    _currentTripId = await _tripsDao.startTrip(TripsCompanion.insert(
      carId: carId,
      startTimestamp: DateTime.now().millisecondsSinceEpoch,
    ));

    _lastSavedPoint = null;
    _pointsBatch.clear();

    // Start a periodic timer for querying every second
    _pollingTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      _onTick();
    });
  }

  /// stop recording
  Future<void> stopTrip() async {
    _pollingTimer?.cancel();
    _pollingTimer = null;

    await _flushBatch();

    if (_currentTripId != null) {
      await _tripsDao.updateTripFields(
        _currentTripId!,
        DateTime.now().millisecondsSinceEpoch,
      );
      _currentTripId = null;
    }
  }

  /// Main loop for querying the adapter
  Future<void> _onTick() async {
    try {
      // read data
      int currentRpm = await _obdScanner.readEngineRpm();
      int currentSpeed = await _obdScanner.readVehicleSpeed();
      int currentTemp = await _obdScanner.readCoolantTemp();
      int currentLoad = await _obdScanner.readEngineLoad();
      int currentThrottle = await _obdScanner.readThrottlePosition();

      // Package the data into a model
      final currentData = RealtimeData(
        speed: currentSpeed,
        rpm: currentRpm,
        coolantTemp: currentTemp,
        engineLoad: currentLoad,
        throttlePosition: currentThrottle,
        timestamp: DateTime.now(),
      );

      // Send data to the UI
      _dataController.add(currentData);

      // Pass through the DELTA FILTER for saving to the database
      if (_shouldSavePoint(currentData)) {
        _pointsBatch.add(TripPointsCompanion.insert(
          tripId: _currentTripId!,
          timestamp: currentData.timestamp.millisecondsSinceEpoch,
          speed: currentData.speed,
          rpm: currentData.rpm,
          throttlePosition: currentData.throttlePosition,
          engineTemp: currentData.coolantTemp,
        ));

        _lastSavedPoint = currentData;

        // If the batch is filled, save it to the database
        if (_pointsBatch.length >= _batchSizeLimit) {
          await _flushBatch();
        }
      }
    } catch (e) {
      // У випадку помилки можна залогувати або додати обробку
      print("Error reading telemetry: $e");
    }
  }

  /// Logic for decimation (determines whether this point needs to be on the graph)
  bool _shouldSavePoint(RealtimeData current) {
    if (_lastSavedPoint == null) return true;// Always save the first point

    final timeElapsed = current.timestamp.difference(_lastSavedPoint!.timestamp).inSeconds;

    // check difference
    final speedDelta = (current.speed - _lastSavedPoint!.speed).abs();
    final rpmDelta = (current.rpm - _lastSavedPoint!.rpm).abs();

    if (speedDelta > 2 || rpmDelta > 50 || timeElapsed >= 30) {
      return true;
    }

    return false;
  }

  /// Batch write to DB
  Future<void> _flushBatch() async {
    if (_pointsBatch.isEmpty) return;

    await _tripsDao.insertTripPointsBatch(List.from(_pointsBatch));
    _pointsBatch.clear();
  }
}