
enum ObdConnectionState { disconnected, connecting, connected, error }

abstract interface class IObdScanner {

  Future<bool> connect(String deviceId);

  Future<void> disconnect();

  Stream<ObdConnectionState> get connectionState;

  /// one-time requests
  Future<String> readVin();

  Future<List<String>> readTroubleCodes();

  Future<bool> clearTroubleCodes();

  Future<int?> readDistanceSinceCodesCleared();

  /// Real-time requests
  Future<int> readEngineRpm();

  Future<int> readVehicleSpeed();

  Future<int> readCoolantTemp();

  Future<int> readEngineOilTemp();

  Future<int> readThrottlePosition();

  Future<int> readEngineLoad();

  Future<int> readIntakeAirTemp();

  Future<double> readMAF();

  Future<int> readFuelLevel();

  Future<String> readBatteryVoltage();

  /// for raw requests
  Future<String> sendRawCommand(String hexCommand);
}