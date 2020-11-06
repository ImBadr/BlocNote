import 'note_event.dart';

class DeleteNote extends NoteEvent {
  int noteIndex;

  DeleteNote(int index) {
    noteIndex = index;
  }
}
