// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trips_dao.dart';

// ignore_for_file: type=lint
mixin _$TripsDaoMixin on DatabaseAccessor<AppDatabase> {
  $CarsTable get cars => attachedDatabase.cars;
  $TripsTable get trips => attachedDatabase.trips;
  $TripPointsTable get tripPoints => attachedDatabase.tripPoints;
  TripsDaoManager get managers => TripsDaoManager(this);
}

class TripsDaoManager {
  final _$TripsDaoMixin _db;
  TripsDaoManager(this._db);
  $$CarsTableTableManager get cars =>
      $$CarsTableTableManager(_db.attachedDatabase, _db.cars);
  $$TripsTableTableManager get trips =>
      $$TripsTableTableManager(_db.attachedDatabase, _db.trips);
  $$TripPointsTableTableManager get tripPoints =>
      $$TripPointsTableTableManager(_db.attachedDatabase, _db.tripPoints);
}
