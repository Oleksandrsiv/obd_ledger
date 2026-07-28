part of 'car_bloc.dart';

sealed class CarEvent {}

/// Load a list of all cars from the database
class LoadCars extends CarEvent {}

/// Make a car active
class SelectCar extends CarEvent {
  final int carId;
  SelectCar(this.carId);
}

/// Called every time OBD successfully connects.
class SyncMileage extends CarEvent {}

class AddCar extends CarEvent {
  final String vin;
  final int initialMileage;

  AddCar(this.vin, this.initialMileage);
}

class ProcessScannedVin extends CarEvent {
  final String vin;

  ProcessScannedVin(this.vin);
}

class RenameCar extends CarEvent {
  final int carId;
  final String newName;

  RenameCar(this.carId, this.newName);
}