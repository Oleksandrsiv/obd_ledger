import 'package:drift/drift.dart';
import 'database.dart';
import 'tables.dart';

part 'daos.g.dart';

@DriftAccessor(tables: [Cars])
class CarsDao extends DatabaseAccessor<AppDatabase> with _$CarsDaoMixin {
  CarsDao(AppDatabase db) : super(db);

  Future<List<Car>> getAllCars() => select(cars).get();

  Future<Car?> getCarByVin(String vin) =>
      (select(cars)..where((c) => c.vin.equals(vin))).getSingleOrNull();

  Future<int> insertOrUpdateCar(Insertable<Car> car) =>
      into(cars).insertOnConflictUpdate(car);

}

@DriftAccessor(tables: [Trips, TripPoints])
class TripsDao extends DatabaseAccessor<AppDatabase> with _$TripsDaoMixin {
  TripsDao(AppDatabase db) : super(db);

  Future<int> startTrip(Insertable<Trip> trip) => into(trips).insert(trip);

  Future<void> insertTripPointsBatch(List<Insertable<TripPoint>> points) async {
    await batch((batch) {
      batch.insertAll(tripPoints, points);
    });
  }

  Future<List<TripPoint>> getPointsForTrip(int tripId) =>
      (select(tripPoints)..where((p) => p.tripId.equals(tripId))).get();

  Future<int> updateTripFields(int tripId, int endTimestamp) {
    return (update(trips)..where((t) => t.id.equals(tripId))).write(
      TripsCompanion(
        endTimestamp: Value(endTimestamp),
      ),
    );
  }
}