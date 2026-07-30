

// Model for parsing NHTSA result
class VehicleData {
  final String make;
  final String model;
  final String modelYear;

  VehicleData({
    required this.make,
    required this.model,
    required this.modelYear,
  });

  factory VehicleData.fromJson(Map<String, dynamic> json) {
    return VehicleData(
      make: json['Make'] ?? '',
      model: json['Model'] ?? '',
      modelYear: json['ModelYear'] ?? '',
    );
  }

  String get fullName => '$make $model $modelYear'.trim();
}