import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  Future<bool> requestAllRequired() async {


    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetooth,
      Permission.bluetoothConnect,
      Permission.bluetoothScan,
    ].request();

    if (statuses.values.any((status) => status.isDenied)) {
      return false;
    }

    // Notification request
    // Works on Android 13+
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }


    // Request to ignore battery optimization (To keep GPS from sleeping)
    if (await Permission.ignoreBatteryOptimizations.isDenied) {
      await Permission.ignoreBatteryOptimizations.request();
    }

    // Check the location in the background (if not already requested)
    if (await Permission.locationAlways.isDenied) {
      await Permission.locationAlways.request();
    }

    return true;
  }
}