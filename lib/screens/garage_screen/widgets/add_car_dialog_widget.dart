import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/car/car_bloc.dart';

class AddCarDialog extends StatefulWidget {
  const AddCarDialog({super.key});

  @override
  State<AddCarDialog> createState() => _AddCarDialogState();
}

class _AddCarDialogState extends State<AddCarDialog> {
  final _vinController = TextEditingController();
  final _mileageController = TextEditingController();

  @override
  void dispose() {
    _vinController.dispose();
    _mileageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New Car'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _vinController,
            decoration: const InputDecoration(labelText: 'VIN code (17 characters)'),
            textCapitalization: TextCapitalization.characters,
            maxLength: 17,
          ),
          TextField(
            controller: _mileageController,
            decoration: const InputDecoration(labelText: 'Current Mileage (km)'),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            final vin = _vinController.text.trim();
            final mileage = int.tryParse(_mileageController.text.trim()) ?? 0;

            if (vin.isNotEmpty) {
              context.read<CarBloc>().add(AddCar(vin, mileage));
              Navigator.pop(context);
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}