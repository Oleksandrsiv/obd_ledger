import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:obd_ledger/features/garage/widgets/rename_car_dialog_window.dart';
import '../../../core/database/database.dart';
import '../../../features/garage/bloc/car_bloc.dart';
import '../screens/car_details_screen.dart';

class CarCard extends StatelessWidget {
  final Car car;
  final bool isActive;

  const CarCard({
  super.key,
  required this.car,
  required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isActive ? 4 : 1,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: isActive
              ? Theme.of(context).colorScheme.primary
              : Colors.transparent,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: isActive
              ? Theme.of(context).colorScheme.primary.withOpacity(0.2)
              : Colors.grey.withOpacity(0.2),
          child: Icon(
            Icons.directions_car,
            color: isActive
                ? Theme.of(context).colorScheme.primary
                : Colors.grey,
          ),
        ),
        title: Text(
          car.name ?? 'Unknown Car',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),

        subtitle: car.isAccuracyWarning
            ? Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: Theme.of(context).colorScheme.tertiary,
                size: 16,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  'Possible mileage error (OBD tampering)',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        )
            : null,
        trailing: IconButton(
          icon: const Icon(Icons.edit, size: 20),
          color: Colors.grey,
          onPressed: () {
            showRenameCarDialog(context, car);
          },
        ),

        onTap: () {
          context.read<CarBloc>().add(SelectCar(car.id));

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CarDetailsScreen(
                carId: car.id,
                carMake: car.name ?? 'Unknown',
                carName: car.name ?? 'My Car',
                currentMileage: car.savedTotalDistance ?? 0,
              ),
            ),
          );
        },
      ),
    );
  }
}