import 'dart:convert';

import 'package:flutter_note_app/di/di_setup.dart';
import 'package:flutter_note_app/presentation/add_edit_note/add_edit_note_screen.dart';
import 'package:flutter_note_app/presentation/add_edit_note/add_edit_note_view_model.dart';
import 'package:flutter_note_app/presentation/notes/notes_screen.dart';
import 'package:flutter_note_app/presentation/notes/notes_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'domain/model/note.dart';
import 'domain/repository/note_repository.dart';

final GoRouter router = GoRouter(
  initialLocation: '/notes',
  routes: [
    GoRoute(
        path: '/notes',
      builder: (context, state) {
        return ChangeNotifierProvider(
          create: (_) => getIt<NotesViewModel>(), // 화면 만들어지면 새로 주입
          child: const NoteScreen(),
        );
      },
    ),
    GoRoute(
        path: '/add_note',
        builder: (context, state) {
          return ChangeNotifierProvider(create: (_) => getIt<NotesViewModel>(), child: const AddEditNoteScreen(),);
        }
    ),
    GoRoute(
        path: '/edit_note',
        builder: (context, state) {
          final Note note = Note.fromJson(jsonDecode(state.uri.queryParameters['note']!)); // queryParameters -> uri.queryParameters 이런식으로
          // router에 등록된 경로로 jsonEncode해서 직렬화 데이터 전송 및 jsonDecode해서 데이터를 역직렬화 수신
          return ChangeNotifierProvider(create: (_) => getIt<NotesViewModel>(), child: AddEditNoteScreen(note: note,),);
        }
    ),
  ],
);