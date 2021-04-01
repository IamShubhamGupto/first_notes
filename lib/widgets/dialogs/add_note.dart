import 'dart:math' as math;

import 'package:first_notes/res/custom_colors.dart';
import 'package:flutter/material.dart';
import '../../utils/data.dart' as data;
import '../../utils/note.dart';

class AddNoteDialog extends StatefulWidget{
  late final String userId;

  AddNoteDialog({ required this.userId});

  @override
  _AddNoteDialogState createState() => _AddNoteDialogState();

}

class _AddNoteDialogState extends State<AddNoteDialog> {
  String title = "";
  String content = "";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add a Note'),
      content: Container(
        width: math.min(MediaQuery.of(context).size.width, 740),
        height: math.min(MediaQuery.of(context).size.height, 180),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 16),
              child: TextField(
                decoration: InputDecoration.collapsed(
                  hintText: 'Enter note title here.'),
                keyboardType: TextInputType.name,
                maxLines: 1,
                onChanged: (value) {
                  if(mounted){
                    title = value;
                  }
                },  
              )
            ),
            SizedBox(height: 2),
              Divider(
                thickness: 2,
                color: CustomColors.firebaseGrey,
              ),
            SizedBox(height: 2),
            Expanded(
              child: TextField(
                decoration: InputDecoration.collapsed(
                    hintText: 'Type your thoughts here.'),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                onChanged: (value) {
                  if (mounted) {
                    setState(() {
                      content = value;
                    });
                  }
                },
              ),
            ),
            
          ]
      ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('CANCEL'),
          onPressed: () => Navigator.pop(context, null),
        ),
        ElevatedButton(
          child: Text('SAVE'),
          onPressed: () {
            Note? note;
            note?.title = title;
            note?.content = content;
            print('========================Note recieved ${note!.title}, ${note.content}=========================');
            return Navigator.pop(
            context,
            data.addNote(
              note
            )
          );
          },
        ),
      ]
    );
  }

}