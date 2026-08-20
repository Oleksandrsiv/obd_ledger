import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:drift/drift.dart' as drift;
import '../../../core/database/database.dart';
import '../../../core/services/obd_service/iobd_service.dart';
import '../../../core/services/trip_recording_service.dart';
import '../data/cars_dao.dart';
import '../repositories/vehicle_info_repository.dart';

part 'car_event.dart';
part 'car_state.dart';

class CarBloc extends Bloc<CarEvent, CarState> {
  final CarsDao _carsDao;
  final IObdScanner _obdScanner;
  final VehicleInfoRepository _vehicleInfoRepository;
  final TripRecordingService _tripRecordingService;

  StreamSubscription<bool>? _tripStatusSubscription;

  CarBloc(this._carsDao, this._obdScanner, this._vehicleInfoRepository, this._tripRecordingService) : super(const CarState()) {
    on<LoadCars>(_onLoadCars);
    on<SelectCar>(_onSelectCar);
    on<SyncMileage>(_onSyncMileage);
    on<ProcessScannedVin>(_onProcessScannedVin);
    on<RenameCar>(_onRenameCar);
    on<DeleteCarEvent>(_onDeleteCar);

    _tripStatusSubscription = _tripRecordingService.isTripActiveStream.listen((isTripActive) {
      if (!isTripActive) {
        add(SyncMileage());
      }
    });
  }

  @override
  Future<void> close() {
    _tripStatusSubscription?.cancel();
    return super.close();
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
      int? currentObdDistance = _tripRecordingService.lastKnownMileage;

      if (currentObdDistance == null) {
        // If the adapter didn't respond (engine off) — simply exit.
        // Remove the loading indicator and do not touch the database.
        emit(state.copyWith(isSyncing: false));
        return;
      }

      Car car = state.activeCar!;

      // Take previous saved values (if null, assume it's 0)
      int savedTotalDistance = car.savedTotalDistance ?? 0;
      int lastObdReading = car.lastObdReading ?? 0;
      bool accuracyWarning = car.isAccuracyWarning ?? false;
      int newTotalDistance = savedTotalDistance;

      // CHECKING LOGIC
      if (lastObdReading == 0) {// First connection. Take the reference point, but don't add to mileage
      } else if (currentObdDistance >= lastObdReading) {
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
      // clear VIN from trash
      String cleanVin = event.vin.replaceAll(RegExp(r'[^A-HJ-NPR-Z0-9]'), '');
      if (cleanVin.length >= 17) {
        cleanVin = cleanVin.substring(cleanVin.length - 17);
      } else if (cleanVin.isEmpty) {
        cleanVin = "UNKNOWN_VIN";
      }

      Car? existingCar = await _carsDao.getCarByVin(cleanVin);

      if (existingCar == null) {
        final carName = await _vehicleInfoRepository.getCarName(cleanVin)
            ?? "New Car (${cleanVin.substring(cleanVin.length - 4)})";

        final newCarCompanion = CarsCompanion.insert(
          vin: cleanVin,
          name: drift.Value(carName),
        );
        await _carsDao.insertOrUpdateCar(newCarCompanion);

        existingCar = await _carsDao.getCarByVin(cleanVin);
      }

      // Update the list of garage and make this car active
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

  Future<void> _onRenameCar(RenameCar event, Emitter<CarState> emit) async {
    try {
      final carToRename = state.carsList.firstWhere((c) => c.id == event.carId);

      final updatedCar = carToRename.copyWith(name: drift.Value(event.newName));

      await _carsDao.insertOrUpdateCar(updatedCar);

      add(LoadCars());

    } catch (e) {
      emit(state.copyWith(errorMessage: "Error renaming car: $e"));
    }
  }

  Future<void> _onDeleteCar(
      DeleteCarEvent event,
      Emitter<CarState> emit,
      ) async {
    try {
      await _carsDao.deleteCar(event.carId);
      // After deleting, simply ask BLoC to reload the car list
      add(LoadCars());
    } catch (e) {
      emit(state.copyWith(errorMessage: "Failed to delete car: $e"));
    }
  }
}