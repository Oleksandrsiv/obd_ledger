import 'package:get_it/get_it.dart';
import 'package:obd_ledger/services/dtc_repository.dart';
import 'package:obd_ledger/services/nhtsa_api/nhtsa_api_client.dart';
import 'package:obd_ledger/services/vehicle_info_repository.dart';
import 'package:obd_ledger/theme/theme_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'blocs/bluetooth/bluetooth_cubit.dart';
import 'blocs/diagnostic/diagnostic_bloc.dart';
import 'data/database/daos/cars_dao.dart';
import 'data/database/daos/dtc_dao.dart';
import 'data/database/daos/trips_dao.dart';
import 'data/database/database.dart';
import 'services/obd_service/iobd_service.dart';
import 'services/obd_service/obd_service.dart';
import 'blocs/car/car_bloc.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {

  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);

  // register themes
  getIt.registerFactory<ThemeCubit>(() => ThemeCubit(getIt<SharedPreferences>()));

  // register DB
  getIt.registerLazySingleton<AppDatabase>(() => AppDatabase());

  getIt.registerLazySingleton<VehicleInfoRepository>(
          () => VehicleInfoRepository(getIt<CarsDao>(), getIt<NhtsaApiClient>())
  );

  // register API
  getIt.registerLazySingleton<NhtsaApiClient>(() => NhtsaApiClient());

  // register DAOs
  getIt.registerLazySingleton<CarsDao>(() => CarsDao(getIt<AppDatabase>()));
  getIt.registerLazySingleton<TripsDao>(() => TripsDao(getIt<AppDatabase>()));

  // register OBD service
  getIt.registerLazySingleton<IObdScanner>(() => ObdService());

  // register repository
  getIt.registerLazySingleton<DtcRepository>(
          () => DtcRepository(getIt<IObdScanner>(), getIt<DtcDao>())
  );

  getIt.registerFactory<DiagnosticBloc>(
          () => DiagnosticBloc(getIt<DtcRepository>())
  );

  getIt.registerFactory<CarBloc>(() => CarBloc(getIt(), getIt()));

  // Bluetooth
  getIt.registerFactory<BluetoothCubit>(
          () => BluetoothCubit(getIt<SharedPreferences>(), getIt<IObdScanner>())
  );
}