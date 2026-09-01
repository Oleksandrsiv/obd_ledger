import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:obd_ledger/core/services/nhtsa_api/nhtsa_api_client.dart';
import 'package:obd_ledger/core/services/obd_service/iobd_service.dart';
import 'package:obd_ledger/core/services/obd_service/obd_service.dart';
import 'package:obd_ledger/core/services/trip_recording_service.dart';

import 'bluetooth/bluetooth_cubit.dart';
import 'bluetooth/bluetooth_prefs_repository.dart';
import 'bluetooth/permission_service.dart';
import 'database/database.dart';
import 'theme/theme_cubit.dart';

import '../features/analytics/data/trips_dao.dart';
import '../features/diagnostic/data/dtc_dao.dart';
import '../features/diagnostic/data/dtc_repository.dart';
import '../features/garage/data/cars_dao.dart';
import '../features/garage/repositories/vehicle_info_repository.dart';
import '../features/maintenance/data/maintenance_tasks_dao.dart';

import '../features/garage/domain/usecases/process_scanned_vin_usecase.dart';
import '../features/garage/domain/usecases/sync_mileage_usecase.dart';

import '../features/analytics/bloc/analytics_bloc.dart';
import '../features/diagnostic/bloc/diagnostic_bloc.dart';
import '../features/garage/bloc/car_bloc.dart';
import '../features/live_dashboard/bloc/dashboard_bloc.dart';
import '../features/maintenance/bloc/maintenance_bloc.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);

  // Core Services & DB
  getIt.registerLazySingleton<AppDatabase>(() => AppDatabase());
  getIt.registerLazySingleton<NhtsaApiClient>(() => NhtsaApiClient());
  getIt.registerLazySingleton<IObdScanner>(() => ObdService());
  getIt.registerLazySingleton<TripRecordingService>(() => TripRecordingService(getIt(), getIt()));
  getIt.registerLazySingleton(() => PermissionService());
  getIt.registerLazySingleton(() => BluetoothPrefsRepository(getIt()));

  // DAOs
  getIt.registerLazySingleton<CarsDao>(() => CarsDao(getIt()));
  getIt.registerLazySingleton<TripsDao>(() => TripsDao(getIt()));
  getIt.registerLazySingleton<DtcDao>(() => DtcDao(getIt()));
  getIt.registerLazySingleton<MaintenanceTasksDao>(() => MaintenanceTasksDao(getIt()));

  // Repositories
  getIt.registerLazySingleton<VehicleInfoRepository>(() => VehicleInfoRepository(getIt(), getIt()));
  getIt.registerLazySingleton<DtcRepository>(() => DtcRepository(getIt(), getIt()));

  // UseCases
  getIt.registerLazySingleton(() => ProcessScannedVinUseCase(getIt(), getIt()));
  getIt.registerLazySingleton(() => SyncMileageUseCase(getIt(), getIt()));

  // Blocs / Cubits
  getIt.registerFactory<ThemeCubit>(() => ThemeCubit(getIt()));
  getIt.registerFactory<DiagnosticBloc>(() => DiagnosticBloc(getIt()));
  getIt.registerFactory<BluetoothCubit>(() => BluetoothCubit(getIt(), getIt(), getIt()));
  getIt.registerFactory<DashboardBloc>(() => DashboardBloc(getIt()));
  getIt.registerFactory<AnalyticsBloc>(() => AnalyticsBloc(getIt()));
  getIt.registerFactory<MaintenanceBloc>(() => MaintenanceBloc(getIt()));

  getIt.registerFactory<CarBloc>(() => CarBloc(
    getIt(),
    getIt(),
    getIt<ProcessScannedVinUseCase>(),
    getIt<SyncMileageUseCase>(),
  ));
}