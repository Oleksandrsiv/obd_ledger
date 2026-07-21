import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../blocs/dashboards/dashboard_bloc.dart';
import 'linear_bar_gauge.dart';

class GaugesSection extends StatelessWidget {
  const GaugesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocSelector<DashboardBloc, DashboardState, double>(
          selector: (state) => state.realtimeData.rpm.toDouble(),
          builder: (context, rpm) {
            return LinearBarGauge(
              title: 'ENGINE RPM',
              value: rpm,
              max: 8000,
              unit: 'RPM',
              color: Theme.of(context).colorScheme.primary,
            );
          },
        ),

        const SizedBox(height: 32),

        BlocSelector<DashboardBloc, DashboardState, double>(
          selector: (state) => state.realtimeData.speed.toDouble(),
          builder: (context, speed) {
            return LinearBarGauge(
              title: 'VEHICLE SPEED',
              value: speed,
              max: 240,
              unit: 'km/h',
              color: Theme.of(context).colorScheme.tertiary,
            );
          },
        ),
      ],
    );
  }
}