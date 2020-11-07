import 'dart:async';
import 'package:path/path.dart';
import 'package:Note/Model/Note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

void main() async {
  const String TABLE_NOTE = "note";
  const String COLUMN_ID = "id";
  const String COLUMN_TITLE = "title";
  const String COLUMN_CONTENT = "content";
  const String COLUMN_DATE = "date";

  final Future<Database> database = openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join(await getDatabasesPath(), 'note.db'),
    // When the database is first created, create a table to store dogs.
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
        "CREATE TABLE $TABLE_NOTE ("
        "$COLUMN_ID INTEGER PRIMARY KEY,"
        "$COLUMN_TITLE TEXT,"
        "$COLUMN_CONTENT TEXT,"
        "$COLUMN_DATE TEXT"
        ")",
      );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );

  Future<List<Note>> getNotes() async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all The Notes.
    final List<Map<String, dynamic>> maps = await db.query(TABLE_NOTE);

    // Convert the List<Map<String, dynamic> into a List<Note>.
    return List.generate(maps.length, (i) {
      return Note(
        id: maps[i][COLUMN_ID],
        title: maps[i][COLUMN_TITLE],
        content: maps[i][COLUMN_CONTENT],
        date: maps[i][COLUMN_DATE],
      );
    });
  }

  Future<void> insert(Note note) async {
    // Get a reference to the database.
    final Database db = await database;

    // Insert the Note into the correct table. Also specify the
    // `conflictAlgorithm`. In this case, if the same note is inserted
    // multiple times, it replaces the previous data.
    await db.insert(
      TABLE_NOTE,
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> delete(int id) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Note from the database.
    await db.delete(
      TABLE_NOTE,
      // Use a `where` clause to delete a specific note.
      where: "id = ?",
      // Pass the Note's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  Future<void> update(Note note) async {
    // Get a reference to the database.
    final db = await database;

    // Update the given Note.
    await db.update(
      TABLE_NOTE,
      note.toMap(),
      // Ensure that the Note has a matching id.
      where: "id = ?",
      // Pass the Note's id as a whereArg to prevent SQL injection.
      whereArgs: [note.id],
    );
  }
}
