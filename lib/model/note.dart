import 'package:Note/db/DB.dart';

class Note {
  int id;
  String title;
  String content;
  String date;

  Note({this.id, this.title, this.content, this.date});

  Map<String, dynamic> toMap() {
    return {
      DB.COLUMN_ID: id,
      DB.COLUMN_TITLE: title,
      DB.COLUMN_CONTENT: content,
      DB.COLUMN_DATE: date,
    };
  }
}
