import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:obd_ledger/features/maintenance/bloc/maintenance_bloc.dart';

import '../../../core/database/database.dart';

class AddTaskDialog extends StatefulWidget {
  final int carId;
  final int currentMileage;

  const AddTaskDialog({
    super.key,
    required this.carId,
    required this.currentMileage,
  });

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _intervalController = TextEditingController();
  late TextEditingController _lastChangeController;

  @override
  void initState() {
    super.initState();
    _lastChangeController = TextEditingController(text: widget.currentMileage.toString());
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _intervalController.dispose();
    _lastChangeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New Maintenance Task'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Task Name (e.g. Engine Oil)'),
                validator: (val) => val == null || val.isEmpty ? 'Required field' : null,
              ),
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(labelText: 'Description (e.g. 0W-20)'),
              ),
              TextFormField(
                controller: _intervalController,
                decoration: const InputDecoration(labelText: 'Interval (km)', suffixText: 'km'),
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val == null || val.isEmpty) return 'Required field';
                  if (int.tryParse(val) == null) return 'Must be a number';
                  return null;
                },
              ),
              TextFormField(
                controller: _lastChangeController,
                decoration: const InputDecoration(labelText: 'Last changed at (km)'),
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val == null || val.isEmpty) return 'Required field';
                  if (int.tryParse(val) == null) return 'Must be a number';
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final newTask = MaintenanceTasksCompanion(
                carId: drift.Value(widget.carId),
                title: drift.Value(_titleController.text),
                description: drift.Value(_descController.text.isNotEmpty ? _descController.text : null),
                intervalKm: drift.Value(int.parse(_intervalController.text)),
                lastChangeKm: drift.Value(int.parse(_lastChangeController.text)),
              );

              // Відправляємо подію в BLoC
              context.read<MaintenanceBloc>().add(AddTask(newTask));
              Navigator.pop(context);
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}