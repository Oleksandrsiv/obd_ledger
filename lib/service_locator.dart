import 'package:get_it/get_it.dart';
import 'package:obd_ledger/blocs/analytics/analytics_bloc.dart';
import 'package:obd_ledger/repositories/dtc_repository.dart';
import 'package:obd_ledger/services/nhtsa_api/nhtsa_api_client.dart';
import 'package:obd_ledger/repositories/vehicle_info_repository.dart';
import 'package:obd_ledger/services/trip_recording_service.dart';
import 'package:obd_ledger/theme/theme_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'blocs/bluetooth/bluetooth_cubit.dart';
import 'blocs/dashboards/dashboard_bloc.dart';
import 'blocs/diagnostic/diagnostic_bloc.dart';
import 'blocs/maintenance/maintenance_bloc.dart';
import 'data/database/daos/cars_dao.dart';
import 'data/database/daos/dtc_dao.dart';
import 'data/database/daos/maintenance_tasks_dao.dart';
import 'data/database/daos/trips_dao.dart';
import 'data/database/database.dart';
import 'services/obd_service/iobd_service.dart';
import 'services/obd_service/obd_service.dart';
import 'blocs/car/car_bloc.dart';

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