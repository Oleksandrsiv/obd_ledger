import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:obd_ledger/features/diagnostic/bloc/diagnostic_bloc.dart';
import 'package:obd_ledger/features/analytics/screens/analytics_tab.dart';
import 'package:obd_ledger/features/live_dashboard/screens/live_dashboard.dart';
import 'package:obd_ledger/core/service_locator.dart';

import '../../live_dashboard/bloc/dashboard_bloc.dart';
import '../../maintenance/bloc/maintenance_bloc.dart';
import '../../maintenance/screens/service_tab.dart';
import '../../../../core/widgets/app_confirm_dialog.dart';
import '../bloc/car_bloc.dart';

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
          create: (context) => getIt<DashboardBloc>()..add(DashboardStartPolling()),
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
          actions: [
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
              onPressed: () async {
                // We show the dialogue and wait for the response.
                final isConfirmed = await showAppConfirmDialog(
                  context: context,
                  title: 'Delete Vehicle?',
                  message: 'Are you sure you want to delete this car? This action cannot be undone and will erase all related trips and maintenance records.',
                  confirmText: 'Delete',
                  isDestructive: true,
                );

                // If the user clicked "Delete", we send an event to BLoC
                if (isConfirmed && context.mounted) {
                  context.read<CarBloc>().add(DeleteCarEvent(widget.carId));

                  // If we were on the car details screen, we go back to the garage
                  Navigator.of(context).pop();
                }
              },
            )

          ],
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