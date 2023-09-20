import 'package:flutter/material.dart';
import 'package:flutter_note_app/domain/repository/note_repository.dart';
import 'package:flutter_note_app/domain/repository/title_repository.dart';
import 'package:flutter_note_app/domain/use_case/add_note_use_case.dart';
import 'package:flutter_note_app/domain/use_case/delete_notes_use_case.dart';
import 'package:flutter_note_app/domain/use_case/use_cases.dart';
import 'package:flutter_note_app/presentation/notes/notes_event.dart';
import 'package:flutter_note_app/presentation/notes/notes_state.dart';
import 'package:injectable/injectable.dart';

import '../../domain/model/note.dart';
import '../../domain/use_case/get_notes_use_case.dart';
import '../../domain/util/note_order.dart';
import '../../domain/util/order_type.dart';

@injectable
class NotesViewModel with ChangeNotifier {
  final UseCases useCases;
  final TitleRepository titleRepository;

  NotesState _state = NotesState(
      notes: [],
      noteOrder: NoteOrder.date(OrderType.descending()), isOrderSectionVisible: false);
  NotesState get state => _state;

  Note? _recentlyDeletedNote;

  NotesViewModel(this.useCases, this.titleRepository) {
    _loadNotes();
  }

  void onEvent(NotesEvent event) { // 그래서 이 viewmodel에서는 onEvent안에 있는 기능들로만 event작성 가능
    event.when(
        loadNotes: _loadNotes,
        deleteNote: _deleteNote,
        restoreNote: _restoreNote,
      changeOrder: (NoteOrder noteOrder) {
          _state = state.copyWith(
            noteOrder: noteOrder,
          );
          _loadNotes();
      }, toggleOrderSection: () {
          _state = state.copyWith(
            isOrderSectionVisible: !state.isOrderSectionVisible
          );
          notifyListeners();
    },
    );
  }

  Future<void> _loadNotes() async {
    List<Note> notes = await useCases.getNotes(state.noteOrder);
    _state = state.copyWith(
      notes: notes,
    );
    notifyListeners();
  }

  Future<void> _deleteNote(Note note) async {
    await useCases.deleteNote(note);
    _recentlyDeletedNote = note;

    await _loadNotes();
  }

  Future<void> _restoreNote() async {
    if (_recentlyDeletedNote != null) {
      await useCases.addNote(_recentlyDeletedNote!);
      _recentlyDeletedNote = null;

      _loadNotes();
    }
  }

}