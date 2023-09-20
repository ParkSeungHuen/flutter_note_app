import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_note_app/presentation/add_edit_note/add_edit_note_event.dart';
import 'package:flutter_note_app/presentation/add_edit_note/add_edit_note_view_model.dart';
import 'package:flutter_note_app/ui/colors.dart';
import 'package:provider/provider.dart';

import '../../domain/model/note.dart';

class AddEditNoteScreen extends StatefulWidget {
  final Note? note; // Note가 들어올 수도, 안들어올 수도 있음... 왜냐하면 새로 글을 쓸 경우 note객체가 없기 때문

  const AddEditNoteScreen({Key? key, this.note}) : super(key: key);

  @override
  State<AddEditNoteScreen> createState() => _AddEditNoteScreenState();
}

class _AddEditNoteScreenState extends State<AddEditNoteScreen> {
  final _titleController = TextEditingController(); // 타이틀 텍스트폼
  final _contentController = TextEditingController(); // 내용 텍스트폼
  StreamSubscription? _streamSubscription; // initState안에 listen은 앱이 실행되고 있을 때에도 listen을 하고 있기 때문에 StreamSubscription을 이용하여 조절해준다.

  final List<Color> noteColors = [
    roseBud,
    primrose,
    wisteria,
    skyBlue,
    illusion
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.microtask(() {
      final viewModel = context.read<AddEditNoteViewModel>();
      if (widget.note != null) {
        _titleController.text = widget.note!.title;
        _contentController.text = widget.note!.content;
        viewModel.onEvent(AddEditNoteEvent.changeColor(widget.note!.color)); // 전달받은 노트값으로 바꾸기
      }
      // 저장을 할 경우 저장된 값을 바로 보기 위해 처리를 해주어야 한다.
      // add_edit_note_event를 새로 만들어서 저장할 경우에 새로 고침 해주는 파일을 하나 만든다.
      // add_edit_note_view_model 에서 일이 발생할 경우 eventStream에 값이 들어올 것 이고
      // 이를 읽어옴으로써 감지한다
      _streamSubscription = viewModel.eventStream.listen((event) {
        event.when(saveNote: () {
          Navigator.pop(context, true); // 만약 pop을 하면서 true값이 같이 넘어왔다면 저장을 한 것이고, 아무런 값이 안넘어갔다면 그냥 뒤로가기를 누른 것.
        }, showSnackBar: (String message) {
          final snackBar = SnackBar(content: Text(message));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        );
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _titleController.dispose(); // 화면이 꺼지면 컨트롤러들을 끄기
    _streamSubscription?.cancel(); // streamSubscription이 있다면 cancel해줌
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AddEditNoteViewModel>();

    return Scaffold(

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          viewModel.onEvent(AddEditNoteEvent.saveNote(
              widget.note == null ? null : widget.note!.id,
              _titleController.text,
              _contentController.text)
          ); // 이벤트 발생

        },
        child: const Icon(Icons.save),
      ),// save 버튼

      body: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 48),
        color: Color(viewModel.color),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,// 모두 동일한 간격
              children: noteColors.map((color) => InkWell(
                  child: _buildBackgroundColor(
                    color: color,
                    selected: viewModel.color == color.value,
                  ),
                  onTap: () {
                    viewModel.onEvent(AddEditNoteEvent.changeColor(color.value));
                  },
                )
              ).toList()

            ),

            TextField(
              controller: _titleController,
              maxLines: 1,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: darkGray
              ),
              decoration: const InputDecoration(
                hintText: '제목을 입력하세요',
                border: InputBorder.none
              ),
            ),

            TextField(
              controller: _contentController,
              maxLines: null, // 줄바꿈 해줌
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: darkGray
              ),
              decoration: const InputDecoration(
                  hintText: '내용을 입력하세요',
                  border: InputBorder.none
              ),
            ),
          ],
        ),
      ),

    );
  }

  Widget _buildBackgroundColor({required Color color,required bool selected}) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6.0,
            spreadRadius: 1.0
          )
        ],

        border: selected ? Border.all(
          color: Colors.black,
          width: 2.0,
        ) : null
      ),
    );
  }
}
