import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../Model/note_model.dart';

///? Now Lets Make Database Provider.
//***  For Database I Used SQL-F-lite.
//**! @VivekYadavDev Github id.
//*** So, We Create Database Class.

class DatabaseProvider {
  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();
  static Database? _database;

//*** Create Getter of database.
  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  initDB() async {
    return openDatabase(join(await getDatabasesPath(), "note_app.db"),
        onCreate: (db, version) async {
      //! Now we are going create first table
      await db.execute('''
      CREATE TABLE notes(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          body TEXT,
          creation_date DATE)
          ''');
    }, version: 1);
  }

  //*** Now Create a Function Which is Going To Create New Notes.
  addNewNote(NoteModel note) async {
    final db = await database;
    db!.insert("notes", note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

//*** Now Create a Function That Will Fetch The Database and Return all The Element inside the note Table.
  Future<dynamic> getNotes() async {
    final db = await database;
    var res = await db?.query("notes");
    if (res!.length == 0) {
      return Null;
    } else {
      var resultMap = res.toList();
      return resultMap.isNotEmpty ? resultMap : Null;
    }
  }

  //*** Now Create a Function That Will Delete The Data From Database.
  Future<int?> deleteNote(int id) async {
    final db = await database;
    int? count = await db?.rawDelete("DELETE FROM notes WHERE id =?", [id]);
    return count;

    ///**** return the number of row deleted.
  }
}
