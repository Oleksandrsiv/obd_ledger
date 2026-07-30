import 'package:drift/drift.dart';
import 'package:obd_ledger/features/analytics/data/trips.dart';
import '../../../core/database/database.dart';
import '../../live_dashboard/data/trip_points.dart';

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

  Future<int> updateTrip(int tripId, TripsCompanion companion) {
    return (update(trips)..where((t) => t.id.equals(tripId))).write(companion);
  }

  Future<List<Trip>> getTripsForCar(int carId) {
    return (select(trips)..where((t) => t.carId.equals(carId))).get();
  }
}