import 'package:drift/drift.dart';

class Cars extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get vin => text().unique()();
  TextColumn get name => text().nullable()();

  // indicators
  IntColumn get savedTotalDistance => integer().withDefault(const Constant(0))();
  IntColumn get lastObdReading => integer().withDefault(const Constant(0))();
  BoolColumn get isAccuracyWarning => boolean().withDefault(const Constant(false))();

  // intervals
  IntColumn get oilInterval => integer().nullable()();
  IntColumn get oilLastChangeDistance => integer().withDefault(const Constant(0))();

  IntColumn get airFilterInterval => integer().nullable()();
  IntColumn get airFilterLastChangeDistance => integer().withDefault(const Constant(0))();

  IntColumn get cabinFilterInterval => integer().nullable()();
  IntColumn get cabinFilterLastChangeDistance => integer().withDefault(const Constant(0))();
}