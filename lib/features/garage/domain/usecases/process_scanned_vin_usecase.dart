import 'package:drift/drift.dart' as drift;
import '../../../../core/database/database.dart';
import '../../data/cars_dao.dart';
import '../../repositories/vehicle_info_repository.dart';

class ProcessScannedVinUseCase {
  final CarsDao _carsDao;
  final VehicleInfoRepository _vehicleInfoRepository;

  ProcessScannedVinUseCase(this._carsDao, this._vehicleInfoRepository);

  Future<Car> execute(String rawVin) async {
    // clear VIN from trash
    String cleanVin = rawVin.replaceAll(RegExp(r'[^A-HJ-NPR-Z0-9]'), '');
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

    return existingCar!;
  }
}