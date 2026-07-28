import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/car/car_bloc.dart';
import '../../../data/database/database.dart';

void showRenameCarDialog(BuildContext context, Car car) { // Controller for the text field; we immediately populate it with the current name.
  final TextEditingController controller = TextEditingController(
    text: car.name ?? '',
  );

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Rename Car'),
        content: TextField(
          controller: controller,
          autofocus: true, // The keyboard will appear automatically
          decoration: const InputDecoration(
            labelText: 'Car Name',
            hintText: 'e.g., My Subaru',
            border: OutlineInputBorder(),
          ),
          textCapitalization: TextCapitalization.words,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Close without saving
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final newName = controller.text.trim();
              if (newName.isNotEmpty) {
                // Send the event to the BLoC
                context.read<CarBloc>().add(RenameCar(car.id, newName));
              }
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      );
    },
  );
}