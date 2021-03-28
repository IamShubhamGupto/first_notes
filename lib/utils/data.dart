import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './note.dart';
Future<void> addNote(Note note) {
  final notes = FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.uid+"/notes");
  return notes.add({
    'title': note.title,
    'content': note.content,
  });
}

Stream<QuerySnapshot> loadAllNotes() {
  return FirebaseFirestore.instance
      .collection(FirebaseAuth.instance.currentUser!.uid+"/notes")
      .limit(50)
      .snapshots();
}

Future<Note> getNote(String noteId) {
  return FirebaseFirestore.instance
      .collection(FirebaseAuth.instance.currentUser!.uid+"/notes")
      .doc(noteId)
      .get()
      .then((DocumentSnapshot doc) => Note.fromSnapshot(doc));
}