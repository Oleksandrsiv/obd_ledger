import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart' hide BluetoothState;
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bluetooth_state.dart';
import '../services/obd_service/iobd_service.dart';



class BluetoothCubit extends Cubit<BluetoothState> {
  final SharedPreferences _prefs;
  final IObdScanner _obdScanner;
  static const String _macKey = 'selected_obd_mac';

  StreamSubscription? _connectionSubscription;

  BluetoothCubit(this._prefs, this._obdScanner) : super(BluetoothState()) {
    _init();
  }

  Future<void> _init() async {
    emit(state.copyWith(isLoading: true));

    _connectionSubscription = _obdScanner.connectionState.listen((status) {
      emit(state.copyWith(connectionStatus: status));
    });

    final savedMac = _prefs.getString(_macKey);

    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetooth,
      Permission.bluetoothConnect,
      Permission.bluetoothScan,
    ].request();

    if (statuses.values.any((status) => status.isDenied)) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Required permissions for Bluetooth operation',
      ));
      return;
    }

      // Notification request
      // Works on Android 13+
      if (await Permission.notification.isDenied) {
        await Permission.notification.request();
      }

      // Request to ignore battery optimization (To keep GPS from sleeping)
      if (await Permission.ignoreBatteryOptimizations.isDenied) {
        // This request will bring up a system window where the user will be prompted
        // "Allow the app to run in the background without restrictions"
        await Permission.ignoreBatteryOptimizations.request();
      }

      // Check the location in the background (if not already requested)
      if (await Permission.locationAlways.isDenied) {
        await Permission.locationAlways.request();
      }

    try {
      // Getting list of already paired devices
      List<BluetoothDevice> devices =
      await FlutterBluetoothSerial.instance.getBondedDevices();

      String? defaultMac = savedMac;

      // If nothing is stored in memory, trying to find a device with the word "OBD"
      if (defaultMac == null && devices.isNotEmpty) {
        try {
          final obdDevice = devices.firstWhere(
                (d) => d.name?.toLowerCase().contains('obd') ?? false,
          );
          defaultMac = obdDevice.address;
          await _prefs.setString(_macKey, defaultMac);
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
    await _prefs.setString(_macKey, macAddress);
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
