import 'package:flutter/material.dart';

/// Calls a unified dialog.
/// Returns [true] if the user clicked confirm, and [false] otherwise.
Future<bool> showAppConfirmDialog({
  required BuildContext context,
  required String title,
  required String message,
  String confirmText = 'Delete',
  String cancelText = 'Cancel',
  bool isDestructive = true, // If true - the button will be red
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (ctx) {
      final colorScheme = Theme.of(ctx).colorScheme;

      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(
              cancelText,
              style: TextStyle(color: colorScheme.onSurfaceVariant),
            ),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: isDestructive ? colorScheme.error : colorScheme.primary,
              foregroundColor: isDestructive ? colorScheme.onError : colorScheme.onPrimary,
            ),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(confirmText),
          ),
        ],
      );
    },
  );

  // If the user tapped outside the dialog (dismiss), return false
  return result ?? false;
}