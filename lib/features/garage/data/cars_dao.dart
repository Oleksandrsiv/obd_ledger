import 'package:drift/drift.dart';
import '../../../core/database/database.dart';
import 'cars.dart';

part 'cars_dao.g.dart';

@DriftAccessor(tables: [Cars])
class CarsDao extends DatabaseAccessor<AppDatabase> with _$CarsDaoMixin {
  CarsDao(AppDatabase db) : super(db);

  Future<List<Car>> getAllCars() => select(cars).get();

  Future<Car?> getCarByVin(String vin) =>
      (select(cars)..where((c) => c.vin.equals(vin))).getSingleOrNull();

  Future<int> insertOrUpdateCar(Insertable<Car> car) =>
      into(cars).insertOnConflictUpdate(car);

  Future<int> deleteCar(int id) {
    return (delete(cars)..where((car) => car.id.equals(id))).go();
  }

}