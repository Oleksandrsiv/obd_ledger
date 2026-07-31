import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../core/database/database.dart';

enum YAxisType { speed, rpm, temperature }

class ChartHelper {
  static List<FlSpot> generateSpots(
      List<TripPoint> points,
      YAxisType yType,
      ) {
    if (points.isEmpty) return [];

    return points.asMap().entries.map((entry) {
      final pointIndex = entry.key.toDouble();
      final point = entry.value;

      double yValue;
      switch (yType) {
        case YAxisType.speed:
          yValue = point.speed.toDouble();
          break;
        case YAxisType.rpm:
          yValue = point.rpm.toDouble();
          break;
        case YAxisType.temperature:
          yValue = point.engineTemp.toDouble();
          break;
      }

      return FlSpot(pointIndex, yValue);
    }).toList();
  }

  static Color getLineColor(YAxisType yType, ColorScheme colorScheme) {
    switch (yType) {
      case YAxisType.speed:
        return colorScheme.primary;
      case YAxisType.rpm:
        return colorScheme.secondary;
      case YAxisType.temperature:
        return colorScheme.error;
    }
  }
}