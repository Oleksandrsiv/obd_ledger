
enum ObdConnectionState { disconnected, connecting, connected, error }

abstract interface class IObdScanner {

  Future<bool> connect(String deviceId);

  Future<void> disconnect();

  Stream<ObdConnectionState> get connectionState;

  /// one-time requests
  Future<String> readVin();

  Future<List<String>> readTroubleCodes();

  Future<bool> clearTroubleCodes();

  Future<int> readDistanceSinceCodesCleared();

  /// stream data
  Stream<int> get engineRpmStream;

  Stream<int> get vehicleSpeedStream;

  Stream<int> get coolantTempStream;

  Stream<int> get throttlePositionStream;

  Stream<int> get engineLoadStream;

  /// for raw requests
  Future<String> sendRawCommand(String hexCommand);
}