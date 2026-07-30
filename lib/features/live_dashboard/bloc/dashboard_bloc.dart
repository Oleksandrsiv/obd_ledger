import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/services/obd_service/iobd_service.dart';
import '../../../core/services/trip_recording_service.dart';
import '../data/realtime_data_model.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final TripRecordingService _tripService;
  StreamSubscription<RealtimeData>? _dataSubscription;

  bool _isRecordingTrip = false;

  DashboardBloc(this._tripService) : super(DashboardState.initial()) {
    on<DashboardStartPolling>(_onStartPolling);
    on<DashboardStopPolling>(_onStopPolling);
    on<_DashboardDataReceived>(_onDataReceived);
  }

  void _onStartPolling(DashboardStartPolling event, Emitter<DashboardState> emit) {
    emit(state.copyWith(isPolling: true));

    _tripService.startPolling(event.carId);

    _dataSubscription?.cancel();
    _dataSubscription = _tripService.realtimeDataStream.listen((data) {
      add(_DashboardDataReceived(data));
    });
  }

  void _onDataReceived(_DashboardDataReceived event, Emitter<DashboardState> emit) {
    final currentData = event.data;

    emit(state.copyWith(realtimeData: currentData));

    if (currentData.rpm > 0 && !_isRecordingTrip) {
      _isRecordingTrip = true;
      _tripService.startRecordingToDatabase();
    }
    else if (currentData.rpm == 0 && _isRecordingTrip) {
      _isRecordingTrip = false;
      _tripService.stopRecordingToDatabase();
    }
  }

  void _onStopPolling(DashboardStopPolling event, Emitter<DashboardState> emit) {
    _dataSubscription?.cancel();
    _tripService.stopPolling();

    if (_isRecordingTrip) {
      _tripService.stopRecordingToDatabase();
      _isRecordingTrip = false;
    }

    emit(state.copyWith(isPolling: false));
  }

  @override
  Future<void> close() {
    _dataSubscription?.cancel();

    _tripService.stopPolling();

    if (_isRecordingTrip) {
      _tripService.stopRecordingToDatabase();
    }

    return super.close();
  }
}