import 'package:flutter_note_app/domain/model/note.dart';
import 'package:flutter_note_app/domain/repository/note_repository.dart';
import 'package:injectable/injectable.dart';

import '../data_source/note_db_helper.dart';

@Singleton(as: NoteRepository) // NoteRepository를 요구했을 경우 NoteRepositoryImpl을 출력해줌
class NoteRepositoryImpl implements NoteRepository { // domain 영역의 note_repository를 받아 여기서 구현
  final NoteDbHelper db; // db 안의 메소드 : deleteNote, getNoteById, getNotes, insertNote, updateNote가 구현되어있음
  NoteRepositoryImpl(this.db); //

  @override
  Future<void> deleteNote(Note note) async {
    await db.deleteNote(note);
  }

  @override
  Future<Note?> getNoteById(int id) async{
    return await db.getNoteById(id);
  }

  @override
  Future<List<Note>> getNotes() async {
    return await db.getNotes();
  }

  @override
  Future<void> insertNote(Note note) async {
    await db.insertNote(note);
  }

  @override
  Future<void> updateNote(Note note) async {
    await db.updataNote(note);
  }

}