import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/session_player_cubit.dart';
import '../../bloc/session_player_state.dart';
import 'session_map.dart';
import '../common/session_scrubber.dart';
import 'telemetry_panel.dart';

class PlayerTab extends StatelessWidget {
  const PlayerTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionPlayerCubit, SessionPlayerState>(
      builder: (context, state) {
        return Column(
          children: [
            // Takes up all available free space on top
            const Expanded(
              child: SessionMap(),
            ),
            const SizedBox(height: 16),
            TelemetryPanel(point: state.currentPoint),
            const SizedBox(height: 16),
            const SessionScrubber(),
            const SizedBox(height: 32), // Bottom indent
          ],
        );
      },
    );
  }
}