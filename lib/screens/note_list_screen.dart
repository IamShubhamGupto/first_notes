

import 'dart:async';
import 'package:first_notes/widgets/dialogs/add_note.dart';
import 'package:first_notes/widgets/note_page.dart';

import '../utils/data.dart' as data;
import '../widgets/grid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_notes/utils/note.dart';
import 'package:flutter/material.dart';
import 'package:first_notes/res/custom_colors.dart';
import 'package:first_notes/screens/user_info_screen.dart';
import 'package:first_notes/widgets/app_bar_title.dart';

class NoteListScreen extends StatefulWidget{
  const NoteListScreen({Key? key, required User user})
  :
    _user = user,
    super(key: key);

  final User _user;

  @override
  _NoteListScreenState createState() => _NoteListScreenState();

}
bool DEBUG = false;
class _NoteListScreenState extends State<NoteListScreen>{
  _NoteListScreenState(){
    _currentSubscription =
          data.loadAllNotes().listen(_updateNotes);
  }

  @override
  void dispose() {
     _currentSubscription.cancel();
    super.dispose();
  }

  late User _user;
  late StreamSubscription<QuerySnapshot> _currentSubscription;
  bool _isLoading = true;
  List<Note> _notes = <Note>[];

  void _updateNotes(QuerySnapshot snapshot) {
    print("Stream value ${snapshot.docs.toString()}");
    setState(() {
      _isLoading = false;
      _notes = data.getNotesFromQuery(snapshot);
    });
  }

  Route _routeToUserInfoScreen() {
    if(DEBUG){
      print("----------routing to user info screen-------------------");  
    }
      
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => UserInfoScreen(user:_user),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  void initState() {
    _user = widget._user;
    if(DEBUG){
      print("-----------------------At note list screen-------------------");
    }
    
    super.initState();
  }

  void _onCreateNotePressed() async {
    final newNote = await showDialog<Note>(
      context: context,
      builder: (_) => AddNoteDialog(
        userId: _user.uid),
    );
    if (newNote != null) {
      // Save the review
      setState(() {
            _isLoading = false;
            _notes.add(newNote);
            });
      
      return data.addNote(newNote);
    }
  }

  @override
  Widget build(BuildContext context) {
    print("======$_notes================");
    return Scaffold(
        backgroundColor: CustomColors.firebaseNavy,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: CustomColors.firebaseNavy,
          title: AppBarTitle(),
        ),
        body: Stack(
          
          children: [
              SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    bottom: 20.0,
                  ),
                  child: Column(
                    
                    mainAxisSize: MainAxisSize.min,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(),
                      _user.photoURL != null
                          ? ClipOval(
                              child: Material(
                                
                                color: CustomColors.firebaseGrey.withOpacity(0.3),
                                child: GestureDetector(
                                  behavior: HitTestBehavior.deferToChild,
                                  onTap:() {
                                    if(DEBUG){
                                        print("------TAP DETECTED----------------");
                                    }
                                    
                                      Navigator.of(context).push(
                                        _routeToUserInfoScreen()
                                      );
                                    },
                                  child: Image.network(
                                    _user.photoURL!,
                                    fit: BoxFit.fitWidth,
                                  ), 
                                ),
                              ),
                            )
                          : ClipOval(
                              child: Material(
                                color: CustomColors.firebaseGrey.withOpacity(0.3),
                                child: GestureDetector(
                                  behavior: HitTestBehavior.deferToChild,
                                  onTap: (){
                                    if(DEBUG){
                                        print("------TAP DETECTED----------------");
                                    }
                                    
                                    Navigator.of(context).push(
                                          _routeToUserInfoScreen()
                                        );
                                  },
                                  child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Icon(
                                    Icons.person,
                                    size: 60,
                                    color: CustomColors.firebaseGrey,
                                  ),
                                ),
                                )
                              ),
                            ),
                      SizedBox(height: 16.0),
                      Center(
                        
                        child: Container(
                          child: _isLoading
                            ? CircularProgressIndicator()
                            : _notes.isNotEmpty
                              ?Expanded(
                                      child: SizedBox(
                                          height: 0.8*MediaQuery.of(context).size.height,
                                          child: NoteGrid(
                                            notes: _notes,
                                            onNotePressed: (id) {
                                                Navigator.pushNamed(context, NotePage.route,
                                                arguments: NotePageArguments(id: id));
                                              }
                                          ),
                                        )
                                  )
                              : Center(
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Add your first note today !',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: CustomColors.firebaseOrange
                                      ),
                                    ),
                                    ),
                              )  
                        ),
                      ),
                      SizedBox(height: 4.0),
                          Flexible(
                            child: Align(
                                alignment: Alignment.bottomRight,
                                child: FloatingActionButton(
                                  backgroundColor: const Color(0xff03dac6),
                                  foregroundColor: Colors.black,
                                  onPressed: _onCreateNotePressed,
                                  child: Icon(Icons.add),
                                ),
                              ),
                          ) 
                    ],
                  ),
                ),
              )
            ),
          ]
      )
    );
  }
}