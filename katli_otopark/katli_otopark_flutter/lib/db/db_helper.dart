import 'package:katli_otopark_flutter/models/arabagirisi.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper{
  static Database? _db;
  static final int _version =1;
  static final String _tableName="tasks";

  static Future<void>initDb()async{
    if (_db != null) {
      return;
    }
    try {
      String _path= await getDatabasesPath() +'tasks.db';
      _db = await openDatabase(
        _path,
        version: _version,
        onCreate: (db, _version) {
          print("yeni bir tane oluştur");
          return db.execute(
            "CREATE TABLE $_tableName("
            "id INTEGER PRIMARY KEY AUTOINCREMENT, "
            "plaka STRING, marka TEXT, "
            "startTime STRING , endTime STRING, "
            "isComplated INTEGER)",

          );
        }
      );
    }catch (e) {
      print(e);
    }
  }
  static Future <int> insert (Task? task) async{
    print("seçili function çağırıldı");
    return await _db?.insert(_tableName, task!.toJson())??1;
  }
  static Future <List<Map<String,dynamic>>> query() async{
    print("query function çağırıldı");
    return await _db!.query(_tableName);
  }
  static delete(Task task)async{
   return await _db!.delete(_tableName, where:'id=?',whereArgs: [task.id]);
  }
}