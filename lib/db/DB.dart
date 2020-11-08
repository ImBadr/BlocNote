import 'dart:async';
import 'package:path/path.dart';
import 'package:Note/Model/Note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DB {
  DB._();
  static final DB db = DB._();
  static Database _database;

  static final _databaseName = "notes.db";
  static final _databaseVersion = 1;

  static const String TABLE_NOTE = "note";
  static const String COLUMN_ID = "_id";
  static const String COLUMN_TITLE = "_title";
  static const String COLUMN_CONTENT = "_content";
  static const String COLUMN_DATE = "_date";

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    return await openDatabase(
        // Set the path to the database. Note: Using the `join` function from the
        // `path` package is best practice to ensure the path is correctly
        // constructed for each platform.
        join(await getDatabasesPath(), _databaseName),
        version: _databaseVersion,
        // When the database is first created, create a table to store dogs.
        onCreate: (db, version) async {
      // Run the CREATE TABLE statement on the database.
      return await db.execute('''
          CREATE TABLE $TABLE_NOTE (
          $COLUMN_ID INTEGER PRIMARY KEY,
          $COLUMN_TITLE TEXT,
          $COLUMN_CONTENT TEXT,
          $COLUMN_DATE TEXT
          );
          ''');
    }
        // Set the version. This executes the onCreate function and provides a
        // path to perform database upgrades and downgrades.
        );
  }

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
    await db.insert(TABLE_NOTE, note.toMap());
  }

  Future<void> delete(int id) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Note from the database.
    await db.delete(TABLE_NOTE,
        // Use a `where` clause to delete a specific note.
        where: "$COLUMN_ID = ?",
        // Pass the Note's id as a whereArg to prevent SQL injection.
        whereArgs: [id]);
  }

  Future<void> update(Note note) async {
    // Get a reference to the database.
    final db = await database;

    // Update the given Note.
    await db.update(TABLE_NOTE, note.toMap(),
        // Ensure that the Note has a matching id.
        where: "$COLUMN_ID = ?",
        // Pass the Note's id as a whereArg to prevent SQL injection.
        whereArgs: [note.id]);
  }
}
