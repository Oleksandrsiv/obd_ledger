import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:obd_ledger/data/database/tables/cars.dart';
import 'package:obd_ledger/data/database/tables/dtc_cache.dart';
import 'package:obd_ledger/data/database/tables/maintenance_tasks.dart';
import 'package:obd_ledger/data/database/tables/trip_points.dart';
import 'package:obd_ledger/data/database/tables/trips.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'daos/cars_dao.dart';
import 'daos/dtc_dao.dart';
import 'daos/trips_dao.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [Cars, Trips, TripPoints, DtcCache, MaintenanceTasks],
  daos: [CarsDao, TripsDao, DtcDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'obd_app_db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}