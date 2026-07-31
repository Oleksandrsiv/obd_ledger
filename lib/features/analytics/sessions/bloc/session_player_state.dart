import '../../../../core/database/database.dart';

class SessionPlayerState {
  final bool isLoading;
  final List<TripPoint> points;
  final int currentIndex;
  final String? errorMessage;

  const SessionPlayerState({
    this.isLoading = true,
    this.points = const [],
    this.currentIndex = 0,
    this.errorMessage,
  });

// Helper getter for UI to quickly get the current point
  TripPoint? get currentPoint =>
      points.isNotEmpty ? points[currentIndex] : null;

  SessionPlayerState copyWith({
    bool? isLoading,
    List<TripPoint>? points,
    int? currentIndex,
    String? errorMessage,
  }) {
    return SessionPlayerState(
      isLoading: isLoading ?? this.isLoading,
      points: points ?? this.points,
      currentIndex: currentIndex ?? this.currentIndex,
      errorMessage: errorMessage,
    );
  }
}