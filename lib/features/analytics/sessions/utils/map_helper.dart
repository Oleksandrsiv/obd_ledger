import 'dart:isolate';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../../../core/database/database.dart';

class MapHelper {
  static Future<MapData> processTripPoints(List<TripPoint> points) async {
    if (points.isEmpty) return MapData([], LatLngBounds(const LatLng(0, 0), const LatLng(0, 0)));

    return await Isolate.run(() {
      final route = <LatLng>[];
      double? minLat, maxLat, minLng, maxLng;

      for (final p in points) {
        if (p.latitude != null && p.longitude != null) {
          final latLng = LatLng(p.latitude!, p.longitude!);
          route.add(latLng);

          // Calculate Bounds for centering the camera
          if (minLat == null || latLng.latitude < minLat) minLat = latLng.latitude;
          if (maxLat == null || latLng.latitude > maxLat) maxLat = latLng.latitude;
          if (minLng == null || latLng.longitude < minLng) minLng = latLng.longitude;
          if (maxLng == null || latLng.longitude > maxLng) maxLng = latLng.longitude;
        }
      }

      LatLngBounds? bounds;
      if (minLat != null && maxLat != null && minLng != null && maxLng != null) {
        bounds = LatLngBounds(LatLng(minLat, minLng), LatLng(maxLat, maxLng));
      }

      return MapData(route, bounds);
    });
  }
}

class MapData {
  final List<LatLng> route;
  final LatLngBounds? bounds;

  MapData(this.route, this.bounds);
}