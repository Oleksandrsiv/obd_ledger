import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:obd_ledger/features/garage/screens/garage_screen.dart';
import 'core/bluetooth/bluetooth_cubit.dart';
import 'core/database/database.dart';
import 'features/analytics/bloc/analytics_bloc.dart';
import 'features/garage/bloc/car_bloc.dart';
import 'core/theme/theme_cubit.dart';
import 'core/service_locator.dart';
import 'features/garage/data/cars_dao.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

// Initialize GetIt (all our BLoC, DAO, Services)
  await setupLocator();


  //await _seedDatabaseIfEmpty();

  runApp(const ObdLedgerApp());
}

// Function for creating a test car
Future<void> _seedDatabaseIfEmpty() async {
  final carsDao = getIt<CarsDao>();
  final existingCars = await carsDao.getAllCars();

  if (existingCars.isEmpty) {
    debugPrint('Database is empty. Injecting a test car...');

    // Create a test record
    await carsDao.insertOrUpdateCar(
      CarsCompanion.insert(
        vin: 'JF1GTACZ0M0XXXXXX',
        name: const drift.Value('Black 2021 Subaru Impreza'),
        savedTotalDistance: const drift.Value(45000),
      ),
    );

    debugPrint('Test cars injected successfully!');
  }
}


class ObdLedgerApp extends StatelessWidget {
  const ObdLedgerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<ThemeCubit>()),
        BlocProvider(create: (_) => getIt<CarBloc>()..add(LoadCars())),
        BlocProvider(create: (_) => getIt<BluetoothCubit>()),
        BlocProvider(create: (_) => getIt<AnalyticsBloc>()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, themeData) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'OBD Ledger',
            theme: themeData,
            home: const GarageScreen(),
            // home: const CarDetailsScreen(
            //   carId: 1,
            //   carMake: 'Subaru',
            //   carName: 'My Forester OBD', currentMileage: 500,
            // ),
          );
        },
      ),
    );
  }
}