import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../core/database/database.dart';

enum YAxisType { speed, rpm, coolantTemp, oilTemp, intakeAirTemp, maf, fuelLevel }

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
        case YAxisType.coolantTemp:
          yValue = point.coolantTemp.toDouble();
          break;
        case YAxisType.oilTemp:
          yValue = (point.engineOilTemp ?? 0).toDouble();
          break;
        case YAxisType.intakeAirTemp:
          yValue = (point.intakeAirTemp ?? 0).toDouble();
          break;
        case YAxisType.maf:
          yValue = point.maf ?? 0.0;
          break;
        case YAxisType.fuelLevel:
          yValue = (point.fuelLevel ?? 0).toDouble();
          break;
      }

      return FlSpot(pointIndex, yValue);
    }).toList();
  }

  static Color getLineColor(YAxisType yType, ColorScheme colorScheme) {
    switch (yType) {
      case YAxisType.speed:
        return Colors.blue;
      case YAxisType.rpm:
        return Colors.redAccent;
      case YAxisType.coolantTemp:
        return Colors.cyan;
      case YAxisType.oilTemp:
        return Colors.orange;
      case YAxisType.intakeAirTemp:
        return Colors.teal;
      case YAxisType.maf:
        return Colors.purple;
      case YAxisType.fuelLevel:
        return Colors.green;
    }
  }
}