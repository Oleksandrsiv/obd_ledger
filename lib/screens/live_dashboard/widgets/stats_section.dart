import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/dashboards/dashboard_bloc.dart';
import 'mini_stat_card.dart';

class StatsSection extends StatelessWidget {
  const StatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BlocSelector<DashboardBloc, DashboardState, double>(
          selector: (state) => state.realtimeData.coolantTemp.toDouble(),
          builder: (context, coolant) {
            return MiniStatCard(
              icon: Icons.thermostat,
              title: 'Coolant',
              value: coolant.toInt().toString(),
              unit: '°C',
            );
          },
        ),
        const SizedBox(width: 8),

        BlocSelector<DashboardBloc, DashboardState, double>(
          selector: (state) => state.realtimeData.engineLoad.toDouble(),
          builder: (context, load) {
            return MiniStatCard(
              icon: Icons.speed,
              title: 'Load',
              value: load.toInt().toString(),
              unit: '%',
            );
          },
        ),
        const SizedBox(width: 8),

        BlocSelector<DashboardBloc, DashboardState, double>(
          selector: (state) => state.realtimeData.throttlePosition.toDouble(),
          builder: (context, throttle) {
            return MiniStatCard(
              icon: Icons.settings_ethernet,
              title: 'Throttle',
              value: throttle.toInt().toString(),
              unit: '%',
            );
          },
        ),
      ],
    );
  }
}