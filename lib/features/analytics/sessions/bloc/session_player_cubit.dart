import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/trips_dao.dart';
import 'session_player_state.dart';

class SessionPlayerCubit extends Cubit<SessionPlayerState> {
  final TripsDao _tripsDao;

  SessionPlayerCubit(this._tripsDao) : super(const SessionPlayerState());

  Future<void> loadSession(int tripId) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      // Get all trip points from the database
      final points = await _tripsDao.getPointsForTrip(tripId);

      if (points.isEmpty) {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: 'No telemetry data found for this session.',
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          points: points,
          currentIndex: 0,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Error loading session: $e',
      ));
    }
  }

  // The method is called every time the user drags the slider
  void updateIndex(double newIndex) {
    if (state.points.isEmpty) return;

    // Slider returns double, convert to int
    final index = newIndex.round();

    // Array overflow protection
    if (index >= 0 && index < state.points.length) {
      emit(state.copyWith(currentIndex: index));
    }
  }
}