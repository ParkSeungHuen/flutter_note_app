import 'package:flutter/material.dart';
import 'package:flutter_note_app/ui/colors.dart';

import '../../../domain/model/note.dart';

class NoteItem extends StatelessWidget {
  final Note note;
  Function? onDeleteTap;

  NoteItem({
    Key? key,
    required this.note,
    this.onDeleteTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(note.color),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note.title,
                  maxLines: 1, // 내용이 길 때 한줄만 표기,
                  overflow: TextOverflow.ellipsis, // 잘린 내용을 표시하거나 없앨 수 있다
                  style: Theme.of(context).textTheme.bodyLarge!.apply(
                    color: darkGray,
                  ), // headline1 등이 없어짐, Theme.of(context)를 이용하여 기본 글꼴등을 불러올 수 있다
                ),
                SizedBox(height: 8,),

                Text(note.content,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall!.apply(
                    color: darkGray
                  ),
                ),
              ],

            ),
          ),

          Positioned(
            bottom: 8,
            right: 8,
            child: GestureDetector(
              onTap: () {
                onDeleteTap?.call();
              },
              child : const Icon(Icons.delete)
            ),
          ),

        ],
      ),
    );
  }
}
