import 'package:flutter_note_app/domain/model/note.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

@singleton
class NoteDbHelper {
  Database db;
  NoteDbHelper(this.db);

  Future<Note?> getNoteById(int id) async {
    //? = [id]로 매핑, sql문으로 SELECT * FROM note WHERE id = 1
    final List<Map<String, dynamic>>maps = await db.query(
      'note',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Note.fromJson(maps.first);
    }
    else {
      return null;
    }

  }

  Future<List<Note>> getNotes() async {
    final maps = await db.query('note');
    return maps.map((e) => Note.fromJson(e)).toList(); // json데이터를 리스트 분류
  }

  Future<void> insertNote(Note note) async {
    await db.insert('note', note.toJson()); //insert구문을 사용할 경우 return으로 추가된 데이터의 id값이 나오는데 이를 상황에 맞게 이용 할 수 있다
  }

  Future<void> updataNote(Note note) async {
    await db.update(
        'note',
        note.toJson(),
      where: 'id = ?',
      whereArgs: [note.id]
    );
  }

  Future<void> deleteNote(Note note) async {
    await db.delete('note',
      where: 'id = ?',
      whereArgs: [note.id]
    );
  }

}