part of 'maintenance_bloc.dart';

sealed class MaintenanceEvent {}

class LoadTasks extends MaintenanceEvent {
  final int carId;
  LoadTasks(this.carId);
}

class _TasksUpdated extends MaintenanceEvent {
  final List<MaintenanceTask> tasks;
  _TasksUpdated(this.tasks);
}

class AddTask extends MaintenanceEvent {
  final MaintenanceTasksCompanion task;
  AddTask(this.task);
}

class UpdateTask extends MaintenanceEvent {
  final MaintenanceTask task;
  UpdateTask(this.task);
}

class DeleteTask extends MaintenanceEvent {
  final MaintenanceTask task;
  DeleteTask(this.task);
}

class MarkTaskCompleted extends MaintenanceEvent {
  final MaintenanceTask task;
  final int currentMileage; 

  MarkTaskCompleted({
    required this.task,
    required this.currentMileage,
  });
}