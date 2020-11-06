import 'package:Note/model/note.dart';
import 'note_event.dart';

class AddNote extends NoteEvent {
  Note newNote;

  AddNote(Note note) {
    newNote = note;
  }
}
