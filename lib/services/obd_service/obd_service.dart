import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import 'iobd_service.dart';

class ObdService implements IObdScanner {
  BluetoothConnection? _connection;

  // Controller for tracking connection state
  final _stateController = StreamController<ObdConnectionState>.broadcast();
  ObdConnectionState _currentState = ObdConnectionState.disconnected;

  // Buffer for accumulating responses
  final StringBuffer _buffer = StringBuffer();
  Completer<String>? _responseCompleter;

  void _updateState(ObdConnectionState state) {
    _currentState = state;
    _stateController.add(state);
  }

  /// Handle incoming data from the adapter
  void _onDataReceived(Uint8List data) {
    String chunk = ascii.decode(data);
    _buffer.write(chunk);

    // The '>' symbol indicates that the adapter has finished responding
    if (chunk.contains('>')) {
      if (_responseCompleter != null && !_responseCompleter!.isCompleted) {
        _responseCompleter!.complete(_buffer.toString());
      }
      _buffer.clear();
    }
  }

  /// send command and waiting for response
  Future<String> _sendCommand(String command) async {
    if (_connection == null || !_connection!.isConnected) {
      throw Exception("No connection");
    }

    _responseCompleter = Completer<String>();
    _connection!.output.add(ascii.encode("$command\r"));
    await _connection!.output.allSent;

    String rawResponse = await _responseCompleter!.future;
    return _cleanResponse(rawResponse);
  }

  String _cleanResponse(String response) {
    return response.replaceAll(RegExp(r'[\r\n\s>]'), '');
  }

  /// basic settings
  Future<void> _initElm() async {
    await _sendCommand("ATZ"); // reset
    await _sendCommand("ATE0"); // turn off echo (to avoid duplicating our commands)
    await _sendCommand("ATL0"); // turn off line feeds
    await _sendCommand("ATSP0"); // automatic protocol search
  }

  @override
  Future<bool> connect(String address) async {
    try {
      _updateState(ObdConnectionState.connecting);

      // open connection by MAC
      _connection = await BluetoothConnection.toAddress(address);
      _updateState(ObdConnectionState.connected);

      _connection!.input!.listen(_onDataReceived).onDone(() {
        _updateState(ObdConnectionState.disconnected);
      });

      await _initElm();
      return true;
    } catch (e) {
      log("Error connecting: $e");
      _updateState(ObdConnectionState.error);
      return false;
    }
  }

  @override
  Future<void> disconnect() async {
    await _connection?.close();
    _connection = null;
    _updateState(ObdConnectionState.disconnected);
  }

  @override
  Future<String> readVin() async {
    String response = await _sendCommand("0902");
    return response;
  }

  @override
  Stream<int> get engineRpmStream {
    return Stream.periodic(const Duration(seconds: 1)).asyncMap((_) async {
      if (_currentState != ObdConnectionState.connected) return 0;

      try {
        String response = await _sendCommand("010C");
        // if response successful => 410C
        if (response.startsWith("410C") && response.length >= 8) {
          // Extract bytes A and B (2 HEX symbols each)
          String hexA = response.substring(4, 6);
          String hexB = response.substring(6, 8);

          int a = int.parse(hexA, radix: 16);
          int b = int.parse(hexB, radix: 16);

          // Formula for OBD2 RPM: ((A * 256) + B) / 4
          return ((a * 256) + b) ~/ 4;
        }
      } catch (e) {
        log("Error reading RPM: $e");
      }
      return 0;
    });
  }

  @override
  Future<int> readDistanceSinceCodesCleared() async {
    String response = await _sendCommand("0131");

    if (response.startsWith("4131") && response.length >= 8) {
      String hexA = response.substring(4, 6);
      String hexB = response.substring(6, 8);

      int a = int.parse(hexA, radix: 16);
      int b = int.parse(hexB, radix: 16);

      return (a * 256) + b;
    }
    return 0;
  }

  @override
  Future<bool> clearTroubleCodes() async {
    if (_currentState != ObdConnectionState.connected) return false;
    try {
      // Command Mode 04 - clear DTC and reset Check Engine
      String response = await _sendCommand("04");
      // Successful response is usually '44' or just 'OK' from the adapter itself
      return response.contains("44") || response.contains("OK");
    } catch (e) {
      log("Error clearing codes: $e");
      return false;
    }
  }

  @override
  Future<List<String>> readTroubleCodes() async {
    if (_currentState != ObdConnectionState.connected) return [];

    try {
      // Command Mode 03 - read active trouble codes
      String response = await _sendCommand("03");
      List<String> codes = [];

      if (response.startsWith("43")) {
        String data = response.substring(2); // Remove the '43' marker

        // Each trouble code occupies 4 HEX characters (2 bytes)
        for (int i = 0; i < data.length; i += 4) {
          if (i + 4 <= data.length) {
            String hexCode = data.substring(i, i + 4);
            if (hexCode != "0000") { // 0000 mean empty slot
              codes.add(_decodeDtc(hexCode));
            }
          }
        }
      }
      return codes;
    } catch (e) {
      log("Error reading codes: $e");
      return [];
    }
  }

  /// Internal method for decoding HEX to trouble code format (e.g., P0133)
  String _decodeDtc(String hex) {
    if (hex.length != 4) return hex;

    int firstHex = int.parse(hex[0], radix: 16);
    String systemLetter = "";

    // First 2 bits of the first character determine the system letter
    switch (firstHex >> 2) {
      case 0: systemLetter = "P"; break; // Powertrain (Engine/Transmission)
      case 1: systemLetter = "C"; break; // Chassis (Chassis/ABS)
      case 2: systemLetter = "B"; break; // Body
      case 3: systemLetter = "U"; break; // User Network
    }

    // Next 2 bits - this is the first digit
    int firstDigit = firstHex & 3;

    return "$systemLetter$firstDigit${hex.substring(1)}";
  }

  @override
  Future<String> sendRawCommand(String hexCommand) async {
    return await _sendCommand(hexCommand);
  }

  @override
  Stream<ObdConnectionState> get connectionState => _stateController.stream;

  @override
  Stream<int> get vehicleSpeedStream {
    return Stream.periodic(const Duration(seconds: 1)).asyncMap((_) async {
      if (_currentState != ObdConnectionState.connected) return 0;
      try {
        String response = await _sendCommand("010D");
        // Expected response: 410D XX (where XX is the speed in HEX)
        if (response.startsWith("410D") && response.length >= 6) {
          String hexA = response.substring(4, 6);
          return int.parse(hexA, radix: 16); // Formula: A (in km/h)
        }
      } catch (e) {
        log("Error reading speed: $e");
      }
      return 0;
    });
  }

  @override
  Stream<int> get coolantTempStream {
    return Stream.periodic(const Duration(seconds: 1)).asyncMap((_) async {
      if (_currentState != ObdConnectionState.connected) return 0;
      try {
        String response = await _sendCommand("0105");
        // Expected response: 4105 XX
        if (response.startsWith("4105") && response.length >= 6) {
          String hexA = response.substring(4, 6);
          return int.parse(hexA, radix: 16) - 40; // Formula: A - 40 (in °C)
        }
      } catch (e) {
        log("Error reading coolant temperature: $e");
      }
      return 0;
    });
  }

  @override
  Stream<int> get engineLoadStream {
    return Stream.periodic(const Duration(seconds: 1)).asyncMap((_) async {
      if (_currentState != ObdConnectionState.connected) return 0;
      try {
        String response = await _sendCommand("0104");
        if (response.startsWith("4104") && response.length >= 6) {
          String hexA = response.substring(4, 6);
          // Formula: A * 100 / 255 (in percentages %)
          return (int.parse(hexA, radix: 16) * 100) ~/ 255;
        }
      } catch (e) {
        log("Error reading engine load: $e");
      }
      return 0;
    });
  }

  @override
  Stream<int> get throttlePositionStream {
    return Stream.periodic(const Duration(seconds: 1)).asyncMap((_) async {
      if (_currentState != ObdConnectionState.connected) return 0;
      try {
        String response = await _sendCommand("0111");
        if (response.startsWith("4111") && response.length >= 6) {
          String hexA = response.substring(4, 6);
          // Formula: A * 100 / 255 (in percentages %)
          return (int.parse(hexA, radix: 16) * 100) ~/ 255;
        }
      } catch (e) {
        log("Error reading throttle position: $e");
      }
      return 0;
    });
  }

}