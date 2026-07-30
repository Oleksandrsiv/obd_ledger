import 'package:flutter/material.dart';
import '../../../core/database/database.dart';
import '../utils/daily_analytics_helper.dart';

class DailyStatsList extends StatelessWidget {
  final List<Trip> selectedDayTrips;

  const DailyStatsList({
    super.key,
    required this.selectedDayTrips,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (selectedDayTrips.isEmpty) {
      return Center(
        child: Text(
          'No trips recorded on this day.',
          style: TextStyle(color: colorScheme.onSurfaceVariant),
        ),
      );
    }

    final totalDayDistance = DailyAnalyticsHelper.calculateTotalDistance(selectedDayTrips);
    final totalDayHours = DailyAnalyticsHelper.calculateTotalHours(selectedDayTrips);

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        Card(
          color: colorScheme.surfaceContainerHighest.withOpacity(0.3),
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text('Distance', style: Theme.of(context).textTheme.labelMedium),
                    const SizedBox(height: 4),
                    Text(
                      '$totalDayDistance km',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text('Duration', style: Theme.of(context).textTheme.labelMedium),
                    const SizedBox(height: 4),
                    Text(
                      '${totalDayHours.toStringAsFixed(1)} hrs',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Trip Sessions',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...selectedDayTrips.map((trip) {
          final startTime = DailyAnalyticsHelper.formatTime(trip.startTimestamp);
          final endTime = trip.endTimestamp != null ? DailyAnalyticsHelper.formatTime(trip.endTimestamp!) : 'In progress';

          return Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: colorScheme.secondaryContainer,
                child: Icon(Icons.directions_car, color: colorScheme.onSecondaryContainer, size: 20),
              ),
              title: Text('$startTime - $endTime'),
              subtitle: Text('Distance: ${trip.totalDistance} km'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Session details coming soon!'), duration: Duration(seconds: 1)),
                );
              },
            ),
          );
        }),
      ],
    );
  }
}