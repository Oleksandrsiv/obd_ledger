import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:obd_ledger/screens/garage_screen/widgets/car_card_widget.dart';
import 'package:obd_ledger/screens/garage_screen/widgets/connection_status_light.dart';
import 'package:obd_ledger/screens/garage_screen/widgets/emty_garage_widget.dart';
import '../../blocs/car/car_bloc.dart';
import '../seting_screen/seting_screen.dart';

class GarageScreen extends StatelessWidget {
  const GarageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Garage'),
        actions: [
          const Center(child: ConnectionStatusLight()),

          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              );
            },
            tooltip: 'Settings',
          ),
        ],
      ),
      body: BlocBuilder<CarBloc, CarState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.carsList.isEmpty) {
            return const EmptyGarageView();
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.carsList.length,
            itemBuilder: (context, index) {
              final car = state.carsList[index];
              final isActive = state.activeCar?.id == car.id;

              return CarCard(car: car, isActive: isActive);
            },
          );
        },
      ),
    );
  }
}
