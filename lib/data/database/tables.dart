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

class Trips extends Table {
  IntColumn get id => integer().autoIncrement()();
  // Foreign key to the Cars table
  IntColumn get carId => integer().references(Cars, #id)();

  IntColumn get startTimestamp => integer()();
  IntColumn get endTimestamp => integer().nullable()();
  IntColumn get totalDistance => integer().withDefault(const Constant(0))();
  IntColumn get averageRpm => integer().nullable()();
  IntColumn get averageSpeed => integer().nullable()();
}

class TripPoints extends Table {
  IntColumn get id => integer().autoIncrement()();
  // Foreign key to the Trips table
  IntColumn get tripId => integer().references(Trips, #id)();

  IntColumn get timestamp => integer()();
  IntColumn get speed => integer()();
  IntColumn get rpm => integer()();
  IntColumn get throttlePosition => integer()();
  IntColumn get engineTemp => integer()();
}