
import 'package:first_notes/res/custom_colors.dart';
import 'package:flutter/material.dart';
import '../utils/note.dart';

class NoteCard extends StatelessWidget {
  NoteCard({
    required this.note,
    required NotePressedCallback onNotePressed,
  }): _onPressed = onNotePressed;

  final Note note;
  final NotePressedCallback _onPressed;
  
  @override
  Widget build(BuildContext context){
    return Card(
      child: InkWell(
        onTap: () => _onPressed(note.id!),
        splashColor: CustomColors.firebaseAmber,
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  alignment: Alignment.topCenter,
                  child: Text(
                    '${note.title}',
                      style: TextStyle(
                        color: CustomColors.firebaseYellow,
                        fontSize: 20,
                      )
                    ),
                  )
                ),
                SizedBox(height: 4.0),
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      '${note.content}',
                      style: TextStyle(
                        color: CustomColors.firebaseOrange,
                        fontSize: 16,
                      )
                    )
                    )
                )
            ],
          ),
          ),
      )
    );
  }
}