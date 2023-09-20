import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_note_app/domain/repository/note_repository.dart';
import 'package:flutter_note_app/presentation/add_edit_note/add_edit_note_event.dart';
import 'package:flutter_note_app/presentation/add_edit_note/add_edit_note_ui_event.dart';
import 'package:flutter_note_app/ui/colors.dart';
import 'package:injectable/injectable.dart';

import '../../domain/model/note.dart';

@injectable
class AddEditNoteViewModel with ChangeNotifier{
  final NoteRepository repository;

  int _color = roseBud.value;
  int get color => _color;
  // 한번 listen을 하면 재 listen이 불가능, .broadcast();를 추가하면 다시 listen이 가능해진다ㅅ
  final _eventController = StreamController<AddEditNoteUiEvent>.broadcast(); // 이벤트가 발생할 때 마다 _eventController에 넣어줄 것이고


  Stream<AddEditNoteUiEvent> get eventStream => _eventController.stream;

  AddEditNoteViewModel(this.repository);

  void onEvent(AddEditNoteEvent event) {
    event.when(changeColor: _changeColor, saveNote: _saveNote);
  }

  Future<void> _changeColor(int color) async {
    _color = color;
    notifyListeners();
  }

  Future<void> _saveNote(int? id, String title, String content) async {

    if (title.isEmpty || content.isEmpty) {
      _eventController.add(AddEditNoteUiEvent.showSnackBar('제목이나 내용이 비어있습니다.'));
      return;
    }

    if (id == null) {
      await repository.insertNote(Note(
        title: title,
        content: content,
        color: _color,
        timestamp: DateTime.now().millisecondsSinceEpoch),
      );
    } else {
      await repository.updateNote(
        Note(
          id: id,
          title: title,
          content: content,
          color: _color,
          timestamp: DateTime.now().millisecondsSinceEpoch,
        )
      );
    }

    _eventController.add(AddEditNoteUiEvent.saveNote()); // 이벤트를 컨트롤러에 넣어주고, add_edit_note_screen에서 알아차릴 수 있게
  }
}