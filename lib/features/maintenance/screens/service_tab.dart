import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:obd_ledger/features/maintenance/bloc/maintenance_bloc.dart';

import '../widgets/add_task_dialog.dart';
import '../widgets/maintenance_card.dart';

class ServiceTab extends StatefulWidget {
  final int carId;
  final String carMake;
  final int currentMileage;

  const ServiceTab({
    super.key,
    required this.carId,
    required this.carMake,
    required this.currentMileage,
  });

  @override
  State<ServiceTab> createState() => _ServiceTabState();
}

class _ServiceTabState extends State<ServiceTab> {
  @override
  void initState() {
    super.initState();
    context.read<MaintenanceBloc>().add(LoadTasks(widget.carId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MaintenanceBloc, MaintenanceState>(
      builder: (context, state) {
        if (state.isLoading && state.tasks.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildHeader(context),
            const SizedBox(height: 24),

            if (state.tasks.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 40.0),
                  child: Text('No maintenance tasks yet. Tap + to add one.'),
                ),
              )
            else
              ...state.tasks.map((task) => Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: MaintenanceCard(
                  task: task,
                  currentMileage: widget.currentMileage,
                ),
              )),
          ],
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Maintenance',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Keep your ${widget.carMake} in top condition',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade500,
              ),
              softWrap: true,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        FloatingActionButton.small(
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => BlocProvider.value(
                // Provide the existing BLoC to the dialog
                value: context.read<MaintenanceBloc>(),
                child: AddTaskDialog(
                  carId: widget.carId,
                  currentMileage: widget.currentMileage,
                ),
              ),
            );
          },
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          child: const Icon(Icons.add),
        ),
      ],
    );
  }
}