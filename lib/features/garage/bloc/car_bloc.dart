import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:drift/drift.dart' as drift;
import '../../../core/database/database.dart';
import '../../../core/services/trip_recording_service.dart';
import '../data/cars_dao.dart';
import '../domain/usecases/process_scanned_vin_usecase.dart';
import '../domain/usecases/sync_mileage_usecase.dart';

part 'car_event.dart';
part 'car_state.dart';

class CarBloc extends Bloc<CarEvent, CarState> {
  final CarsDao _carsDao;
  final TripRecordingService _tripRecordingService;

  final ProcessScannedVinUseCase _processVinUseCase;
  final SyncMileageUseCase _syncMileageUseCase;

  StreamSubscription<bool>? _tripStatusSubscription;

  CarBloc(
      this._carsDao,
      this._tripRecordingService,
      this._processVinUseCase,
      this._syncMileageUseCase,
      ) : super(const CarState()) {
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
    if (state.activeCar == null) return;

    emit(state.copyWith(isSyncing: true));
    try {
      final updatedCar = await _syncMileageUseCase.execute(state.activeCar!);

      if (updatedCar != null) {
        emit(state.copyWith(activeCar: updatedCar, isSyncing: false));
      } else {
        emit(state.copyWith(isSyncing: false));
      }
    } catch (e) {
      emit(state.copyWith(errorMessage: "Error syncing mileage: $e", isSyncing: false));
    }
  }

  Future<void> _onProcessScannedVin(ProcessScannedVin event, Emitter<CarState> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      final processedCar = await _processVinUseCase.execute(event.vin);

      _tripRecordingService.setConnectedCarId(processedCar.id);

      // Update the list of garage and make this car active
      final allCars = await _carsDao.getAllCars();
      emit(state.copyWith(
        carsList: allCars,
        activeCar: processedCar,
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
      log("Failed to delete car: $e");
      emit(state.copyWith(errorMessage: "Failed to delete car: $e"));
    }
  }
}