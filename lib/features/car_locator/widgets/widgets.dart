import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';

import '../../../../core/service_locator.dart';
import '../../analytics/data/trips_dao.dart';
import '../bloc/car_locator_cubit.dart';
import '../bloc/car_locator_state.dart';

class CarLocatorBottomSheet extends StatelessWidget {
  final String carName;

  const CarLocatorBottomSheet({super.key, required this.carName});

  static void show(BuildContext context, int carId, String carName) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider(
        create: (context) => CarLocatorCubit(getIt<TripsDao>(), carId),
        child: CarLocatorBottomSheet(carName: carName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Last known location: $carName',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),

          // Body with map or upload
          Expanded(
            child: BlocBuilder<CarLocatorCubit, CarLocatorState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.errorMessage != null && state.carPosition == null) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        state.errorMessage!,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Theme.of(context).colorScheme.error),
                      ),
                    ),
                  );
                }

                if (state.carPosition == null) {
                  return const Center(
                    child: Text(
                      'No GPS data found for this car yet.\nTake a ride to record the location!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  );
                }

                // Calculate the bounds so that the camera encompasses both points
                final bounds = state.userPosition != null
                    ? LatLngBounds.fromPoints([state.carPosition!, state.userPosition!])
                    : LatLngBounds.fromPoints([state.carPosition!]);

                return FlutterMap(
                  options: MapOptions(
                    // Automatically scale the camera to fit the car and the person (50-pixel margins)
                    initialCameraFit: CameraFit.bounds(
                      bounds: bounds,
                      padding: const EdgeInsets.all(50.0),
                    ),
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.yourcompany.obdledger',
                    ),
                    MarkerLayer(
                      markers: [
                        // Machine marker (Red)
                        Marker(
                          point: state.carPosition!,
                          width: 50,
                          height: 50,
                          child: const Icon(
                            Icons.directions_car,
                            color: Colors.red,
                            size: 40,
                          ),
                        ),
                        // User marker (blue), if GPS is available
                        if (state.userPosition != null)
                          Marker(
                            point: state.userPosition!,
                            width: 50,
                            height: 50,
                            child: const Icon(
                              Icons.person_pin_circle,
                              color: Colors.blue,
                              size: 40,
                            ),
                          ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}