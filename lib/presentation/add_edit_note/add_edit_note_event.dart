import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'add_edit_note_event.freezed.dart';

@freezed
class AddEditNoteEvent<T> with _$AddEditNoteEvent<T> { // 메모를 입력받을 때 화면임. 색깔을 바꾸는 이벤트와 노트를 저장하는 이벤트 2가지를 정의
  const factory AddEditNoteEvent.changeColor(int color) = ChangeColor;
  const factory AddEditNoteEvent.saveNote(int? id, String title, String content) = SaveNote;
}