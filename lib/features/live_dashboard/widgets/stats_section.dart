import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../features/live_dashboard/bloc/dashboard_bloc.dart';
import 'mini_stat_card.dart';

class StatsSection extends StatelessWidget {
  const StatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        final data = state.realtimeData;

        return Wrap(
          spacing: 8.0, // Відстань між картками по горизонталі
          runSpacing: 12.0, // Відстань по вертикалі
          alignment: WrapAlignment.spaceBetween,
          children: [
            MiniStatCard(
              icon: Icons.thermostat,
              //iconColor: Colors.blue,
              title: 'Coolant',
              value: data.coolantTemp.toString(),
              unit: '°C',
            ),
            MiniStatCard(
              icon: Icons.water_drop,
              //iconColor: Colors.orange,
              title: 'Oil Temp',
              value: data.engineOilTemp.toString(),
              unit: '°C',
            ),
            MiniStatCard(
              icon: Icons.air,
              //iconColor: Colors.cyan,
              title: 'Intake Air',
              value: data.intakeAirTemp.toString(),
              unit: '°C',
            ),
            MiniStatCard(
              icon: Icons.local_gas_station,
              //iconColor: Colors.green,
              title: 'Fuel',
              value: data.fuelLevel.toString(),
              unit: '%',
            ),
            MiniStatCard(
              icon: Icons.battery_charging_full,
              //iconColor: Colors.purple,
              title: 'Battery',
              value: data.batteryVoltage,
              unit: '', // Voltage already has a 'V' at the end
            ),
            MiniStatCard(
              icon: Icons.speed,
              //iconColor: Colors.redAccent,
              title: 'Load',
              value: data.engineLoad.toString(),
              unit: '%',
            ),
          ],
        );
      },
    );
  }
}