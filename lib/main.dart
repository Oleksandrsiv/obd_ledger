import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:obd_ledger/data/database/daos/cars_dao.dart';
import 'package:obd_ledger/data/database/database.dart';
import 'package:obd_ledger/screens/car_details/car_details_screen.dart';
import 'package:obd_ledger/screens/garage_screen/garage_screen.dart';
import 'package:obd_ledger/theme/theme_cubit.dart';
import 'blocs/bluetooth/bluetooth_cubit.dart';
import 'blocs/car/car_bloc.dart';
import 'service_locator.dart';

void main() async {
  // Обов'язково для виклику асинхронного коду до runApp
  WidgetsFlutterBinding.ensureInitialized();

  // Ініціалізуємо GetIt (всі наші BLoC, DAO, Сервіси)
  await setupLocator();

  // --- ДОДАЄМО СІДУВАННЯ БАЗИ ДАНИХ ---
  await _seedDatabaseIfEmpty();

  runApp(const ObdLedgerApp());
}

// Функція для створення тестового авто
Future<void> _seedDatabaseIfEmpty() async {
  final carsDao = getIt<CarsDao>();
  final existingCars = await carsDao.getAllCars();

  if (existingCars.isEmpty) {
    debugPrint('Database is empty. Injecting a test car...');

    // Створюємо тестовий запис
    await carsDao.insertOrUpdateCar(
      CarsCompanion.insert(
        vin: 'JF1GTACZ0M0XXXXXX', // Типовий формат VIN
        name: const drift.Value('Black 2021 Subaru Impreza'),
        savedTotalDistance: const drift.Value(45000), // Тестовий пробіг
      ),
    );

    // Ти також можеш додати сюди друге авто для тестів, якщо потрібно:
    await carsDao.insertOrUpdateCar(
      CarsCompanion.insert(
        vin: 'JF2SJACZ0G0YYYYYY',
        name: const drift.Value('2015 Subaru Forester'),
        savedTotalDistance: const drift.Value(120000),
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
      ],
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, themeData) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'OBD Ledger',
            theme: themeData,
            home: const GarageScreen(),
            // home: const CarDetailsScreen(
            //   carId: 1, // Тимчасовий ID для бази
            //   carMake: 'Subaru',
            //   carName: 'My Forester OBD', currentMileage: 500,
            // ),
          );
        },
      ),
    );
  }
}