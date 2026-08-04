class RealtimeData {
  final int speed;
  final int rpm;
  final int coolantTemp;
  final int engineOilTemp;
  final int engineLoad;
  final int throttlePosition;
  final DateTime timestamp;
  final int intakeAirTemp;
  final double maf;
  final int fuelLevel;
  final String batteryVoltage;

  const RealtimeData({
    required this.speed,
    required this.rpm,
    required this.coolantTemp,
    required this.engineOilTemp,
    required this.engineLoad,
    required this.throttlePosition,
    required this.timestamp,
    required this.intakeAirTemp,
    required this.maf,
    required this.fuelLevel,
    required this.batteryVoltage,
  });

  factory RealtimeData.initial() {
    return RealtimeData(
      speed: 0,
      rpm: 0,
      coolantTemp: 0,
      engineOilTemp:0,
      engineLoad: 0,
      throttlePosition: 0,
      intakeAirTemp: 0,
      maf: 0.0,
      fuelLevel: 0,
      batteryVoltage: "--",
      timestamp: DateTime.now(),
    );
  }

  RealtimeData copyWith({
    int? speed,
    int? rpm,
    int? coolantTemp,
    int? engineOilTemp,
    int? engineLoad,
    int? throttlePosition,
    int? intakeAirTemp,
    double? maf,
    int? fuelLevel,
    String? batteryVoltage,
    DateTime? timestamp,
  }) {
    return RealtimeData(
      speed: speed ?? this.speed,
      rpm: rpm ?? this.rpm,
      coolantTemp: coolantTemp ?? this.coolantTemp,
      engineOilTemp: engineOilTemp?? this.engineOilTemp,
      engineLoad: engineLoad ?? this.engineLoad,
      throttlePosition: throttlePosition ?? this.throttlePosition,
      intakeAirTemp: intakeAirTemp ?? this.intakeAirTemp,
      maf: maf ?? this.maf,
      fuelLevel: fuelLevel ?? this.fuelLevel,
      batteryVoltage: batteryVoltage ?? this.batteryVoltage,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  String toString() {
    return 'RealtimeData(speed: $speed, rpm: $rpm, coolantTemp: $coolantTemp, engineOilTemp: $engineOilTemp, '
        'load: $engineLoad, throttle: $throttlePosition, intakeAirTemp: $intakeAirTemp, maf: $maf, fuelLevel: $fuelLevel, batteryVoltage: $batteryVoltage, timestamp: $timestamp)';
  }
}