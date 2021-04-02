

import 'package:cloud_firestore/cloud_firestore.dart';

typedef NotePressedCallback = void Function(String noteId);
typedef CloseNotePressedCallback = void Function();

class Note{
  late final String? id;
  late final String title;
  late final String content;
  // final DocumentReference? reference;


  Note._()
    : id = null,
    title = "",
    content = "";
    // reference = null;

  // Note({required this.title, required this.content}){
    
  //   // reference = null;
  // }
  // 
  // 
  
  Note.fromDialog({String? title, String? content})
      : id = null,
      title = title!,
      content = content!;

  Note.fromSnapshot(DocumentSnapshot snapshot)
      : id = snapshot.id,
        title = snapshot.data()!['title'],
        content = snapshot.data()!['content'];
        // reference = snapshot.reference;
}