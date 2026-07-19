import 'dart:async';
import 'dart:developer';
import '../../data/database/database.dart';
import '../../data/models/realtime_data_model.dart';
import '../data/database/daos/trips_dao.dart';
import 'obd_service/iobd_service.dart';

class TripRecordingService {
  final IObdScanner _obdScanner;
  final TripsDao _tripsDao;

  Timer? _pollingTimer;
  int? _currentTripId;
  int? _activeCarId;

  // list for batching
  final List<TripPointsCompanion> _pointsBatch = [];
  static const int _batchSizeLimit = 60;

  RealtimeData? _lastSavedPoint;

  final _dataController = StreamController<RealtimeData>.broadcast();
  Stream<RealtimeData> get realtimeDataStream => _dataController.stream;

  TripRecordingService(this._obdScanner, this._tripsDao);

  void startPolling(int carId) {
    _activeCarId = carId; // Зберігаємо ID авто на майбутнє
    if (_pollingTimer != null) return;

    // Запускаємо періодичний таймер для UI
    _pollingTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      _onTick();
    });
  }

  void stopPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = null;
  }

  Future<void> startRecordingToDatabase() async {
    // Не починаємо запис, якщо вже пишемо або не знаємо carId
    if (_currentTripId != null || _activeCarId == null) return;

    // Створюємо нову сесію поїздки в базі
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
      // Закриваємо сесію поїздки
      await _tripsDao.updateTripFields(
        _currentTripId!,
        DateTime.now().millisecondsSinceEpoch,
      );
      _currentTripId = null;
    }
  }


  Future<void> _onTick() async {
    try {
      // Читаємо дані
      int currentRpm = await _obdScanner.readEngineRpm();
      int currentSpeed = await _obdScanner.readVehicleSpeed();
      int currentTemp = await _obdScanner.readCoolantTemp();
      int currentLoad = await _obdScanner.readEngineLoad();
      int currentThrottle = await _obdScanner.readThrottlePosition();

      // Пакуємо дані у модель
      final currentData = RealtimeData(
        speed: currentSpeed,
        rpm: currentRpm,
        coolantTemp: currentTemp,
        engineLoad: currentLoad,
        throttlePosition: currentThrottle,
        timestamp: DateTime.now(),
      );

      // ЗАВЖДИ відправляємо дані в UI (стрім)
      _dataController.add(currentData);

      // ЗАПИСУЄМО В БАЗУ ТІЛЬКИ ЯКЩО TripId != null (заведено двигун)
      if (_currentTripId != null) {
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

          // Зберігаємо пачку в базу, якщо вона заповнилась
          if (_pointsBatch.length >= _batchSizeLimit) {
            await _flushBatch();
          }
        }
      }
    } catch (e) {
      log("Error reading telemetry: $e");
    }
  }

  // Логіка проріджування залишається без змін
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

  // Пакетний запис залишається без змін
  Future<void> _flushBatch() async {
    if (_pointsBatch.isEmpty) return;

    await _tripsDao.insertTripPointsBatch(List.from(_pointsBatch));
    _pointsBatch.clear();
  }
}