import 'package:shared_preferences/shared_preferences.dart';

class BluetoothPrefsRepository {
  final SharedPreferences _prefs;
  static const String _macKey = 'selected_obd_mac';

  BluetoothPrefsRepository(this._prefs);

  String? getSelectedMac() {
    return _prefs.getString(_macKey);
  }

  Future<void> saveSelectedMac(String macAddress) async {
    await _prefs.setString(_macKey, macAddress);
  }
}