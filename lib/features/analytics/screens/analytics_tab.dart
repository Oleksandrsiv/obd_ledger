import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/analytics_bloc.dart';
import '../bloc/analytics_event.dart';
import '../bloc/analytics_state.dart';
import '../../garage/bloc/car_bloc.dart';
import '../data/analytics_enums.dart';
import '../utils/analytics_calculator.dart';
import '../widgets/analytics_bar_chart.dart';
import 'daily_analytics_screen.dart';

class AnalyticsTab extends StatefulWidget {
  const AnalyticsTab({super.key});

  @override
  State<AnalyticsTab> createState() => _AnalyticsTabState();
}

class _AnalyticsTabState extends State<AnalyticsTab> {
  TimeFilter _selectedTimeFilter = TimeFilter.week;
  MetricType _selectedMetric = MetricType.time;

  @override
  void initState() {
    super.initState();
    final activeCar = context.read<CarBloc>().state.activeCar;
    if (activeCar != null) {
      context.read<AnalyticsBloc>().add(LoadAnalyticsData(activeCar.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: const Text('Analytics'), centerTitle: true),
      body: BlocBuilder<AnalyticsBloc, AnalyticsState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.errorMessage != null) {
            return Center(
              child: Text(
                  "Error: ${state.errorMessage}",
                  style: TextStyle(color: colorScheme.error)
              ),
            );
          }

          final data = AnalyticsCalculator.processTrips(state.allTrips, _selectedTimeFilter, _selectedMetric);
          final labels = AnalyticsCalculator.getLabels(_selectedTimeFilter);

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SegmentedButton<TimeFilter>(
                  style: SegmentedButton.styleFrom(
                    selectedBackgroundColor: colorScheme.primary,
                    selectedForegroundColor: colorScheme.onPrimary,
                    backgroundColor: isDark ? Colors.grey.shade900 : Colors.grey.shade200,
                  ),
                  segments: const [
                    ButtonSegment(value: TimeFilter.week, label: Text('Week')),
                    ButtonSegment(value: TimeFilter.month, label: Text('Month')),
                    ButtonSegment(value: TimeFilter.year, label: Text('Year')),
                  ],
                  selected: {_selectedTimeFilter},
                  onSelectionChanged: (newSelection) {
                    setState(() => _selectedTimeFilter = newSelection.first);
                  },
                ),
                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ChoiceChip(
                      label: const Text('Distance (km)'),
                      selected: _selectedMetric == MetricType.distance,
                      selectedColor: colorScheme.primaryContainer,
                      labelStyle: TextStyle(
                        fontWeight: _selectedMetric == MetricType.distance ? FontWeight.bold : FontWeight.normal,
                        color: _selectedMetric == MetricType.distance ? colorScheme.onPrimaryContainer : null,
                      ),
                      onSelected: (selected) {
                        if (selected) setState(() => _selectedMetric = MetricType.distance);
                      },
                    ),
                    const SizedBox(width: 12),
                    ChoiceChip(
                      label: const Text('Duration (hrs)'),
                      selected: _selectedMetric == MetricType.time,
                      selectedColor: colorScheme.primaryContainer,
                      labelStyle: TextStyle(
                        fontWeight: _selectedMetric == MetricType.time ? FontWeight.bold : FontWeight.normal,
                        color: _selectedMetric == MetricType.time ? colorScheme.onPrimaryContainer : null,
                      ),
                      onSelected: (selected) {
                        if (selected) setState(() => _selectedMetric = MetricType.time);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                Expanded(
                  child: Card(
                    elevation: 0,
                    color: colorScheme.surfaceContainerHighest.withOpacity(0.3),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 32, right: 24, left: 16, bottom: 16),
                      child: AnalyticsBarChart(
                        data: data,
                        labels: labels,
                        timeFilter: _selectedTimeFilter,
                        metricType: _selectedMetric,
                      ),
                    ),
                  ),
                ),

                IconButton(
                  icon: const Icon(Icons.calendar_month),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DailyAnalyticsScreen(
                          allTrips: state.allTrips,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}