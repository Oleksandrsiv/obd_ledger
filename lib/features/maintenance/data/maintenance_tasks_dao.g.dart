// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maintenance_tasks_dao.dart';

// ignore_for_file: type=lint
mixin _$MaintenanceTasksDaoMixin on DatabaseAccessor<AppDatabase> {
  $CarsTable get cars => attachedDatabase.cars;
  $MaintenanceTasksTable get maintenanceTasks =>
      attachedDatabase.maintenanceTasks;
  MaintenanceTasksDaoManager get managers => MaintenanceTasksDaoManager(this);
}

class MaintenanceTasksDaoManager {
  final _$MaintenanceTasksDaoMixin _db;
  MaintenanceTasksDaoManager(this._db);
  $$CarsTableTableManager get cars =>
      $$CarsTableTableManager(_db.attachedDatabase, _db.cars);
  $$MaintenanceTasksTableTableManager get maintenanceTasks =>
      $$MaintenanceTasksTableTableManager(
        _db.attachedDatabase,
        _db.maintenanceTasks,
      );
}
