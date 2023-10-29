import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moodsight/models/entry.dart';

part 'entry_form_event.dart';
part 'entry_form_state.dart';

class EntryFormBloc extends Bloc<EntryFormEvent, EntryFormState> {
  EntryFormBloc() : super(EntryFormState.initial()) {
    // Registra el manejador de eventos para Guardar eventos
    on<SaveEntryEvent>((event, emit) {
      final currentState = state;
      final newEntry = Entry(
        selectedMood: event.selectedMood,
        notes: event.notes,
        gratitude: event.gratitude,
      );
      final updatedHistory = List<Entry>.from(currentState.entryHistory)..add(newEntry);
      emit(EntryFormSaved(entryHistory: updatedHistory));
    });
  }

}
