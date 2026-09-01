import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../analytics/data/trips_dao.dart';
import 'car_locator_state.dart';

class CarLocatorCubit extends Cubit<CarLocatorState> {
  final TripsDao _tripsDao;
  final int _carId;
  StreamSubscription<Position>? _positionSubscription;

  CarLocatorCubit(this._tripsDao, this._carId) : super(const CarLocatorState()) {
    _init();
  }

  Future<void> _init() async {
    emit(state.copyWith(isLoading: true));

    try {
      final tripPoint = await _tripsDao.getLastKnownPosition(_carId);
      LatLng? carLatLng;
      if (tripPoint != null && tripPoint.latitude != null && tripPoint.longitude != null) {
        carLatLng = LatLng(tripPoint.latitude!, tripPoint.longitude!);
      }

      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        emit(state.copyWith(
            carPosition: carLatLng,
            isLoading: false,
            errorMessage: "Location services are disabled on your device."
        ));
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          emit(state.copyWith(
              carPosition: carLatLng,
              isLoading: false,
              errorMessage: "Location permissions are denied."
          ));
          return;
        }
      }

      // capture the user's current position to avoid waiting for the stream's first "tick."
      final initialPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high
      );
      emit(state.copyWith(
        carPosition: carLatLng,
        userPosition: LatLng(initialPosition.latitude, initialPosition.longitude),
        isLoading: false,
      ));

      // Subscribing to the stream (updating the UI every 2 meters)
      _positionSubscription = Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 2,
        ),
      ).listen((Position position) {
        // When the user takes a step, we simply update userPosition in the system.
        emit(state.copyWith(
          userPosition: LatLng(position.latitude, position.longitude),
        ));
      });

    } catch (e) {
      emit(state.copyWith(
          isLoading: false,
          errorMessage: "Failed to load location data: $e"
      ));
    }
  }

  @override
  Future<void> close() {
    _positionSubscription?.cancel();
    return super.close();
  }
}