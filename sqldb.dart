import 'package:sqflite/sqflite.dart';

class SqlDb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDb();
      return _db;
    } else {
      return _db;
    }
  }

  intialDb() async {
    String databasePath = await getDatabasesPath();
    String path = '$databasePath/duty.db';
    Database mydb = await openDatabase(path, onCreate: _onCreate,version: 1);
    return mydb;
  }

  _onCreate(Database db, int version) async {
  await db.execute('''
    CREATE TABLE duty(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      place TEXT,
      transport TEXT,
      description TEXT,
      cost INTEGER,
      date TEXT
    )
  ''');

  await db.execute('''
    CREATE TABLE places(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      place TEXT
    )
  ''');
}


  readData(String sql)async{
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

    insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }
}