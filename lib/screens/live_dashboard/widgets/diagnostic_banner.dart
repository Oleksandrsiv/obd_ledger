import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:obd_ledger/blocs/diagnostic/diagnostic_bloc.dart';

class DiagnosticWarningBanner extends StatelessWidget {
  const DiagnosticWarningBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiagnosticBloc, DiagnosticState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const LinearProgressIndicator();
        }

        final hasErrors = state.codes.isNotEmpty || state.errorMessage != null;
        final colorScheme = Theme.of(context).colorScheme;
        final isDark = Theme.of(context).brightness == Brightness.dark;

        return AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOutCubic,
          child: !hasErrors
              ? const SizedBox.shrink()
              : Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorScheme.error.withOpacity(isDark ? 0.15 : 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: colorScheme.error.withOpacity(0.5),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.warning_amber_rounded, color: colorScheme.error),
                    const SizedBox(width: 8),
                    Text(
                      'Check Engine / DTC Detected',
                      style: TextStyle(
                        color: colorScheme.error,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                ...state.codes.map((dtc) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    '• ${dtc.code}: ${dtc.description}',
                    style: TextStyle(
                      color: isDark ? Colors.white70 : Colors.black87,
                    ),
                  ),
                )),

                if (state.errorMessage != null)
                  Text(
                    state.errorMessage!,
                    style: TextStyle(color: colorScheme.error),
                  ),

                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: FilledButton.tonal(
                    onPressed: () {
                      context.read<DiagnosticBloc>().add(ClearTroubleCodes());
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: colorScheme.error,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Clear Codes'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}