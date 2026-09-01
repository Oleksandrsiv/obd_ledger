import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart' hide BluetoothState;
import 'package:obd_ledger/core/bluetooth/permission_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bluetooth_prefs_repository.dart';
import 'bluetooth_state.dart';
import '../services/obd_service/iobd_service.dart';



class BluetoothCubit extends Cubit<BluetoothState> {
  final BluetoothPrefsRepository _prefsRepository;
  final IObdScanner _obdScanner;
  final PermissionService _permissionService;

  static const String _macKey = 'selected_obd_mac';

  StreamSubscription? _connectionSubscription;

  BluetoothCubit(this._prefsRepository, this._permissionService, this._obdScanner) : super(BluetoothState()) {
    _init();
  }

  Future<void> _init() async {
    emit(state.copyWith(isLoading: true));

    _connectionSubscription = _obdScanner.connectionState.listen((status) {
      emit(state.copyWith(connectionStatus: status));
    });

    final hasPermissions = await _permissionService.requestAllRequired();
    if (!hasPermissions) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Required permissions for Bluetooth operation denied',
      ));
      return;
    }

    try {
      // Getting list of already paired devices
      List<BluetoothDevice> devices = await FlutterBluetoothSerial.instance.getBondedDevices();

      String? defaultMac = _prefsRepository.getSelectedMac();

      // If nothing is stored in memory, trying to find a device with the word "OBD"
      if (defaultMac == null && devices.isNotEmpty) {
        try {
          final obdDevice = devices.firstWhere(
                (d) => d.name?.toLowerCase().contains('obd') ?? false,
          );
          defaultMac = obdDevice.address;
          await _prefsRepository.saveSelectedMac(defaultMac);
        } catch (_) {
          // If there are no OBD named devices, nothing is selected
        }
      }

      emit(state.copyWith(
        bondedDevices: devices,
        selectedMacAddress: defaultMac,
        isLoading: false,
      ));

      // If we found a saved MAC,
      // we attempt to connect to it immediately
      if (defaultMac != null) {
        connectToDevice(defaultMac);
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Bluetooth error: $e',
      ));
    }
  }

  Future<void> selectDevice(String macAddress) async {
    await _prefsRepository.saveSelectedMac(macAddress);
    emit(state.copyWith(selectedMacAddress: macAddress));

    // When changing devices, disconnect from the old one and connect to the new one.
    await disconnect();
    await connectToDevice(macAddress);
  }


  Future<void> connectToDevice(String macAddress) async {
    if (state.connectionStatus == ObdConnectionState.connecting ||
        state.connectionStatus == ObdConnectionState.connected) {
      return;
    }

    emit(state.copyWith(
      connectionStatus: ObdConnectionState.connecting,
      clearError: true,
      clearVin: true,
    ));

    final success = await _obdScanner.connect(macAddress);

    if (!success) {
      emit(state.copyWith(
        errorMessage: 'Failed to connect to device',
      ));
    } else {
      emit(state.copyWith(clearError: true));

      try {
        final vin = await _obdScanner.readVin();
        if (vin.isNotEmpty) {
          emit(state.copyWith(connectedVin: vin));
        }
      } catch (e) {
        emit(state.copyWith(errorMessage: 'Connected, but failed to read VIN'));
      }
    }
  }

  Future<void> disconnect() async {
    await _obdScanner.disconnect();
  }

  // Close the connection when the Cubit is destroyed (e.g., when closing the app)
  @override
  Future<void> close() {
    _connectionSubscription?.cancel();
    _obdScanner.disconnect();
    return super.close();
  }
}
