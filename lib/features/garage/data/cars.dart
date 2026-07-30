import 'package:drift/drift.dart';

class Cars extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get vin => text().unique()();
  TextColumn get name => text().nullable()();

  // indicators
  IntColumn get savedTotalDistance => integer().withDefault(const Constant(0))();
  IntColumn get lastObdReading => integer().withDefault(const Constant(0))();
  BoolColumn get isAccuracyWarning => boolean().withDefault(const Constant(false))();

}