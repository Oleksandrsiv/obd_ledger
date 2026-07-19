import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:obd_ledger/blocs/diagnostic/diagnostic_bloc.dart';
import 'package:obd_ledger/service_locator.dart';

import '../../blocs/dashboards/dashboard_bloc.dart';
import 'live_dashboard.dart';

class CarDetailsScreen extends StatefulWidget {
  final int carId;
  final String carMake;
  final String carName;

  const CarDetailsScreen({
    super.key,
    required this.carId,
    required this.carMake,
    required this.carName,
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
            const Center(child: Text('Maintenance Schedule', style: TextStyle(fontSize: 20))),
            LiveDashboardTab(carMake: widget.carMake),
            const Center(child: Text('Trip Analytics', style: TextStyle(fontSize: 20))),
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