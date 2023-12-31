import 'package:flutter_note_app/domain/use_case/add_note_use_case.dart';
import 'package:flutter_note_app/domain/use_case/delete_notes_use_case.dart';
import 'package:flutter_note_app/domain/use_case/get_notes_use_case.dart';
import 'package:flutter_note_app/domain/use_case/updata_note_use_case.dart';
import 'package:injectable/injectable.dart';

import 'get_note_use_case.dart';

@singleton
class UseCases {
  final AddNoteUseCase addNote;
  final DeleteNoteUseCase deleteNote;
  final GetNotesUseCase getNotes;
  final GetNoteUseCase getNote;
  final UpdateNoteUseCase updateNote;

  UseCases({
    required this.addNote,
    required this.deleteNote,
    required this.getNotes,
    required this.getNote,
    required this.updateNote,
  });

}