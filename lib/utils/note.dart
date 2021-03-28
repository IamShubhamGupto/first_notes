import 'dart:ffi';
import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

typedef NotePressedCallback = void Function(String noteId);
typedef CloseNotePressedCallback = void Function();

class Note{
  final String id;
  final String title;
  final String content;
  final DocumentReference reference;

  Note._()
    : id = null,
    title = "",
    content = "",
    reference = null;

  Note.fromSnapshot(DocumentSnapshot snapshot)
      : id = snapshot.id,
        title = snapshot.data()!['title'],
        content = snapshot.data()!['content'],
        reference = snapshot.reference;
}