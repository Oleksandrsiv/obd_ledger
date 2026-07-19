import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/bluetooth/bluetooth_cubit.dart';
import '../../../services/obd_service/iobd_service.dart';

class ConnectionStatusLight extends StatelessWidget {
  const ConnectionStatusLight();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BluetoothCubit, BluetoothState>(
      builder: (context, state) {
        Color lightColor;
        String tooltipMessage;

        switch (state.connectionStatus) {
          case ObdConnectionState.disconnected:
            lightColor = Theme.of(context).colorScheme.error;
            tooltipMessage = 'Disconnected';
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
            tooltipMessage = 'Connection Error';
            break;
        }

        return Tooltip(
          message: tooltipMessage,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
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
        );
      },
    );
  }
}