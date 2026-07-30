part of 'car_bloc.dart';

class CarState {
  final List<Car> carsList;
  final Car? activeCar;
  final bool isLoading;
  final bool isSyncing;
  final String? errorMessage;

  const CarState({
    this.carsList = const [],
    this.activeCar,
    this.isLoading = false,
    this.isSyncing = false,
    this.errorMessage,
  });

  CarState copyWith({
    List<Car>? carsList,
    Car? activeCar,
    bool? isLoading,
    bool? isSyncing,
    String? errorMessage,
  }) {
    return CarState(
      carsList: carsList ?? this.carsList,
      activeCar: activeCar ?? this.activeCar,
      isLoading: isLoading ?? this.isLoading,
      isSyncing: isSyncing ?? this.isSyncing,
      errorMessage: errorMessage,
    );
  }
}