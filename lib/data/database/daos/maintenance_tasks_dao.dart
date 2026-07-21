import 'package:drift/drift.dart';
import '../tables/maintenance_tasks.dart';
import '../tables/cars.dart';
import '../database.dart';

part 'maintenance_tasks_dao.g.dart';

@DriftAccessor(tables: [MaintenanceTasks, Cars])
class MaintenanceTasksDao extends DatabaseAccessor<AppDatabase> with _$MaintenanceTasksDaoMixin {
  MaintenanceTasksDao(super.db);

  Stream<List<MaintenanceTask>> watchTasksForCar(int carId) {
    return (select(maintenanceTasks)..where((t) => t.carId.equals(carId))).watch();
  }

  Future<int> insertTask(Insertable<MaintenanceTask> task) => into(maintenanceTasks).insert(task);

  Future<bool> updateTask(Insertable<MaintenanceTask> task) => update(maintenanceTasks).replace(task);

  Future<int> deleteTask(MaintenanceTask task) => delete(maintenanceTasks).delete(task);
}