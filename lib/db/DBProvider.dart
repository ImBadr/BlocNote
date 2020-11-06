import 'package:path/path.dart';
import 'package:Note/Model/Note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DBProvider {
  static const String TABLE_NOTE = "note";
  static const String COLUMN_ID = "id";
  static const String COLUMN_TITLE = "title";
  static const String COLUMN_CONTENT = "content";
  static const String COLUMN_DATE = "date";

  DBProvider._();
  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    print("database getter called");

    if (_database != null) {
      return _database;
    }

    _database = await createDatabase();

    return _database;
  }

  Future<Database> createDatabase() async {
    String dbPath = await getDatabasesPath();

    return await openDatabase(join(dbPath, 'note.db'), version: 1,
        onCreate: (Database database, int version) async {
      print("Creating note table");

      await database.execute(
        "CREATE TABLE $TABLE_NOTE ("
        "$COLUMN_ID INTEGER PRIMARY KEY,"
        "$COLUMN_TITLE TEXT,"
        "$COLUMN_CONTENT TEXT,"
        "$COLUMN_DATE TEXT"
        ")",
      );
    });
  }

  Future<List<Note>> getNotes() async {
    final db = await database;

    var notes = await db.query(
      TABLE_NOTE,
      columns: [COLUMN_ID, COLUMN_TITLE, COLUMN_CONTENT, COLUMN_DATE],
    );

    List<Note> notesList = List<Note>();

    notes.forEach((currentNote) {
      Note note = Note.fromMap(currentNote);

      notesList.add(note);
    });

    return notesList;
  }

  Future<Note> insert(Note note) async {
    final db = await database;
    note.id = await db.insert(TABLE_NOTE, note.toMap());
    return note;
  }

  Future<int> delete(int id) async {
    final db = await database;

    return await db.delete(
      TABLE_NOTE,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<int> update(Note note) async {
    final db = await database;

    return await db.update(
      TABLE_NOTE,
      note.toMap(),
      where: "id = ?",
      whereArgs: [note.id],
    );
  }
}
