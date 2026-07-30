import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/trips_dao.dart';
import 'analytics_event.dart';
import 'analytics_state.dart';

class AnalyticsBloc extends Bloc<AnalyticsEvent, AnalyticsState> {
  final TripsDao _tripsDao;

  AnalyticsBloc(this._tripsDao) : super(const AnalyticsState()) {
    on<LoadAnalyticsData>(_onLoadAnalyticsData);
  }

  Future<void> _onLoadAnalyticsData(LoadAnalyticsData event, Emitter<AnalyticsState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final trips = await _tripsDao.getTripsForCar(event.carId);
      emit(state.copyWith(allTrips: trips, isLoading: false));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }
}