import 'dart:isolate';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';

@pragma('vm:entry-point')
void startCallback() {
  FlutterForegroundTask.setTaskHandler(ObdTaskHandler());
}

class ObdTaskHandler extends TaskHandler {
  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {
  }

  @override
  void onRepeatEvent(DateTime timestamp) {
  }

  @override
  Future<void> onDestroy(DateTime timestamp, bool isTaskRemoved) async {
  }

  @override
  void onReceiveData(Object data) {
    if (data is Map) {
      final rpm = data['rpm'] ?? 0;
      final speed = data['speed'] ?? 0;

      FlutterForegroundTask.updateService(
        notificationTitle: '🟢 OBD Ledger (Trip Active)',
        notificationText: 'RPM: $rpm  |  Speed: $speed km/h',
      );
    }
  }
}

class ForegroundTaskManager {

  static Future<void> init() async {
    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: 'obd_ledger_foreground',
        channelName: 'OBD Trip Recording',
        channelDescription: 'Keeps GPS and Bluetooth active during a trip.',
        channelImportance: NotificationChannelImportance.LOW,
        priority: NotificationPriority.LOW,
      ),
      iosNotificationOptions: const IOSNotificationOptions(
        showNotification: true,
        playSound: false,
      ),
      foregroundTaskOptions: ForegroundTaskOptions(
        eventAction: ForegroundTaskEventAction.repeat(5000),
        autoRunOnBoot: false,
        allowWakeLock: true,
        allowWifiLock: true,
      ),
    );
  }

  static Future<void> start() async {
    if (await FlutterForegroundTask.isRunningService) return;

    await FlutterForegroundTask.startService(
      notificationTitle: '🟡 OBD Ledger',
      notificationText: 'Waiting for telemetry...',
      callback: startCallback,
    );
  }

  static Future<void> stop() async {
    await FlutterForegroundTask.stopService();
  }

  static void sendTelemetry(int rpm, int speed) {
    FlutterForegroundTask.sendDataToTask({
      'rpm': rpm,
      'speed': speed,
    });
  }
}