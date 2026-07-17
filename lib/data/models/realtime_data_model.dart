class RealtimeData {
  final int speed;
  final int rpm;
  final int coolantTemp;
  final int engineLoad;
  final int throttlePosition;
  final DateTime timestamp;

  const RealtimeData({
    required this.speed,
    required this.rpm,
    required this.coolantTemp,
    required this.engineLoad,
    required this.throttlePosition,
    required this.timestamp,
  });

  factory RealtimeData.initial() {
    return RealtimeData(
      speed: 0,
      rpm: 0,
      coolantTemp: 0,
      engineLoad: 0,
      throttlePosition: 0,
      timestamp: DateTime.now(),
    );
  }

  RealtimeData copyWith({
    int? speed,
    int? rpm,
    int? coolantTemp,
    int? engineLoad,
    int? throttlePosition,
    DateTime? timestamp,
  }) {
    return RealtimeData(
      speed: speed ?? this.speed,
      rpm: rpm ?? this.rpm,
      coolantTemp: coolantTemp ?? this.coolantTemp,
      engineLoad: engineLoad ?? this.engineLoad,
      throttlePosition: throttlePosition ?? this.throttlePosition,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  String toString() {
    return 'RealtimeData(speed: $speed, rpm: $rpm, temp: $coolantTemp, load: $engineLoad, throttle: $throttlePosition)';
  }
}