import '../../../../../data/database/database.dart';
import '../../../../../data/models/analytics_enums.dart';

class AnalyticsCalculator {
  static List<double> processTrips(
      List<Trip> trips,
      TimeFilter timeFilter,
      MetricType metricType,
      ) {
    final now = DateTime.now();
    final todayMidnight = DateTime(now.year, now.month, now.day);
    List<double> result;

    if (timeFilter == TimeFilter.week) {
      result = List.filled(7, 0.0);
      final startOfWeek = todayMidnight.subtract(Duration(days: todayMidnight.weekday - 1));

      for (var trip in trips) {
        final tripDate = DateTime.fromMillisecondsSinceEpoch(trip.startTimestamp);
        if (!tripDate.isBefore(startOfWeek) && trip.endTimestamp != null) {
          int dayIndex = tripDate.weekday - 1;
          double hours = (trip.endTimestamp! - trip.startTimestamp) / 1000 / 3600;
          result[dayIndex] += hours;
        }
      }
    } else if (timeFilter == TimeFilter.month) {
      result = List.filled(4, 0.0);
      for (var trip in trips) {
        final tripDate = DateTime.fromMillisecondsSinceEpoch(trip.startTimestamp);
        if (tripDate.year == now.year && tripDate.month == now.month && trip.endTimestamp != null) {
          int weekIndex = (tripDate.day - 1) ~/ 7;
          if (weekIndex > 3) weekIndex = 3;
          double hours = (trip.endTimestamp! - trip.startTimestamp) / 1000 / 3600;
          result[weekIndex] += hours;
        }
      }
    } else {
      result = List.filled(12, 0.0);
      for (var trip in trips) {
        final tripDate = DateTime.fromMillisecondsSinceEpoch(trip.startTimestamp);
        if (tripDate.year == now.year && trip.endTimestamp != null) {
          int monthIndex = tripDate.month - 1;
          double hours = (trip.endTimestamp! - trip.startTimestamp) / 1000 / 3600;
          result[monthIndex] += hours;
        }
      }
    }

    if (metricType == MetricType.distance) {
      return result.map((hours) => hours * 45.0).toList();
    }

    return result;
  }

  static List<String> getLabels(TimeFilter timeFilter) {
    if (timeFilter == TimeFilter.week) return ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    if (timeFilter == TimeFilter.month) return ['W1', 'W2', 'W3', 'W4'];
    return ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
  }
}