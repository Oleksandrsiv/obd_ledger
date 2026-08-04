import 'package:flutter/material.dart';
import '../../utils/chart_helper.dart';

class ChartFilters extends StatelessWidget {
  final YAxisType selectedY;
  final ValueChanged<YAxisType> onYChanged;

  const ChartFilters({
    super.key,
    required this.selectedY,
    required this.onYChanged,
  });

  @override
  Widget build(BuildContext context) {
    return _buildDropdown<YAxisType>(
      context,
      label: 'Telemetry Parameter',
      value: selectedY,
      items: const [
        DropdownMenuItem(value: YAxisType.speed, child: Text('Speed (km/h)')),
        DropdownMenuItem(value: YAxisType.rpm, child: Text('RPM')),
        DropdownMenuItem(value: YAxisType.coolantTemp, child: Text('Coolant Temp (°C)')),
        DropdownMenuItem(value: YAxisType.oilTemp, child: Text('Oil Temp (°C)')),
        DropdownMenuItem(value: YAxisType.intakeAirTemp, child: Text('Intake Air Temp (°C)')),
        DropdownMenuItem(value: YAxisType.maf, child: Text('Mass Air Flow (g/s)')),
        DropdownMenuItem(value: YAxisType.fuelLevel, child: Text('Fuel Level (%)')),
      ],
      onChanged: (val) => onYChanged(val!),
    );
  }

  Widget _buildDropdown<T>(
      BuildContext context, {
        required String label,
        required T value,
        required List<DropdownMenuItem<T>> items,
        required void Function(T?) onChanged,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.grey),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              isExpanded: true,
              value: value,
              items: items,
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}