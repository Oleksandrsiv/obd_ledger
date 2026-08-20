import 'package:drift/drift.dart';
import '../../garage/data/cars.dart';

class Trips extends Table {
  IntColumn get id => integer().autoIncrement()();
  // Foreign key to the Cars table
  IntColumn get carId => integer().references(Cars, #id, onDelete: KeyAction.cascade)();

  IntColumn get startTimestamp => integer()();
  IntColumn get endTimestamp => integer().nullable()();
  IntColumn get totalDistance => integer().withDefault(const Constant(0))();
  IntColumn get averageRpm => integer().nullable()();
  IntColumn get averageSpeed => integer().nullable()();
}