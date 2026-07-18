import 'package:drift/drift.dart';
import 'package:obd_ledger/data/database/tables/trip_points.dart';
import 'package:obd_ledger/data/database/tables/trips.dart';
import '../database.dart';

part 'trips_dao.g.dart';

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