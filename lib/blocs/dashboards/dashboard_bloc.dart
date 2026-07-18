import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/realtime_data_model.dart';
import '../../services/obd_service/iobd_service.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final IObdScanner _obdScanner;
  StreamSubscription? _connectionSubscription;
  Timer? _pollingTimer;

  DashboardBloc(this._obdScanner) : super(DashboardState.initial()) {
    on<DashboardInitialized>(_onInitialized);
    on<DashboardConnectionChanged>(_onConnectionChanged);
    on<DashboardStartPolling>(_onStartPolling);
    on<DashboardStopPolling>(_onStopPolling);
    on<_DashboardPollingTick>(_onPollingTick);
  }

  void _onInitialized(DashboardInitialized event, Emitter<DashboardState> emit) {
    _connectionSubscription = _obdScanner.connectionState.listen((status) {
      add(DashboardConnectionChanged(status));
    });
  }

  void _onConnectionChanged(DashboardConnectionChanged event, Emitter<DashboardState> emit) {
    emit(state.copyWith(connectionStatus: event.status));
    if (event.status != ObdConnectionState.connected) {
      add(DashboardStopPolling());
    }
  }

  void _onStartPolling(DashboardStartPolling event, Emitter<DashboardState> emit) {
    if (state.connectionStatus != ObdConnectionState.connected) return;

    emit(state.copyWith(isPolling: true));

    // start a periodic timer to poll data every second
    _pollingTimer?.cancel();
    _pollingTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      add(_DashboardPollingTick());
    });
  }

  void _onStopPolling(DashboardStopPolling event, Emitter<DashboardState> emit) {
    _pollingTimer?.cancel();
    emit(state.copyWith(isPolling: false));
  }

  Future<void> _onPollingTick(_DashboardPollingTick event, Emitter<DashboardState> emit) async {
    if (!state.isPolling) return;

    try {
      int currentRpm = await _obdScanner.readEngineRpm();
      int currentSpeed = await _obdScanner.readVehicleSpeed();
      int currentTemp = await _obdScanner.readCoolantTemp();
      int currentLoad = await _obdScanner.readEngineLoad();
      int currentThrottle = await _obdScanner.readThrottlePosition();

      final newData = state.realtimeData.copyWith(
        rpm: currentRpm,
        speed: currentSpeed,
        coolantTemp: currentTemp,
        engineLoad: currentLoad,
        throttlePosition: currentThrottle,
        timestamp: DateTime.now(),
      );

      emit(state.copyWith(realtimeData: newData));

      // TODO: Додати `newData` у локальний масив (батчинг) для запису поїздки

    } catch (e) {
      emit(state.copyWith(errorMessage: "Помилка читання: $e"));
    }
  }

  // --- Заглушки для парсингу (перенесемо сюди логіку з твоїх стрімів) ---
  int _parseRpm(String raw) => 0; // Замінити на реальний парсинг
  int _parseSpeed(String raw) => 0; // Замінити на реальний парсинг

  @override
  Future<void> close() {
    _connectionSubscription?.cancel();
    _pollingTimer?.cancel();
    return super.close();
  }
}