import 'dart:math';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/cupertino.dart';
import '../../../features/garage/data/cars_dao.dart';
import '../../service_locator.dart';
import '../database.dart';

Future<void> seedMockData(AppDatabase db) async {
  int carId;

  final carsDao = getIt<CarsDao>();
  final existingCars = await carsDao.getAllCars();

  if (existingCars.isEmpty) {
    debugPrint('Database is empty. Injecting a test car...');

    carId = await db.into(db.cars).insert(
      CarsCompanion.insert(
        vin: 'JF1GTACZ0M0XXXXXX',
        name: const drift.Value('Black 2021 Subaru Impreza'),
        savedTotalDistance: const drift.Value(45000),
      ),
    );

    debugPrint('Test cars injected successfully!');
  } else {
    carId = existingCars.first.id;
  }

  final trips = await (db.select(db.trips)..where((t) => t.carId.equals(carId))).get();

  if (trips.isEmpty) {
    final now = DateTime.now().millisecondsSinceEpoch;

    final tripId = await db.into(db.trips).insert(
      TripsCompanion.insert(
        carId: carId,
        startTimestamp: now - 3600000,
        endTimestamp: drift.Value(now),
        totalDistance: const drift.Value(12), // 12 km
      ),
    );

    // generate points (frames) of the trip
    final points = <TripPointsCompanion>[];
    final random = Random();

    // Starting coordinates
    double startLat = 50.450000;
    double startLon = 30.520000;

    for (int i = 0; i < 100; i++) {
      final timestamp = now - 3600000 + (i * 1000); // +1 second per point

      // Create graph fluctuations
      final speed = (50 + 30 * sin(i / 10)).toInt(); // Speed from 20 to 80
      final rpm = (2000 + 1200 * sin(i / 10)).toInt(); // RPM from 800 to 3200
      final coolant = 85 + random.nextInt(5);
      final oil = 92 + random.nextInt(3);
      final iat = 35 + random.nextInt(4);
      final maf = 12.0 + random.nextDouble() * 10.0;
      final fuel = 75 - (i ~/ 25);

      // Shift coordinates for each point (simulate movement in a straight line)
      final currentLat = startLat + (i * 0.0001);
      final currentLon = startLon + (i * 0.0001);

      points.add(TripPointsCompanion.insert(
        tripId: tripId,
        timestamp: timestamp,
        speed: speed.abs(),
        rpm: rpm.abs(),
        throttlePosition: (speed.abs() / 2).toInt(),
        coolantTemp: coolant,
        engineOilTemp: drift.Value(oil),
        intakeAirTemp: drift.Value(iat),
        maf: drift.Value(maf),
        fuelLevel: drift.Value(fuel),
        latitude: drift.Value(currentLat),
        longitude: drift.Value(currentLon),
      ));
    }

    // Store all 100 points in one request (batch) for speed
    await db.batch((batch) {
      batch.insertAll(db.tripPoints, points);
    });
  }
}