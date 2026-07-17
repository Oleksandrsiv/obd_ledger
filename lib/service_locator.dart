import 'package:get_it/get_it.dart';

import 'data/database/database.dart';
import 'data/database/daos.dart';
import 'services/obd_service/iobd_service.dart';
import 'services/obd_service/obd_service.dart';

final getIt = GetIt.instance;

void setupLocator() {
  // 1) register DB
  getIt.registerLazySingleton<AppDatabase>(() => AppDatabase());

  // 2) register DAOs
  getIt.registerLazySingleton<CarsDao>(() => CarsDao(getIt<AppDatabase>()));
  getIt.registerLazySingleton<TripsDao>(() => TripsDao(getIt<AppDatabase>()));

  // 3) register OBD service
  getIt.registerLazySingleton<IObdScanner>(() => ObdService());
}