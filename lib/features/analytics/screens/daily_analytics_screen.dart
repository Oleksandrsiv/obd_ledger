import 'package:flutter/material.dart';

import '../../../core/database/database.dart';
import '../utils/daily_analytics_helper.dart';
import '../widgets/calendar_grid.dart';
import '../widgets/daily_stats_list.dart';

class DailyAnalyticsScreen extends StatefulWidget {
  final List<Trip> allTrips;

  const DailyAnalyticsScreen({
    super.key,
    required this.allTrips,
  });

  @override
  State<DailyAnalyticsScreen> createState() => _DailyAnalyticsScreenState();
}

class _DailyAnalyticsScreenState extends State<DailyAnalyticsScreen> {
  late DateTime _currentMonth;
  late DateTime _selectedDate;

  final List<String> _monthNames = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _currentMonth = DateTime(now.year, now.month);
    _selectedDate = DateTime(now.year, now.month, now.day);
  }

  void _changeMonth(int increment) {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + increment);
      _selectedDate = DateTime(_currentMonth.year, _currentMonth.month, 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get trips for the selected day via the helper
    final selectedDayTrips = DailyAnalyticsHelper.getTripsForDay(widget.allTrips, _selectedDate);

    return Scaffold(
      appBar: AppBar(
        title: Text('${_monthNames[_currentMonth.month - 1]} ${_currentMonth.year}'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () => _changeMonth(-1),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () => _changeMonth(1),
          ),
        ],
      ),
      body: Column(
        children: [
          CalendarGrid(
            currentMonth: _currentMonth,
            selectedDate: _selectedDate,
            allTrips: widget.allTrips,
            onDateSelected: (date) {
              setState(() => _selectedDate = date);
            },
          ),
          const Divider(height: 32),
          Expanded(
            child: DailyStatsList(
              selectedDayTrips: selectedDayTrips,
            ),
          ),
        ],
      ),
    );
  }
}