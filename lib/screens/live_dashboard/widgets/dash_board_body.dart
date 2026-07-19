import 'package:flutter/material.dart';
import 'gauges_section.dart';
import 'stats_section.dart'; // Створимо цей файл для нижніх карток

class DashboardBody extends StatelessWidget {
  const DashboardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GaugesSection(),

          SizedBox(height: 56),

          StatsSection(),
        ],
      ),
    );
  }
}