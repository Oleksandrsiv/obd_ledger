import 'package:drift/drift.dart';
import 'package:drift/drift.dart' as drift;
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

  // Method for closing "hanging" trips
  Future<void> cleanUpOrphanedTrips() async {
    final orphanedTrips = await (select(trips)..where((t) => t.endTimestamp.isNull())).get();

    if (orphanedTrips.isEmpty) return;

    for (final trip in orphanedTrips) {
      final lastPoint = await (select(tripPoints)
        ..where((p) => p.tripId.equals(trip.id))
        ..orderBy([
              (p) => drift.OrderingTerm(expression: p.timestamp, mode: drift.OrderingMode.desc)
        ])
        ..limit(1))
          .getSingleOrNull();

      final endTimestamp = lastPoint?.timestamp ?? trip.startTimestamp;

      await update(trips).replace(
        trip.copyWith(
          endTimestamp: drift.Value(endTimestamp),
        ),
      );
    }
  }

  Future<TripPoint?> getLastKnownPosition(int carId) async {
    final query = select(tripPoints).join([
      innerJoin(trips, trips.id.equalsExp(tripPoints.tripId)),
    ])
      ..where(trips.carId.equals(carId) &
      tripPoints.latitude.isNotNull() &
      tripPoints.longitude.isNotNull())
      ..orderBy([OrderingTerm.desc(tripPoints.timestamp)])
      ..limit(1);

    final row = await query.getSingleOrNull();
    return row?.readTable(tripPoints);
  }
}