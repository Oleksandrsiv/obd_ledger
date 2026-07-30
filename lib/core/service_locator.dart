import 'package:get_it/get_it.dart';
import 'package:obd_ledger/core/services/nhtsa_api/nhtsa_api_client.dart';
import 'package:obd_ledger/core/services/obd_service/iobd_service.dart';
import 'package:obd_ledger/core/services/obd_service/obd_service.dart';
import 'package:obd_ledger/core/services/trip_recording_service.dart';
import 'package:obd_ledger/features/analytics/bloc/analytics_bloc.dart';
import 'package:obd_ledger/features/diagnostic/data/dtc_repository.dart';
import 'package:obd_ledger/features/garage/repositories/vehicle_info_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../features/analytics/data/trips_dao.dart';
import '../features/diagnostic/data/dtc_dao.dart';
import '../features/garage/data/cars_dao.dart';
import '../features/live_dashboard/bloc/dashboard_bloc.dart';
import '../features/diagnostic/bloc/diagnostic_bloc.dart';
import '../features/maintenance/bloc/maintenance_bloc.dart';
import '../features/maintenance/data/maintenance_tasks_dao.dart';
import 'bluetooth/bluetooth_cubit.dart';
import 'database/database.dart';
import 'theme/theme_cubit.dart';
import '../features/garage/bloc/car_bloc.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {

  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);

  // Core Services & DB
  getIt.registerLazySingleton<AppDatabase>(() => AppDatabase());

  if (!getIt.isRegistered<AppDatabase>()) {
    getIt.registerLazySingleton<AppDatabase>(() => AppDatabase());
  }

  getIt.registerLazySingleton<NhtsaApiClient>(() => NhtsaApiClient());

  getIt.registerLazySingleton<IObdScanner>(() => ObdService());

  if (!getIt.isRegistered<TripRecordingService>()) {
    getIt.registerLazySingleton<TripRecordingService>(
          () => TripRecordingService(getIt(), getIt()),
    );
  }


  // DAOs
  getIt.registerLazySingleton<CarsDao>(() => CarsDao(getIt<AppDatabase>()));
  getIt.registerLazySingleton<TripsDao>(() => TripsDao(getIt<AppDatabase>()));
  getIt.registerLazySingleton<DtcDao>(() => DtcDao(getIt<AppDatabase>()));
  if (!getIt.isRegistered<MaintenanceTasksDao>()) {
    getIt.registerLazySingleton<MaintenanceTasksDao>(
          () => MaintenanceTasksDao(getIt<AppDatabase>()),
    );
  }

  if (!getIt.isRegistered<CarsDao>()) {
    getIt.registerLazySingleton<CarsDao>(
          () => CarsDao(getIt<AppDatabase>()),
    );
  }

  // Repositories
  getIt.registerLazySingleton<VehicleInfoRepository>(
          () => VehicleInfoRepository(getIt<CarsDao>(), getIt<NhtsaApiClient>())
  );
  getIt.registerLazySingleton<DtcRepository>(
          () => DtcRepository(getIt<IObdScanner>(), getIt<DtcDao>())
  );

  // Blocs / Cubits
  getIt.registerFactory<ThemeCubit>(
          () => ThemeCubit(getIt<SharedPreferences>())
  );

  getIt.registerFactory<DiagnosticBloc>(
          () => DiagnosticBloc(getIt<DtcRepository>())
  );

  getIt.registerFactory<CarBloc>(
          () => CarBloc(getIt(), getIt(), getIt(),getIt())
  );

  getIt.registerFactory<BluetoothCubit>(
          () => BluetoothCubit(getIt<SharedPreferences>(), getIt<IObdScanner>())
  );

  if (!getIt.isRegistered<DashboardBloc>()) {
    getIt.registerFactory<DashboardBloc>(
          () => DashboardBloc(getIt<TripRecordingService>()),
    );
  }

    getIt.registerFactory<AnalyticsBloc>(
          () => AnalyticsBloc(getIt()),
    );

  if (!getIt.isRegistered<MaintenanceBloc>()) {
    getIt.registerFactory<MaintenanceBloc>(
          () => MaintenanceBloc(getIt<MaintenanceTasksDao>()),
    );
  }
}