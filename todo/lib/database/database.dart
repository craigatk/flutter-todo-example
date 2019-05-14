import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  static SqfliteAdapter _adapter;

  Future<SqfliteAdapter> get adapter async {
    await Sqflite.setDebugModeOn(true);

    if (_adapter == null) {
      _adapter = await _initDB();
      await _adapter.connect();
    }

    return _adapter;
  }

  Future<SqfliteAdapter> _initDB() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, "TodoDB.db");
    return SqfliteAdapter(path);
  }
}
