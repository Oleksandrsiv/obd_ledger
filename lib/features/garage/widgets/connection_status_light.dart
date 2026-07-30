import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/bluetooth/bluetooth_cubit.dart';
import '../../../core/bluetooth/bluetooth_state.dart';
import '../../../core/services/obd_service/iobd_service.dart';

class ConnectionStatusLight extends StatelessWidget {
  const ConnectionStatusLight({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BluetoothCubit, BluetoothState>(
      builder: (context, state) {
        Color lightColor;
        String tooltipMessage;

        switch (state.connectionStatus) {
          case ObdConnectionState.disconnected:
            lightColor = Theme.of(context).colorScheme.error;
            tooltipMessage = 'Disconnected. Tap to reconnect.';
            break;
          case ObdConnectionState.connecting:
            lightColor = Theme.of(context).colorScheme.tertiary;
            tooltipMessage = 'Connecting...';
            break;
          case ObdConnectionState.connected:
            lightColor = Theme.of(context).colorScheme.secondary;
            tooltipMessage = 'OBD Connected';
            break;
          case ObdConnectionState.error:
            lightColor = Theme.of(context).colorScheme.error;
            tooltipMessage = 'Connection Error. Tap to retry.';
            break;
        }

        return Tooltip(
          message: tooltipMessage,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              if (state.connectionStatus == ObdConnectionState.connecting ||
                  state.connectionStatus == ObdConnectionState.connected) {
                return;
              }

              final macAddress = state.selectedMacAddress;
              if (macAddress != null) {
                context.read<BluetoothCubit>().connectToDevice(macAddress);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Attempting to reconnect...'),
                    duration: Duration(seconds: 2),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please select an OBD adapter in Settings first.'),
                    duration: Duration(seconds: 3),
                  ),
                );
              }
            },
            child: Container(
              padding: const EdgeInsets.all(4),
              margin: const EdgeInsets.symmetric(horizontal: 12),
              child: Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: lightColor,
                  boxShadow: [
                    BoxShadow(
                      color: lightColor.withOpacity(0.6),
                      blurRadius: 6,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}