import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/database/database.dart';
import '../../data/database/daos.dart';
import '../../services/obd_service/iobd_service.dart';

part 'car_event.dart';
part 'car_state.dart';

class CarBloc extends Bloc<CarEvent, CarState> {
  final CarsDao _carsDao;
  final IObdScanner _obdScanner;

  CarBloc(this._carsDao, this._obdScanner) : super(const CarState()) {
    on<LoadCars>(_onLoadCars);
    on<SelectCar>(_onSelectCar);
    on<SyncMileage>(_onSyncMileage);
  }

  Future<void> _onLoadCars(LoadCars event, Emitter<CarState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final cars = await _carsDao.getAllCars();
      // By default, make the first car in the list active (if it exists)
      final activeCar = cars.isNotEmpty ? cars.first : null;

      emit(state.copyWith(
          carsList: cars,
          activeCar: activeCar,
          isLoading: false
      ));
    } catch (e) {
      emit(state.copyWith(errorMessage: "Error loading cars: $e", isLoading: false));
    }
  }

  Future<void> _onSelectCar(SelectCar event, Emitter<CarState> emit) async {
    try {
      final selectedCar = state.carsList.firstWhere((c) => c.id == event.carId);
      emit(state.copyWith(activeCar: selectedCar));
    } catch (e) {
      emit(state.copyWith(errorMessage: "Car not found"));
    }
  }

  Future<void> _onSyncMileage(SyncMileage event, Emitter<CarState> emit) async {
    // If no car is selected or there's no connection, do nothing
    if (state.activeCar == null) return;

    emit(state.copyWith(isSyncing: true));

    try {
      // Read "Distance since codes cleared" from the adapter
      int currentObdDistance = await _obdScanner.readDistanceSinceCodesCleared();

      Car car = state.activeCar!;

      // Take previous saved values (if null, assume it's 0)
      int savedTotalDistance = car.savedTotalDistance ?? 0;
      int lastObdReading = car.lastObdReading ?? 0;
      bool accuracyWarning = car.isAccuracyWarning ?? false;

      int newTotalDistance = savedTotalDistance;

      // CHECKING LOGIC
      if (currentObdDistance >= lastObdReading) {
        // 1) Normal trip. Add only the difference.
        int delta = currentObdDistance - lastObdReading;
        newTotalDistance += delta;
      } else {
        // 2) Mileage was reset (currentObdDistance < lastObdReading).
        // Add the new odometer reading fully.
        newTotalDistance += currentObdDistance;
        // Turn on the accuracy warning indicator
        accuracyWarning = true;
      }

      // update car
      final updatedCar = car.copyWith(
        savedTotalDistance: newTotalDistance,
        lastObdReading: currentObdDistance,
        isAccuracyWarning: accuracyWarning,
      );

      // save to DB
      await _carsDao.insertOrUpdateCar(updatedCar);

      // update UI state
      emit(state.copyWith(
        activeCar: updatedCar,
        isSyncing: false,
      ));

    } catch (e) {
      emit(state.copyWith(
        errorMessage: "Error syncing mileage: $e",
        isSyncing: false,
      ));
    }
  }
}