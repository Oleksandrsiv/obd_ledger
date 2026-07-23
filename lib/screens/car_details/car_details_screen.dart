import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:obd_ledger/blocs/diagnostic/diagnostic_bloc.dart';
import 'package:obd_ledger/screens/car_details/tabs/analytics_tab/analytics_tab.dart';
import 'package:obd_ledger/screens/car_details/tabs/live_dashboard/live_dashboard.dart';
import 'package:obd_ledger/service_locator.dart';

import '../../blocs/dashboards/dashboard_bloc.dart';
import '../../blocs/maintenance/maintenance_bloc.dart';
import 'tabs/service_tab/service_tab.dart';

class CarDetailsScreen extends StatefulWidget {
  final int carId;
  final String carMake;
  final String carName;
  final int currentMileage;

  const CarDetailsScreen({
    super.key,
    required this.carId,
    required this.carMake,
    required this.carName,
    required this.currentMileage,
  });

  @override
  State<CarDetailsScreen> createState() => _CarDetailsScreenState();
}

class _CarDetailsScreenState extends State<CarDetailsScreen> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<DiagnosticBloc>()),
        BlocProvider(
          create: (context) => getIt<DashboardBloc>()..add(DashboardStartPolling(widget.carId)),
        ),
        BlocProvider(create: (context) => getIt<MaintenanceBloc>()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.carName),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: [
            ServiceTab(
              carMake: widget.carMake,
              currentMileage: widget.currentMileage,
              carId: widget.carId,
            ),
            LiveDashboardTab(carMake: widget.carMake),
            AnalyticsTab(),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.build_circle_outlined),
              selectedIcon: Icon(Icons.build_circle),
              label: 'Service',
            ),
            NavigationDestination(
              icon: Icon(Icons.speed_outlined),
              selectedIcon: Icon(Icons.speed),
              label: 'Dashboard',
            ),
            NavigationDestination(
              icon: Icon(Icons.analytics_outlined),
              selectedIcon: Icon(Icons.analytics),
              label: 'Analytics',
            ),
          ],
        ),
      ),
    );
  }
}