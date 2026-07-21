import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:obd_ledger/blocs/maintenance/maintenance_bloc.dart';
import 'package:obd_ledger/data/database/database.dart';

class MaintenanceCard extends StatelessWidget {
  final MaintenanceTask task;
  final int currentMileage;

  const MaintenanceCard({
    super.key,
    required this.task,
    required this.currentMileage,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    final distanceDriven = currentMileage - task.lastChangeKm;
    final remainingKm = task.intervalKm - distanceDriven;

    final progress = (distanceDriven / task.intervalKm).clamp(0.0, 1.0);

    // Consider it due soon if less than 500 km remains or is overdue
    final isUrgent = remainingKm <= 500;
    final statusColor = isUrgent ? colorScheme.error : colorScheme.primary;

    // Format deadline text
    final String dueDateText = remainingKm > 0
        ? 'in $remainingKm km'
        : 'Overdue by ${remainingKm.abs()} km';

    return Card(
      elevation: 0,
      color: isDark ? Colors.white10 : Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),

                  child: Icon(Icons.build, color: statusColor, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      if (task.description != null && task.description!.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          task.description!,
                          style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                        ),
                      ],
                      const SizedBox(height: 4),
                      Text(
                        dueDateText,
                        style: TextStyle(
                          fontSize: 14,
                          color: isUrgent ? statusColor : Colors.grey.shade500,
                          fontWeight: isUrgent ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.check_circle_outline),
                  color: Colors.grey.shade600,
                  tooltip: 'Mark as done',
                  onPressed: () {
                    // Mark as done (update lastChangeKm to the current mileage)
                    context.read<MaintenanceBloc>().add(
                      MarkTaskCompleted(task: task, currentMileage: currentMileage),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  color: colorScheme.error.withOpacity(0.7),
                  tooltip: 'Delete task',
                  onPressed: () {
                    context.read<MaintenanceBloc>().add(DeleteTask(task));
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 8,
                backgroundColor: isDark ? Colors.white12 : Colors.black12,
                color: statusColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}