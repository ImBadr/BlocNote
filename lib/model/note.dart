import '../db/DBProvider.dart';

class Note {
  int id;
  String title;
  String content;
  String date;

  Note({this.id, this.title, this.content, this.date});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DBProvider.COLUMN_TITLE: title,
      DBProvider.COLUMN_CONTENT: content,
      DBProvider.COLUMN_DATE: date,
    };

    if (id != null) {
      map[DBProvider.COLUMN_ID] = id;
    }

    return map;
  }

  Note.fromMap(Map<String, dynamic> map) {
    id = map[DBProvider.COLUMN_ID];
    title = map[DBProvider.COLUMN_TITLE];
    content = map[DBProvider.COLUMN_CONTENT];
    date = map[DBProvider.COLUMN_DATE];
  }
}
