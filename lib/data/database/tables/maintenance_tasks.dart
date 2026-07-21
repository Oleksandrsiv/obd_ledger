import 'package:drift/drift.dart';
import 'cars.dart';

class MaintenanceTasks extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get carId => integer().references(Cars, #id)();

  TextColumn get title => text()();

  TextColumn get description => text().nullable()();

  IntColumn get intervalKm => integer()();

  IntColumn get lastChangeKm => integer()();
}