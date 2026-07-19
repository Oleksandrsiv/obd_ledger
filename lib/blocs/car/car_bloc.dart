import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/database/daos/cars_dao.dart';
import '../../data/database/database.dart';
import '../../services/obd_service/iobd_service.dart';
import 'package:drift/drift.dart' as drift;
import '../../repositories/vehicle_info_repository.dart';

part 'car_event.dart';
part 'car_state.dart';

class CarBloc extends Bloc<CarEvent, CarState> {
  final CarsDao _carsDao;
  final IObdScanner _obdScanner;
  final VehicleInfoRepository _vehicleInfoRepository;

  CarBloc(this._carsDao, this._obdScanner, this._vehicleInfoRepository) : super(const CarState()) {
    on<LoadCars>(_onLoadCars);
    on<SelectCar>(_onSelectCar);
    on<SyncMileage>(_onSyncMileage);
    on<ProcessScannedVin>(_onProcessScannedVin);
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

  Future<void> _onProcessScannedVin(ProcessScannedVin event, Emitter<CarState> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      // Перевіряємо, чи є вже така машина в базі
      Car? existingCar = await _carsDao.getCarByVin(event.vin);

      if (existingCar == null) {
        // Якщо машини немає - запитуємо назву через API
        final carName = await _vehicleInfoRepository.getCarName(event.vin)
            ?? "New Car (${event.vin.substring(event.vin.length - 4)})";

        // Створюємо новий запис в БД
        final newCarCompanion = CarsCompanion.insert(
          vin: event.vin,
          name: drift.Value(carName),
        );
        await _carsDao.insertOrUpdateCar(newCarCompanion);

        // Витягуємо щойно створену машину з БД, щоб отримати її згенерований ID
        existingCar = await _carsDao.getCarByVin(event.vin);
      }

      // Оновлюємо список гаража та робимо цю машину активною
      final allCars = await _carsDao.getAllCars();
      emit(state.copyWith(
        carsList: allCars,
        activeCar: existingCar,
        isLoading: false,
      ));

    } catch (e) {
      emit(state.copyWith(
          errorMessage: "Error processing VIN: $e",
          isLoading: false
      ));
    }
  }
}