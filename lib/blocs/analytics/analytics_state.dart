import '../../data/database/database.dart';

class AnalyticsState {
  final bool isLoading;
  final List<Trip> allTrips;
  final String? errorMessage;

  const AnalyticsState({
    this.isLoading = false,
    this.allTrips = const [],
    this.errorMessage,
  });

  AnalyticsState copyWith({
    bool? isLoading,
    List<Trip>? allTrips,
    String? errorMessage,
  }) {
    return AnalyticsState(
      isLoading: isLoading ?? this.isLoading,
      allTrips: allTrips ?? this.allTrips,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}