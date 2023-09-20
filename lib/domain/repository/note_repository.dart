import '../model/note.dart';

abstract class NoteRepository {
  Future<List<Note>> getNotes(); // 저장된 note를 list반환

  Future<Note?> getNoteById(int id); //

  Future<void> insertNote(Note note); // Note 객체를 입력받으면 note를 저장함

  Future<void> updateNote(Note note); // 업데이트

  Future<void> deleteNote(Note note); // 지우기
}