import 'package:flutter_note_app/domain/model/note.dart';
import 'package:flutter_note_app/domain/repository/note_repository.dart';
import 'package:flutter_note_app/domain/use_case/get_notes_use_case.dart';
import 'package:flutter_note_app/domain/util/note_order.dart';
import 'package:flutter_note_app/domain/util/order_type.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_notes_use_case_test.mocks.dart';

@GenerateMocks([NoteRepository]) // GenerateMocks 어노테이션을 사용하고 안에 테스트할 Repository 넣고 build runner
void main() {
  test('sort', () async {
    final repository = MockNoteRepository();
    final getNotes = GetNotesUseCase(repository);

    // 동작 정의
    when(repository.getNotes()).thenAnswer((_) async => [
      Note(title: 'title', content: 'content', color: 1, timestamp: 0),
      Note(title: 'title1', content: 'content2', color: 2, timestamp: 2)
    ]); // repository의 메소드 중 어떤 기능을 테스트 할 건지 Mockito에서 제공하는 when을 이용하여 테스트, fakedata 정의

    List<Note> result = await getNotes(const NoteOrder.date(OrderType.descending()));

    expect(result, isA<List<Note>>());
    expect(result.first.timestamp, 2);
    verify(repository.getNotes()); // verify를 이용하여 repository의 getNotes()가 실제로 실행되었는지 알 수 있다.

    result = await getNotes(NoteOrder.date(OrderType.ascending()));
    expect(result.first.timestamp, 0);

    // result = await getNotes(NoteOrder.title(OrderType.ascending()));
    // expect(result.first.title, 'title');
    //
    // result = await getNotes(NoteOrder.date(OrderType.ascending()));
    // expect(result.first.timestamp, 0);
    //
    // result = await getNotes(NoteOrder.date(OrderType.ascending()));
    // expect(result.first.timestamp, 0);
    //
    // result = await getNotes(NoteOrder.date(OrderType.ascending()));
    // expect(result.first.timestamp, 0);

    // verifyNoMoreInteractions(repository); // 이 코드가 실행된 이후에 repository를 이용한 무언가가 있는가? 를 테스트

  });

}