import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../../features/analytics/data/trips.dart';
import '../../features/diagnostic/data/dtc_cache.dart';
import '../../features/garage/data/cars.dart';
import '../../features/garage/data/cars_dao.dart';
import '../../features/diagnostic/data/dtc_dao.dart';
import '../../features/analytics/data/trips_dao.dart';
import '../../features/live_dashboard/data/trip_points.dart';
import '../../features/maintenance/data/maintenance_tasks.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [Cars, Trips, TripPoints, DtcCache, MaintenanceTasks],
  daos: [CarsDao, TripsDao, DtcDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'obd_app_db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}