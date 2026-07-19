import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart' hide BluetoothState;
import '../../blocs/bluetooth/bluetooth_cubit.dart';
//import '../../services/obd_service/iobd_service.dart';
import 'package:obd_ledger/services/obd_service/iobd_service.dart';
import '../../theme/app_them.dart';
import '../../theme/theme_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'External appearance',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _ThemeOptionTile(
            title: 'Light theme',
            icon: Icons.wb_sunny_rounded,
            themeType: AppThemeType.light,
          ),
          _ThemeOptionTile(
            title: 'Dark theme',
            icon: Icons.nightlight_round,
            themeType: AppThemeType.dark,
          ),
          _ThemeOptionTile(
            title: 'OLED (dark) theme',
            icon: Icons.brightness_3_rounded,
            themeType: AppThemeType.oled,
          ),

          const Divider(height: 48),

          const Text(
            'OBD Adapter',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _ObdAdapterSelector(),
        ],
      ),
    );
  }
}


class _ThemeOptionTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final AppThemeType themeType;

  const _ThemeOptionTile({
    required this.title,
    required this.icon,
    required this.themeType,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isOled = Theme.of(context).scaffoldBackgroundColor == Colors.black;

    bool isActive = false;
    if (themeType == AppThemeType.light && !isDark) isActive = true;
    if (themeType == AppThemeType.dark && isDark && !isOled) isActive = true;
    if (themeType == AppThemeType.oled && isDark && isOled) isActive = true;

    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: isActive ? 2 : 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: isActive ? colorScheme.primary : Colors.transparent,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isActive ? colorScheme.primary : Colors.grey,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        trailing: isActive
            ? Icon(Icons.check_circle, color: colorScheme.primary)
            : null,
        onTap: () {
          context.read<ThemeCubit>().changeTheme(themeType);
        },
      ),
    );
  }
}

class _ObdAdapterSelector extends StatelessWidget {
  const _ObdAdapterSelector();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BluetoothCubit, BluetoothState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.bondedDevices.isEmpty) {
          return const Text(
            'No paired devices found. Please pair an OBD adapter in your phone\'s Bluetooth settings first.',
            style: TextStyle(color: Colors.grey),
          );
        }

        final isConnected = state.connectionStatus == ObdConnectionState.connected;
        final isConnecting = state.connectionStatus == ObdConnectionState.connecting;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.withOpacity(0.5)),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: state.selectedMacAddress,
                  hint: const Text('Select OBD adapter'),
                  items: state.bondedDevices.map((device) {
                    return DropdownMenuItem<String>(
                      value: device.address,
                      child: Text(device.name ?? device.address),
                    );
                  }).toList(),
                  // Block changing the device while establishing a connection
                  onChanged: isConnecting ? null : (newMac) {
                    if (newMac != null) {
                      context.read<BluetoothCubit>().selectDevice(newMac);
                    }
                  },
                ),
              ),
            ),

            // error bloc
            if (state.errorMessage != null) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.error_outline, color: Theme.of(context).colorScheme.error, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      state.errorMessage!,
                      style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ],

            // btn (Connect / Disconnect)
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: isConnecting
                  ? null // Block btn while establishing a connection
                  : () {
                if (isConnected) {
                  context.read<BluetoothCubit>().disconnect();
                } else if (state.selectedMacAddress != null) {
                  context.read<BluetoothCubit>().connectToDevice(state.selectedMacAddress!);
                }
              },
              icon: isConnecting
                  ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
                  : Icon(isConnected ? Icons.bluetooth_disabled : Icons.bluetooth_connected),
              label: Text(
                isConnecting
                    ? 'Connecting...'
                    : (isConnected ? 'Disconnect' : 'Connect'),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: isConnected
                    ? Theme.of(context).colorScheme.errorContainer
                    : null,
                foregroundColor: isConnected
                    ? Theme.of(context).colorScheme.onErrorContainer
                    : null,
              ),
            ),
          ],
        );
      },
    );
  }
}