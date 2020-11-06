import 'package:Note/events/note_event.dart';
import 'package:Note/model/note.dart';

class SetNotes extends NoteEvent {
  List<Note> noteList;

  SetNotes(List<Note> notes) {
    noteList = notes;
  }
}
