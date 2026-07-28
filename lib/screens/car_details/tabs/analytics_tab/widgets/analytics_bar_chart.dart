import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';
import '../../../../../data/models/analytics_enums.dart';

class AnalyticsBarChart extends StatelessWidget {
  final List<double> data;
  final List<String> labels;
  final TimeFilter timeFilter;
  final MetricType metricType;

  const AnalyticsBarChart({
    super.key,
    required this.data,
    required this.labels,
    required this.timeFilter,
    required this.metricType,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    double maxDataValue = data.isEmpty ? 0 : data.reduce(max);
    if (maxDataValue == 0) maxDataValue = 10;

    final double maxY = maxDataValue * 1.2;
    final double gridInterval = maxY / 5;

    return BarChart(
      BarChartData(
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
                      fontSize: timeFilter == TimeFilter.year ? 10 : 12,
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
                width: timeFilter == TimeFilter.year ? 10 : 16,
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
                  content: Text(
                      'Clicked on ${labels[index]}: ${data[index].toStringAsFixed(2)} ${metricType == MetricType.distance ? "km" : "hrs"}'
                  ),
                  duration: const Duration(seconds: 1),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}