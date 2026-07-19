import 'dart:developer';
import 'package:drift/drift.dart';
import '../data/database/daos/cars_dao.dart';
import '../services/nhtsa_api/nhtsa_api_client.dart';

class VehicleInfoRepository {
  final CarsDao _carsDao;
  final NhtsaApiClient _apiClient;

  VehicleInfoRepository(this._carsDao, this._apiClient);

  /// Returns the car name by VIN code.
  /// first locally, then via API.
  Future<String?> getCarName(String vin) async {
    // Check if such a car exists in our database
    final localCar = await _carsDao.getCarByVin(vin);

    if (localCar != null && localCar.name != null) {
      return localCar.name;
    }

    // If there's no name (or the car doesn't exist in the database), make an API request
    try {
      String? apiName = await _apiClient.fetchCarName(vin);

      // If the car already exists in the database but is missing a name, update the row in the DB
      if (localCar != null) {
        final updatedCar = localCar.copyWith(
          name: Value(apiName),
        );
        await _carsDao.insertOrUpdateCar(updatedCar);
      }

      return apiName;

    } catch (e) {
      // If there's no internet or the API fails
      log("API error: $e");

      return null;
    }
  }
}