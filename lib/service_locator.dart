import 'package:get_it/get_it.dart';
import 'package:obd_ledger/services/nhtsa_api/nhtsa_api_client.dart';
import 'package:obd_ledger/services/vehicle_info_repository.dart';

import 'data/database/database.dart';
import 'data/database/daos.dart';
import 'services/obd_service/iobd_service.dart';
import 'services/obd_service/obd_service.dart';

final getIt = GetIt.instance;

void setupLocator() {
  // register DB
  getIt.registerLazySingleton<AppDatabase>(() => AppDatabase());

  getIt.registerLazySingleton<VehicleInfoRepository>(
          () => VehicleInfoRepository(getIt<CarsDao>(), getIt<NhtsaApiClient>())
  );

  //register API
  getIt.registerLazySingleton<NhtsaApiClient>(() => NhtsaApiClient());

  // register DAOs
  getIt.registerLazySingleton<CarsDao>(() => CarsDao(getIt<AppDatabase>()));
  getIt.registerLazySingleton<TripsDao>(() => TripsDao(getIt<AppDatabase>()));

  // register OBD service
  getIt.registerLazySingleton<IObdScanner>(() => ObdService());
}