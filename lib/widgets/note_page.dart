
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_notes/res/custom_colors.dart';
import 'package:first_notes/screens/sign_in_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// import 'widgets/empty_list.dart';
import '../utils/data.dart' as data;
import '../utils/note.dart';
// import 'widgets/dialogs/review_create.dart';

class NotePage extends StatefulWidget {
  static const route = '/note';
  final String _noteId;

  NotePage({required Key key, required String noteId})
    : _noteId = noteId,
    super(key: key);

  @override
  _NotePageState createState() => 
      _NotePageState(noteId: _noteId);

}

class _NotePageState extends State<NotePage> {
  _NotePageState({required String noteId}){
    User? user = FirebaseAuth.instance.currentUser;
    if(user == null){
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => SignInScreen()
        ) 
      );
    }else {
      data.getNote(noteId).then((note) => _note);
      _title = _note!.title;
      _content = _note!.content;
    }
  }

bool _isLoading = true;
Note? _note;
String? _title;
String? _content;

@override
Widget build(BuildContext context){
  return _isLoading
    ? Center(child: CircularProgressIndicator())
    : Scaffold(
        body: Builder(
          builder: (context) => Column(
            children: [
              Row(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      '$_title',
                      style: TextStyle(
                        color: CustomColors.firebaseOrange,
                        fontSize: 32
                      )
                    )
                  )
                ],
              ),
              SizedBox(height: 2),
              Divider(
                thickness: 4,
                color: CustomColors.firebaseGrey,
              ),
              SizedBox(height: 2),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    '$_content',
                    style: TextStyle(
                      color: CustomColors.firebaseOrange,
                      fontSize: 20
                    )
                  )
                )
              )
            ],
          )
        ) 
          
    );
}
}


