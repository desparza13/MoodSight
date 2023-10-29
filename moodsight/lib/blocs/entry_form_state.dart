// entry_form_state.dart
part of 'entry_form_bloc.dart';

class EntryFormState extends Equatable {
  final String? selectedMood;
  final String? notes;
  final String? gratitude;
  final List<Entry> entryHistory;

  const EntryFormState({
    this.selectedMood,
    this.notes,
    this.gratitude,
    required this.entryHistory,
  });

  factory EntryFormState.initial() {
    return const EntryFormState(
      selectedMood: null,
      notes: null,
      gratitude: null,
      entryHistory: [],
    );
  }

  @override
  List<Object> get props => [selectedMood ?? '', notes ?? '', gratitude ?? '', entryHistory];
}

class EntryFormSaved extends EntryFormState {
  const EntryFormSaved({
    required List<Entry> entryHistory,
  }) : super(
          selectedMood: null,
          notes: null,
          gratitude: null,
          entryHistory: entryHistory,
        );
}
