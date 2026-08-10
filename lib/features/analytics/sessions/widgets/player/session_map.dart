import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../bloc/session_player_cubit.dart';
import '../../bloc/session_player_state.dart';

class SessionMap extends StatelessWidget {
  const SessionMap({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionPlayerCubit, SessionPlayerState>(
      builder: (context, state) {
        if (state.mapRoute.isEmpty) {
          return const Center(child: Text("No GPS data for this trip."));
        }

        final currentPoint = state.currentPoint;
        LatLng? currentMarkerPos;

        // Find the car's position. If the current point does not have GPS, we take the last known one.
        if (currentPoint?.latitude != null && currentPoint?.longitude != null) {
          currentMarkerPos = LatLng(currentPoint!.latitude!, currentPoint.longitude!);
        } else if (state.mapRoute.isNotEmpty) {
          // If the GPS is stuck at the start, place a marker at the beginning of the route
          currentMarkerPos = state.mapRoute.first;
        }

        return FlutterMap(
          options: MapOptions(
            initialCameraFit: state.mapBounds != null
                ? CameraFit.bounds(
              bounds: state.mapBounds!,
              padding: const EdgeInsets.all(32),
            )
                : null,
            // If there are no boundaries (for example, only 1 point), set the default center
            initialCenter: currentMarkerPos ?? const LatLng(0, 0),
            initialZoom: 15.0,
            interactionOptions: const InteractionOptions(
              flags: InteractiveFlag.all,
            ),
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.obd_ledger',
            ),

            // Route
            PolylineLayer(
              polylines: [
                Polyline(
                  points: state.mapRoute,
                  color: Colors.blueAccent,
                  strokeWidth: 4.0,
                ),
              ],
            ),

            // CAR MARKER (Synchronizes with slider)
            if (currentMarkerPos != null)
              MarkerLayer(
                markers: [
                  Marker(
                    point: currentMarkerPos,
                    width: 24,
                    height: 24,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                        boxShadow: const [
                          BoxShadow(color: Colors.black45, blurRadius: 4)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
          ],
        );
      },
    );
  }
}