import 'dart:developer';
import 'package:drift/drift.dart';
import '../../../core/services/nhtsa_api/nhtsa_api_client.dart';
import '../data/cars_dao.dart';

class VehicleInfoRepository {
  final CarsDao _carsDao;
  final NhtsaApiClient _apiClient;

  VehicleInfoRepository(this._carsDao, this._apiClient);

  /// Cleans and validates the raw VIN string from the ELM using a three-layer method.
  String _cleanAndValidateVin(String rawVin) {
    String cleaned = rawVin
        .replaceAll('SEARCHING...', '')
        .replaceAll('\r', '')
        .replaceAll('\n', '')
        .replaceAll('>', '')
        .replaceAll(' ', '')
        .trim();

    // Looking for a valid 17-digit pattern (standard VIN)
    final RegExp vinRegex = RegExp(r'[A-HJ-NPR-Z0-9]{17}');
    final match = vinRegex.firstMatch(cleaned);

    if (match != null) {
      return match.group(0)!;
    }

    // If the length exceeds 17, take the last chunk (common in CAN responses)
    if (cleaned.length >= 17) {
      return cleaned.substring(cleaned.length - 17);
    }

    // If the adapter returned a complete mess, return it as is (but at least without spaces and "SEARCHING")
    return cleaned;
  }

  /// Returns the car name by VIN code.
  /// first locally, then via API.
  Future<String?> getCarName(String rawVin) async {

    final vin = _cleanAndValidateVin(rawVin);

    // Check: if, after cleaning, it still doesn't look like a valid VIN
    if (vin.length < 5) {
      log("Invalid VIN received: '$rawVin' (cleaned: '$vin')");
      return null;
    }

    // Check if such a car exists in our database
    final localCar = await _carsDao.getCarByVin(vin);

    if (localCar != null && localCar.name != null) {
      return localCar.name;
    }

    // If there's no name (or the car doesn't exist in the database), make an API request
    try {
      String? apiName = await _apiClient.fetchCarName(vin);

      // If the API returned nothing (e.g., native JDM or no internet connection)
      apiName ??= "OBD Car (${vin.length >= 4 ? vin.substring(vin.length - 4) : vin})";

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

      return "OBD Car (${vin.length >= 4 ? vin.substring(vin.length - 4) : vin})";
    }
  }
}