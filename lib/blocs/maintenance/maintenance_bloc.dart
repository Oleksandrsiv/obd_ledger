import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/database/database.dart';
import '../../data/database/daos/maintenance_tasks_dao.dart';

part 'maintenance_event.dart';
part 'maintenance_state.dart';

class MaintenanceBloc extends Bloc<MaintenanceEvent, MaintenanceState> {
  final MaintenanceTasksDao _dao;
  StreamSubscription<List<MaintenanceTask>>? _tasksSubscription;

  MaintenanceBloc(this._dao) : super(const MaintenanceState()) {
    on<LoadTasks>(_onLoadTasks);
    on<_TasksUpdated>(_onTasksUpdated);
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<MarkTaskCompleted>(_onMarkTaskCompleted);
  }

  void _onLoadTasks(LoadTasks event, Emitter<MaintenanceState> emit) {
    emit(state.copyWith(isLoading: true));

    _tasksSubscription?.cancel();

    _tasksSubscription = _dao.watchTasksForCar(event.carId).listen((tasks) {
      add(_TasksUpdated(tasks));
    });
  }

  void _onTasksUpdated(_TasksUpdated event, Emitter<MaintenanceState> emit) {
    emit(state.copyWith(isLoading: false, tasks: event.tasks, errorMessage: null));
  }

  Future<void> _onAddTask(AddTask event, Emitter<MaintenanceState> emit) async {
    try {
      await _dao.insertTask(event.task);
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Failed to add task: $e'));
    }
  }

  Future<void> _onUpdateTask(UpdateTask event, Emitter<MaintenanceState> emit) async {
    try {
      await _dao.updateTask(event.task);
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Failed to update task: $e'));
    }
  }

  Future<void> _onDeleteTask(DeleteTask event, Emitter<MaintenanceState> emit) async {
    try {
      await _dao.deleteTask(event.task);
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Failed to delete task: $e'));
    }
  }

  Future<void> _onMarkTaskCompleted(MarkTaskCompleted event, Emitter<MaintenanceState> emit) async {
    try {
      final updatedTask = event.task.copyWith(lastChangeKm: event.currentMileage);
      await _dao.updateTask(updatedTask);
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Failed to mark task as completed: $e'));
    }
  }

  @override
  Future<void> close() {
    _tasksSubscription?.cancel();
    return super.close();
  }
}