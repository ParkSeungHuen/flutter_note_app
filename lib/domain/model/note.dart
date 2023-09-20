import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'note.freezed.dart';

part 'note.g.dart';

@freezed
class Note with _$Note { // freezed를 사용하는 이유 : 불변객체 만들기, copy및 기타 기능을 사용해서 함부로 수정 불가능 하도록
  factory Note({
    required String title,
    required String content,
    required int color,
    required int timestamp,
    int? id,
  }) = _Note;
  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);
}