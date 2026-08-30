import 'package:drift/drift.dart';
import '../../garage/data/cars.dart';

class MaintenanceTasks extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get carId => integer().references(Cars, #id, onDelete: KeyAction.cascade)();

  TextColumn get title => text()();

  TextColumn get description => text().nullable()();

  IntColumn get intervalKm => integer()();

  IntColumn get lastChangeKm => integer()();
}