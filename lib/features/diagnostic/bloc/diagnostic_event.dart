part of 'diagnostic_bloc.dart';

sealed class DiagnosticEvent {}

class LoadTroubleCodes extends DiagnosticEvent {
  final String make;

  LoadTroubleCodes(this.make);
}

class ClearTroubleCodes extends DiagnosticEvent {}