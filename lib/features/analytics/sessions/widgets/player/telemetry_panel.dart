import 'package:flutter/material.dart';
import '../../../../../core/database/database.dart';

class TelemetryPanel extends StatelessWidget {
  final TripPoint? point;

  const TelemetryPanel({super.key, required this.point});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatCard(
            context,
            title: 'Speed',
            value: '${point?.speed ?? 0}',
            unit: 'km/h',
            icon: Icons.speed,
            color: colorScheme.primary,
          ),
          _buildStatCard(
            context,
            title: 'RPM',
            value: '${point?.rpm ?? 0}',
            unit: 'rpm',
            icon: Icons.settings_applications,
            color: colorScheme.secondary,
          ),
          _buildStatCard(
            context,
            title: 'Temp',
            value: '${point?.coolantTemp ?? 0}',
            unit: '°C',
            icon: Icons.thermostat,
            color: colorScheme.error,
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, {
    required String title,
    required String value,
    required String unit,
    required IconData icon,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          unit,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}