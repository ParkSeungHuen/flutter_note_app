import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_note_app/domain/repository/note_repository.dart';
import 'package:flutter_note_app/presentation/add_edit_note/add_edit_note_screen.dart';
import 'package:flutter_note_app/presentation/add_edit_note/add_edit_note_view_model.dart';
import 'package:flutter_note_app/presentation/notes/components/order_section.dart';
import 'package:flutter_note_app/presentation/notes/notes_event.dart';
import 'package:flutter_note_app/presentation/notes/notes_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'components/note_item.dart';

class NoteScreen extends StatelessWidget {
  const NoteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel =
        context.watch<NotesViewModel>(); // viewModel은 NotesViewModel
    final state = viewModel.state;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            viewModel.titleRepository.getTitle(),
            style: TextStyle(fontSize: 30),
          ),
          actions: [IconButton(onPressed: () {
            viewModel.onEvent(NotesEvent.toggleOrderSection());

          },
              icon: const Icon(Icons.sort))],
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            bool? isSaved = await context.push('/add_note');// 만약 저장버튼을 누르면 isSaved에 true 값이 들어옴

            if (isSaved != null && isSaved) {
              viewModel.onEvent(
                  NotesEvent.loadNotes()); // 만약 저장을 눌렀을 경우 loadNotes를 실행ㅅ
            }
          },
          child: const Icon(Icons.add),
        ),


        body: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(children: [
            AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: state.isOrderSectionVisible
                    ? OrderSection(
                        noteOrder: state.noteOrder,
                        onOrderChanged: (noteOrder) {
                          viewModel.onEvent(NotesEvent.changeOrder(noteOrder));
                        },
                      )
                    : Container()),
            ...state.notes
                .map(
                  (note) => GestureDetector(
                    onTap: () async {
                      final uri = Uri(
                        path: '/edit_note',
                        queryParameters: {'note': jsonEncode(note.toJson())},
                      );
                      bool? isSaved = await context.push(uri.toString());

                      if (isSaved != null && isSaved) {
                        viewModel.onEvent(NotesEvent
                            .loadNotes()); // 만약 저장을 눌렀을 경우 loadNotes를 실행ㅅ
                      }
                    },
                    child: NoteItem(
                      note: note,
                      onDeleteTap: () {
                        viewModel.onEvent(NotesEvent.deleteNote(note));

                        final snackBar = SnackBar(
                          content: Text('노트가 삭제되었습니다'),
                          action: SnackBarAction(
                            label: '취소',
                            onPressed: () {
                              viewModel.onEvent(NotesEvent.restoreNote());
                            },
                          ),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                    ),
                  ),
                )
                .toList()
          ]),
        ));
  }
}
