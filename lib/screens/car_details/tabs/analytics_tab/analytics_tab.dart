import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';
import '../../../../blocs/analytics/analytics_bloc.dart';
import '../../../../blocs/analytics/analytics_event.dart';
import '../../../../blocs/analytics/analytics_state.dart';
import '../../../../blocs/car/car_bloc.dart';
import '../../../../data/database/database.dart';

enum TimeFilter { week, month, year }
enum MetricType { distance, time }

class AnalyticsTab extends StatefulWidget {
  const AnalyticsTab({super.key});

  @override
  State<AnalyticsTab> createState() => _AnalyticsTabState();
}

class _AnalyticsTabState extends State<AnalyticsTab> {
  TimeFilter _selectedTimeFilter = TimeFilter.week;
  MetricType _selectedMetric = MetricType.time; // По замовчуванню час, бо відстані поки немає в базі поїздок

  @override
  void initState() {
    super.initState();
    // При відкритті вкладки завантажуємо дані для активного авто
    final activeCar = context.read<CarBloc>().state.activeCar;
    if (activeCar != null) {
      context.read<AnalyticsBloc>().add(LoadAnalyticsData(activeCar.id));
    }
  }

  // --- МАТЕМАТИКА: Обробка реальних даних ---
  List<double> _processData(List<Trip> trips) {
    final now = DateTime.now();

    final todayMidnight = DateTime(now.year, now.month, now.day);

    List<double> result;

    if (_selectedTimeFilter == TimeFilter.week) {
      result = List.filled(7, 0.0);
      // Знаходимо понеділок поточного тижня
      final startOfWeek = todayMidnight.subtract(Duration(days: todayMidnight.weekday - 1));

      for (var trip in trips) {
        final tripDate = DateTime.fromMillisecondsSinceEpoch(trip.startTimestamp);
        // Якщо поїздка відбулася на цьому тижні
        if (!tripDate.isBefore(startOfWeek) && trip.endTimestamp != null) {
          int dayIndex = tripDate.weekday - 1; // 0 = Mon, 6 = Sun
          double hours = (trip.endTimestamp! - trip.startTimestamp) / 1000 / 3600;
          result[dayIndex] += hours; // Додаємо години
        }
      }
    }
    else if (_selectedTimeFilter == TimeFilter.month) {
      result = List.filled(4, 0.0); // 4 тижні
      for (var trip in trips) {
        final tripDate = DateTime.fromMillisecondsSinceEpoch(trip.startTimestamp);
        if (tripDate.year == now.year && tripDate.month == now.month && trip.endTimestamp != null) {
          int weekIndex = (tripDate.day - 1) ~/ 7; // Грубо розбиваємо на 4 відрізки
          if (weekIndex > 3) weekIndex = 3;
          double hours = (trip.endTimestamp! - trip.startTimestamp) / 1000 / 3600;
          result[weekIndex] += hours;
        }
      }
    }
    else {
      result = List.filled(12, 0.0); // 12 місяців
      for (var trip in trips) {
        final tripDate = DateTime.fromMillisecondsSinceEpoch(trip.startTimestamp);
        if (tripDate.year == now.year && trip.endTimestamp != null) {
          int monthIndex = tripDate.month - 1; // 0 = Jan, 11 = Dec
          double hours = (trip.endTimestamp! - trip.startTimestamp) / 1000 / 3600;
          result[monthIndex] += hours;
        }
      }
    }

    // Тимчасова заглушка для Distance (поки ми не додамо дистанцію в БД)
    if (_selectedMetric == MetricType.distance) {
      // Імітуємо дистанцію: наприклад, середня швидкість була 45 км/год
      return result.map((hours) => hours * 45.0).toList();
    }

    return result;
  }

  // Динамічні підписи (залишилися без змін)
  List<String> get _currentLabels {
    if (_selectedTimeFilter == TimeFilter.week) return ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    if (_selectedTimeFilter == TimeFilter.month) return ['W1', 'W2', 'W3', 'W4'];
    return ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: const Text('Analytics'), centerTitle: true),
      // Використовуємо BlocBuilder для отримання даних
      body: BlocBuilder<AnalyticsBloc, AnalyticsState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.errorMessage != null) {
            return Center(child: Text("Error: ${state.errorMessage}", style: TextStyle(color: colorScheme.error)));
          }

          final data = _processData(state.allTrips);

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
                      child: BarChart(_buildChartData(colorScheme, data, _currentLabels)),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Метод графіка майже не змінився, тільки тепер він приймає data як параметр
  BarChartData _buildChartData(ColorScheme colorScheme, List<double> data, List<String> labels) {
    double maxDataValue = data.isEmpty ? 0 : data.reduce(max);
    if (maxDataValue == 0) maxDataValue = 10;

    final double maxY = maxDataValue * 1.2;
    final double gridInterval = maxY / 5;

    return BarChartData(
      maxY: maxY,
      alignment: BarChartAlignment.spaceAround,
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: gridInterval,
      ),
      titlesData: FlTitlesData(
        show: true,
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (double value, TitleMeta meta) {
              if (value < 0 || value >= labels.length) return const SizedBox.shrink();
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  labels[value.toInt()],
                  style: TextStyle(
                    fontSize: _selectedTimeFilter == TimeFilter.year ? 10 : 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      barGroups: List.generate(data.length, (index) {
        return BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: data[index],
              color: colorScheme.primary,
              width: _selectedTimeFilter == TimeFilter.year ? 10 : 16,
              borderRadius: BorderRadius.circular(4),
              backDrawRodData: BackgroundBarChartRodData(
                show: true,
                toY: maxY,
                color: colorScheme.surfaceContainerHighest,
              ),
            ),
          ],
        );
      }),
      barTouchData: BarTouchData(
        enabled: true,
        touchTooltipData: BarTouchTooltipData(
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            return BarTooltipItem(
              // Округлюємо до 2 знаків після коми
              rod.toY.toStringAsFixed(2),
              TextStyle(
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          if (!event.isInterestedForInteractions || barTouchResponse == null || barTouchResponse.spot == null) return;
          if (event is FlTapUpEvent) {
            final index = barTouchResponse.spot!.touchedBarGroupIndex;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Clicked on ${labels[index]}: ${data[index].toStringAsFixed(2)} ${_selectedMetric == MetricType.distance ? "km" : "hrs"}'),
                duration: const Duration(seconds: 1),
              ),
            );
          }
        },
      ),
    );
  }
}