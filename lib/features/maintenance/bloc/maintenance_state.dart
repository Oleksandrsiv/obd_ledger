part of 'maintenance_bloc.dart';

class MaintenanceState {
  final bool isLoading;
  final List<MaintenanceTask> tasks; 
  final String? errorMessage;

  const MaintenanceState({
    this.isLoading = false,
    this.tasks = const [],
    this.errorMessage,
  });

  MaintenanceState copyWith({
    bool? isLoading,
    List<MaintenanceTask>? tasks,
    String? errorMessage,
  }) {
    return MaintenanceState(
      isLoading: isLoading ?? this.isLoading,
      tasks: tasks ?? this.tasks,
      errorMessage: errorMessage,
    );
  }
}