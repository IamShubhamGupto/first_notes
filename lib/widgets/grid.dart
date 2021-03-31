import 'package:flutter/material.dart';
import '../utils/note.dart';
import 'card.dart';

// const double _minSpacingPx = 8;
// const double _cardWidth = 120;

class NoteGrid extends StatelessWidget {
  NoteGrid({
    required NotePressedCallback onNotePressed,
    required List<Note> notes,
  })  : _onNotePressed = onNotePressed,
        _notes = notes;

  final NotePressedCallback _onNotePressed;
  final List<Note> _notes;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: _notes
          .map((note) => NoteCard(
                note: note,
                onNotePressed: _onNotePressed,
              ))
          .toList(),
    );
  }
}