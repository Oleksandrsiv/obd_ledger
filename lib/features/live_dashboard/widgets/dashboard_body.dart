import 'package:flutter/material.dart';
import 'gauges_section.dart';
import 'stats_section.dart';

class DashboardBody extends StatelessWidget {
  const DashboardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GaugesSection(),

          SizedBox(height: 32),

          StatsSection(),

          SizedBox(height: 24),
        ],
      ),
    );
  }
}