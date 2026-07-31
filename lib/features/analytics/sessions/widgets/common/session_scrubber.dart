import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/session_player_cubit.dart';
import '../../bloc/session_player_state.dart';

class SessionScrubber extends StatelessWidget {
  const SessionScrubber({super.key});

  String _formatTime(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final h = date.hour.toString().padLeft(2, '0');
    final m = date.minute.toString().padLeft(2, '0');
    final s = date.second.toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionPlayerCubit, SessionPlayerState>(
      builder: (context, state) {
        if (state.points.isEmpty) {
          return const SizedBox.shrink(); // Hide the slider if there is no data
        }

        final colorScheme = Theme.of(context).colorScheme;

        final maxIndex = (state.points.length - 1).toDouble();
        final currentIndex = state.currentIndex.toDouble();

        final startTime = _formatTime(state.points.first.timestamp);
        final endTime = _formatTime(state.points.last.timestamp);
        final currentTime = _formatTime(state.points[state.currentIndex].timestamp);

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            children: [
              Text(
                currentTime,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
              ),
              Slider(
                value: currentIndex,
                min: 0,
                max: maxIndex,
                // Call Cubit to update the UI during drag
                onChanged: (value) {
                  context.read<SessionPlayerCubit>().updateIndex(value);
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      startTime,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      endTime,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}