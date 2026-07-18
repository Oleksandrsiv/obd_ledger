import 'package:drift/drift.dart';
import 'package:obd_ledger/data/database/tables/cars.dart';
import '../database.dart';


part 'cars_dao.g.dart';

@DriftAccessor(tables: [Cars])
class CarsDao extends DatabaseAccessor<AppDatabase> with _$CarsDaoMixin {
  CarsDao(AppDatabase db) : super(db);

  Future<List<Car>> getAllCars() => select(cars).get();

  Future<Car?> getCarByVin(String vin) =>
      (select(cars)..where((c) => c.vin.equals(vin))).getSingleOrNull();

  Future<int> insertOrUpdateCar(Insertable<Car> car) =>
      into(cars).insertOnConflictUpdate(car);

}