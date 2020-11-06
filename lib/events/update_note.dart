import 'package:Note/model/note.dart';

import 'note_event.dart';

class UpdateNote extends NoteEvent {
  Note newNote;
  int noteIndex;

  UpdateNote(int index, Note note) {
    newNote = note;
    noteIndex = index;
  }
}
