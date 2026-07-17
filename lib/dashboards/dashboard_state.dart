part of 'dashboard_bloc.dart';

class DashboardState {
  final ObdConnectionState connectionStatus;
  final RealtimeData realtimeData;
  final bool isPolling;
  final String? errorMessage;

  const DashboardState({
    this.connectionStatus = ObdConnectionState.disconnected,
    required this.realtimeData,
    this.isPolling = false,
    this.errorMessage,
  });

  factory DashboardState.initial() {
    return DashboardState(
      realtimeData: RealtimeData.initial(),
    );
  }

  DashboardState copyWith({
    ObdConnectionState? connectionStatus,
    RealtimeData? realtimeData,
    bool? isPolling,
    String? errorMessage,
  }) {
    return DashboardState(
      connectionStatus: connectionStatus ?? this.connectionStatus,
      realtimeData: realtimeData ?? this.realtimeData,
      isPolling: isPolling ?? this.isPolling,
      errorMessage: errorMessage, // Дозволяємо скидати помилку в null
    );
  }
}