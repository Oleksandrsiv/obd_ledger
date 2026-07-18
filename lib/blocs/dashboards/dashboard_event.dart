part of 'dashboard_bloc.dart';

sealed class DashboardEvent {}

class DashboardInitialized extends DashboardEvent {}

class DashboardConnectionChanged extends DashboardEvent {
  final ObdConnectionState status;
  DashboardConnectionChanged(this.status);
}

class DashboardStartPolling extends DashboardEvent {}

class DashboardStopPolling extends DashboardEvent {}

class _DashboardPollingTick extends DashboardEvent {}