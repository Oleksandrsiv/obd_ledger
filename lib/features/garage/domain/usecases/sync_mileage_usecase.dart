import '../../../../core/database/database.dart';
import '../../../../core/services/trip_recording_service.dart';
import '../../data/cars_dao.dart';

class SyncMileageUseCase {
  final CarsDao _carsDao;
  final TripRecordingService _tripRecordingService;

  SyncMileageUseCase(this._carsDao, this._tripRecordingService);

  Future<Car?> execute(Car activeCar) async {
    if (activeCar.id != _tripRecordingService.connectedCarId) {
      return null;
    }

    int? currentObdDistance = _tripRecordingService.lastKnownMileage;
    if (currentObdDistance == null) return null;

    // Take previous saved values (if null, assume it's 0)
    int savedTotalDistance = activeCar.savedTotalDistance ?? 0;
    int lastObdReading = activeCar.lastObdReading ?? 0;
    bool accuracyWarning = activeCar.isAccuracyWarning ?? false;
    int newTotalDistance = savedTotalDistance;

    // CHECKING LOGIC
    if (lastObdReading == 0) {
      // First connection. Take the reference point, but don't add to mileage
    } else if (currentObdDistance >= lastObdReading) {
      // Normal trip. Add only the difference.
      int delta = currentObdDistance - lastObdReading;
      newTotalDistance += delta;
    } else {
      // Mileage was reset (currentObdDistance < lastObdReading).
      // Add the new odometer reading fully.
      newTotalDistance += currentObdDistance;
      accuracyWarning = true;
    }

    // update car
    final updatedCar = activeCar.copyWith(
      savedTotalDistance: newTotalDistance,
      lastObdReading: currentObdDistance,
      isAccuracyWarning: accuracyWarning,
    );

    await _carsDao.insertOrUpdateCar(updatedCar);

    return updatedCar;
  }
}