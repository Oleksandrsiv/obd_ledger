
part of 'diagnostic_bloc.dart';

class DiagnosticState {
  final bool isLoading;
  final List<DiagnosticCode> codes;
  final String? errorMessage;

  const DiagnosticState({
    this.isLoading = false,
    this.codes = const [],
    this.errorMessage,
  });

  DiagnosticState copyWith({
    bool? isLoading,
    List<DiagnosticCode>? codes,
    String? errorMessage,
  }) {
    return DiagnosticState(
      isLoading: isLoading ?? this.isLoading,
      codes: codes ?? this.codes,
      errorMessage: errorMessage,
    );
  }
}