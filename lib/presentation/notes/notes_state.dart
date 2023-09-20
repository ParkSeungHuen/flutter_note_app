import 'package:flutter_note_app/domain/util/note_order.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/model/note.dart';

part 'notes_state.freezed.dart';

@freezed
class NotesState with _$NotesState {
  factory NotesState({
    required List<Note> notes, // default값으로 빈 배열
    required NoteOrder noteOrder,
    required bool isOrderSectionVisible,
  }) = _NotesState;
}