// entry_form_event.dart
part of 'entry_form_bloc.dart';

abstract class EntryFormEvent extends Equatable {
  const EntryFormEvent();

  @override
  List<Object> get props => [];
}

class SaveEntryEvent extends EntryFormEvent {
  final String? selectedMood;
  final String? notes;
  final String? gratitude;

  const SaveEntryEvent({
    this.selectedMood, //Emoji elegido
    this.notes, //Notas del día
    this.gratitude, //Cosa que estás agradecido en el día
  });

  @override
  List<Object> get props => [selectedMood ?? '', notes ?? '', gratitude ?? ''];
}
