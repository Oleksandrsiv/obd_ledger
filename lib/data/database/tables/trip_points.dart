import 'package:drift/drift.dart';
import 'package:obd_ledger/data/database/tables/trips.dart';

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