import 'package:drift/drift.dart';
import '../../analytics/data/trips.dart';

class TripPoints extends Table {
  IntColumn get id => integer().autoIncrement()();
  // Foreign key to the Trips table
  IntColumn get tripId => integer().references(Trips, #id, onDelete: KeyAction.cascade)();

  IntColumn get timestamp => integer()();
  IntColumn get speed => integer()();
  IntColumn get rpm => integer()();
  IntColumn get throttlePosition => integer()();
  IntColumn get coolantTemp => integer()();

  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();

  IntColumn get engineOilTemp => integer().nullable()();
  IntColumn get intakeAirTemp => integer().nullable()();
  IntColumn get fuelLevel => integer().nullable()();
  RealColumn get maf => real().nullable()();
}