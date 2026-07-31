import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class TelemetryLineChart extends StatelessWidget {
  final List<FlSpot> spots;
  final Color lineColor;
  final int currentIndex;

  const TelemetryLineChart({
    super.key,
    required this.spots,
    required this.lineColor,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    if (spots.isEmpty) return const SizedBox.shrink();

    final colorScheme = Theme.of(context).colorScheme;

    // Protect against going outside the array and getting the current point
    final safeIndex = currentIndex.clamp(0, spots.length - 1);
    final currentSpot = spots[safeIndex];

    return Column(
      children: [
        // number above graph
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          decoration: BoxDecoration(
            color: lineColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: lineColor.withOpacity(0.3)),
          ),
          child: Text(
            currentSpot.y.toInt().toString(),
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: lineColor,
            ),
          ),
        ),

        const SizedBox(height: 16),

        // graph
        Expanded(
          child: LineChart(
            LineChartData(
              lineTouchData: const LineTouchData(enabled: false),

              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                getDrawingHorizontalLine: (value) => FlLine(
                  color: colorScheme.onSurfaceVariant.withOpacity(0.2),
                  strokeWidth: 1,
                  dashArray: [5, 5],
                ),
              ),

              // Crosshair
              extraLinesData: ExtraLinesData(
                verticalLines: [
                  VerticalLine(
                    x: currentSpot.x, // Moves right/left in time
                    color: colorScheme.onSurface,
                    strokeWidth: 2,
                    dashArray: [4, 4],
                  ),
                ],
                horizontalLines: [
                  HorizontalLine(
                    y: currentSpot.y, // Moves up/down by value (speed/rev)
                    color: lineColor.withOpacity(0.5),
                    strokeWidth: 2,
                    dashArray: [4, 4],
                  ),
                ],
              ),

              titlesData: FlTitlesData(
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 45,
                    getTitlesWidget: (value, meta) {
                      return SideTitleWidget(
                        meta: meta,
                        child: Text(
                          value.toInt().toString(),
                          style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 10),
                        ),
                      );
                    },
                  ),
                ),
              ),
              borderData: FlBorderData(show: false),
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: true,
                  color: lineColor,
                  barWidth: 3,
                  isStrokeCapRound: true,

                  dotData: FlDotData(
                    show: true,
                    checkToShowDot: (spot, barData) => spot.x == currentSpot.x,
                    getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
                      radius: 4,
                      color: lineColor,
                      strokeWidth: 2,
                      strokeColor: colorScheme.surface,
                    ),
                  ),
                  belowBarData: BarAreaData(
                    show: true,
                    color: lineColor.withOpacity(0.15),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}