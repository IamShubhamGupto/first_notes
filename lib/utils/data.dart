import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './note.dart';
Future<void> addNote(Note? note) {
  return FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('notes')
      .add({
    'title': note!.title,
    'content': note.content,
  });
}

List<Note> getNotesFromQuery(QuerySnapshot snapshot) {
  return snapshot.docs.map((DocumentSnapshot doc) {
    return Note.fromSnapshot(doc);
  }).toList();
}

Stream<QuerySnapshot> loadAllNotes() {
  return FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('notes')
      .limit(50)
      .snapshots();
}


// List<Note> loadAllNotes() {
//   List<Note> notes;
//   FirebaseFirestore.instance
//         .collection('users')
//         .doc(FirebaseAuth.instance.currentUser!.uid)
//         .collection('notes')
//         .get()
//         .then((querySnapshot ) => {
//           notes = querySnapshot.docs.map((DocumentSnapshot doc) => {
//             Note.fromSnapshot(doc)
//           }).toList()
//         });
// }

Future<Note> getNote(String noteId) {
  return FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('notes')
      .doc(noteId)
      .get()
      .then((DocumentSnapshot doc) => Note.fromSnapshot(doc));
}