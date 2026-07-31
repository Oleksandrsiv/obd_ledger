import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/session_player_cubit.dart';
import '../../bloc/session_player_state.dart';
import '../../utils/chart_helper.dart';

import 'chart_filters.dart';
import 'telemetry_line_chart.dart';
import '../common/session_scrubber.dart';

class ChartsTab extends StatefulWidget {
  const ChartsTab({super.key});

  @override
  State<ChartsTab> createState() => _ChartsTabState();
}

class _ChartsTabState extends State<ChartsTab> {
  YAxisType _selectedY = YAxisType.speed;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionPlayerCubit, SessionPlayerState>(
      builder: (context, state) {
        if (state.points.isEmpty) {
          return const Center(child: Text('No data for chart'));
        }

        final colorScheme = Theme.of(context).colorScheme;

        final spots = ChartHelper.generateSpots(state.points, _selectedY);
        final lineColor = ChartHelper.getLineColor(_selectedY, colorScheme);

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // axis Y
              ChartFilters(
                selectedY: _selectedY,
                onYChanged: (val) => setState(() => _selectedY = val),
              ),

              const SizedBox(height: 24),

              // graph
              Expanded(
                child: TelemetryLineChart(
                  spots: spots,
                  lineColor: lineColor,
                  currentIndex: state.currentIndex,
                ),
              ),

              const SizedBox(height: 16),

              // time slider
              const SessionScrubber(),

              const SizedBox(height: 16), // Bottom indent
            ],
          ),
        );
      },
    );
  }
}