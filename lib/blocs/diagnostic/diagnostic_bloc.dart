import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/diagnostic_code.dart';
import '../../repositories/dtc_repository.dart';

part 'diagnostic_event.dart';
part 'diagnostic_state.dart';

class DiagnosticBloc extends Bloc<DiagnosticEvent, DiagnosticState> {
  final DtcRepository _dtcRepository;

  DiagnosticBloc(this._dtcRepository) : super(const DiagnosticState()) {
    on<LoadTroubleCodes>(_onLoadTroubleCodes);
    on<ClearTroubleCodes>(_onClearTroubleCodes);
  }

  Future<void> _onLoadTroubleCodes(
      LoadTroubleCodes event,
      Emitter<DiagnosticState> emit,
      ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final codes = await _dtcRepository.getTroubleCodes(event.make);

      emit(state.copyWith(
        isLoading: false,
        codes: codes,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: "Failed to read errors: $e",
      ));
    }
  }

  Future<void> _onClearTroubleCodes(
      ClearTroubleCodes event,
      Emitter<DiagnosticState> emit,
      ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final success = await _dtcRepository.clearTroubleCodes();
      if (success) {
        emit(state.copyWith(isLoading: false, codes: [], errorMessage: null));
      } else {
        emit(state.copyWith(isLoading: false, errorMessage: "Failed to clear codes"));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: "Error: $e"));
    }
  }
}