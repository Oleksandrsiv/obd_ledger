import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'model_vehicle.dart';

class NhtsaApiClient {
  static const String _baseUrl = 'https://vpic.nhtsa.dot.gov/api/vehicles/DecodeVinValuesExtended';

  Future<String?> fetchCarName(String vin) async {
    try {
      final url = Uri.parse('$_baseUrl/$vin?format=json');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final results = data['Results'] as List<dynamic>?;

        if (results != null && results.isNotEmpty) {
          final vehicle = VehicleData.fromJson(results.first);

          // NHTSA may return empty fields if the VIN is incorrect.
          // check if we actually received a real car brand.
          if (vehicle.make.isNotEmpty) {
            return vehicle.fullName;
          }
        }
      }
      return null;
    } catch (e) {
      log("NHTSA API Error: $e");
      return null;
    }
  }
}