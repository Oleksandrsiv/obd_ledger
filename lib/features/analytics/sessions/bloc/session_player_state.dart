import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/database/database.dart';

class SessionPlayerState {
  final bool isLoading;
  final List<TripPoint> points;
  final int currentIndex;
  final String? errorMessage;
  final List<LatLng> mapRoute;
  final LatLngBounds? mapBounds;

  const SessionPlayerState({
    this.isLoading = true,
    this.points = const [],
    this.currentIndex = 0,
    this.errorMessage,
    this.mapRoute = const [],
    this.mapBounds,
  });

// Helper getter for UI to quickly get the current point
  TripPoint? get currentPoint =>
      points.isNotEmpty ? points[currentIndex] : null;

  SessionPlayerState copyWith({
    bool? isLoading,
    List<TripPoint>? points,
    int? currentIndex,
    String? errorMessage,
    List<LatLng>? mapRoute,
    LatLngBounds? mapBounds,
  }) {
    return SessionPlayerState(
      isLoading: isLoading ?? this.isLoading,
      points: points ?? this.points,
      currentIndex: currentIndex ?? this.currentIndex,
      errorMessage: errorMessage,
      mapRoute: mapRoute ?? this.mapRoute,
      mapBounds: mapBounds ?? this.mapBounds,
    );
  }
}