import 'dart:developer';
import 'dart:io';

import 'package:note_app/view/note_app/database/varriable.dart';
import 'package:note_app/view/note_app/model/note_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NoteDatabase {
  Future<Database> initializeDatabase() async {
    final Directory tempDir = await getTemporaryDirectory();
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'notesdb.db'),
      onCreate: (database, version) async {
        await database.execute(
          'CREATE TABLE $noteTable($noteId INTEGER PRIMARY KEY, $noteTitle TEXT,$noteBody TEXT,$noteDate TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertNote(NoteModel note) async {
    var db = await initializeDatabase();
    await db.insert(noteTable, note.toMap());
    log('Add note success');
  }

  Future<List<NoteModel>> getNotes() async {
    var db = await initializeDatabase();
    List<Map<String, dynamic>> resultNote = await db.query(noteTable);
    return resultNote.map((note) => NoteModel.fromMap(note)).toList();
  }

  Future<void> deleteNote(NoteModel note) async {
    var db = await initializeDatabase();
    await db.delete(noteTable, where: '$noteId=?', whereArgs: [note.id]);
  }
}
//ORM =  Object relational mapping
