import 'package:flutter_note_app/domain/repository/note_repository.dart';
import 'package:injectable/injectable.dart';
import '../model/note.dart';
import '../util/note_order.dart';

@singleton
class GetNotesUseCase {
  NoteRepository repository;
  GetNotesUseCase(this.repository);

  Future<List<Note>> call(NoteOrder noteOrder) async { // 모든 저장한거 불러오기
    List<Note> notes = await repository.getNotes();

    noteOrder.when(
        title: (orderType) {
          orderType.when(
              ascending: (){
                notes.sort((a, b) => a.title.compareTo(b.title));
              },
              descending: (){
                notes.sort((a, b) => -a.title.compareTo(b.title));
              }
          );
        },
        date: (orderType){
          orderType.when(
              ascending: (){
                notes.sort((a, b) => a.timestamp.compareTo(b.timestamp)); // a와 b의 타임스탬프를 비교하여 마지막 수정 애를 아래로 내리기
              },
              descending: (){
                notes.sort((a, b) => -a.timestamp.compareTo(b.timestamp)); // a와 b의 타임스탬프를 비교하여 마지막 수정 애를 맨위로 올리기
              }
          );
        },
        color: (orderType) {
          orderType.when(
              ascending: (){
                notes.sort((a, b) => a.color.compareTo(b.color));
              },
              descending: (){
                notes.sort((a, b) => -a.color.compareTo(b.color));
              }
          );
        }
    );
    return notes;
  }
}