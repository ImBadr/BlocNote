class Note {
  static const String TABLE_NOTE = "note";
  static const String COLUMN_ID = "id";
  static const String COLUMN_TITLE = "title";
  static const String COLUMN_CONTENT = "content";
  static const String COLUMN_DATE = "date";

  int id;
  String title;
  String content;
  String date;

  Note({this.id, this.title, this.content, this.date});

  Map<String, dynamic> toMap() {
    return {
      COLUMN_ID: id,
      COLUMN_TITLE: title,
      COLUMN_CONTENT: content,
      COLUMN_DATE: date,
    };
  }

  @override
  String toString() {
    return 'Note{id: $id, title: $title, content: $content, date: $date}';
  }
}
