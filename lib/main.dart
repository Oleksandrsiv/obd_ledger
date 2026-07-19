import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:obd_ledger/screens/garage_screen/garage_screen.dart';
import 'package:obd_ledger/screens/live_dashboard/car_details_screen.dart';
import 'package:obd_ledger/screens/live_dashboard/live_dashboard.dart';
import 'package:obd_ledger/service_locator.dart';
import 'package:obd_ledger/theme/theme_cubit.dart';
import 'blocs/bluetooth/bluetooth_cubit.dart';
import 'blocs/car/car_bloc.dart';
import 'blocs/diagnostic/diagnostic_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupLocator();

  runApp(const ObdLedgerApp());
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
            //home: const GarageScreen(),
            home: const CarDetailsScreen(
              carId: 1, // Тимчасовий ID для бази
              carMake: 'Subaru',
              carName: 'My Forester OBD',
            ),
          );
        },
      ),
    );
  }
}