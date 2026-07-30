

import '../../../core/database/database.dart';

class DailyAnalyticsHelper {
  static List<Trip> getTripsForDay(List<Trip> trips, DateTime day) {
    return trips.where((t) {
      final tripDate = DateTime.fromMillisecondsSinceEpoch(t.startTimestamp);
      return tripDate.year == day.year &&
          tripDate.month == day.month &&
          tripDate.day == day.day;
    }).toList();
  }

  static String formatTime(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  static int calculateTotalDistance(List<Trip> trips) {
    return trips.fold<int>(0, (sum, trip) => sum + trip.totalDistance);
  }

  static double calculateTotalHours(List<Trip> trips) {
    double total = 0;
    for (var trip in trips) {
      if (trip.endTimestamp != null) {
        total += (trip.endTimestamp! - trip.startTimestamp) / 1000 / 3600;
      }
    }
    return total;
  }
}