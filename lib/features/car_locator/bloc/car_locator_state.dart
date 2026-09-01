import 'package:latlong2/latlong.dart';

class CarLocatorState {
  final LatLng? carPosition;
  final LatLng? userPosition;
  final bool isLoading;
  final String? errorMessage;

  const CarLocatorState({
    this.carPosition,
    this.userPosition,
    this.isLoading = true,
    this.errorMessage,
  });

  CarLocatorState copyWith({
    LatLng? carPosition,
    LatLng? userPosition,
    bool? isLoading,
    String? errorMessage,
  }) {
    return CarLocatorState(
      carPosition: carPosition ?? this.carPosition,
      userPosition: userPosition ?? this.userPosition,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage, 
    );
  }
}