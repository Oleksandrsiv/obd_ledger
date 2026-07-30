import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import '../services/obd_service/iobd_service.dart';

class BluetoothState {
  final List<BluetoothDevice> bondedDevices;
  final String? selectedMacAddress;
  final bool isLoading;
  final String? errorMessage;
  final ObdConnectionState connectionStatus;
  final String? connectedVin;

  BluetoothState({
    this.bondedDevices = const [],
    this.selectedMacAddress,
    this.isLoading = false,
    this.errorMessage,
    this.connectionStatus = ObdConnectionState.disconnected,
    this.connectedVin,
  });

  BluetoothState copyWith({
    List<BluetoothDevice>? bondedDevices,
    String? selectedMacAddress,
    bool? isLoading,
    String? errorMessage,
    ObdConnectionState? connectionStatus,
    bool clearError = false,
    String? connectedVin,
    bool clearVin = false,
  }) {
    return BluetoothState(
      bondedDevices: bondedDevices ?? this.bondedDevices,
      selectedMacAddress: selectedMacAddress ?? this.selectedMacAddress,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      connectionStatus: connectionStatus ?? this.connectionStatus,
      connectedVin: clearVin ? null : (connectedVin ?? this.connectedVin),
    );
  }
}