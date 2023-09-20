import 'package:flutter_note_app/domain/model/note.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/util/note_order.dart';

part 'notes_event.freezed.dart';

@freezed
abstract class NotesEvent with _$NotesEvent { // 이것을 만드는 이유 : 어떤 화면에서 이벤트를 구현할건데 이를 한 메서드로 묶기 위해
  const factory NotesEvent.loadNotes() = LoadNotes;
  const factory NotesEvent.deleteNote(Note note) = DeleteNote;
  const factory NotesEvent.restoreNote() = RestoreNote;
  const factory NotesEvent.changeOrder(NoteOrder noteOrder) = ChangeOrder;
  const factory NotesEvent.toggleOrderSection() = ToggleOrderSection;

}