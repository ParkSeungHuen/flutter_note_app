import 'package:flutter_note_app/domain/repository/note_repository.dart';
import 'package:injectable/injectable.dart';

import '../model/note.dart';

@singleton
class GetNoteUseCase {
  final NoteRepository repository;

  GetNoteUseCase(this.repository);

  Future<Note?> call(int id) async {
    await repository.getNoteById(id);
  }

}