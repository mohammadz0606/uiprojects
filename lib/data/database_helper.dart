import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDB('agents.db');
    return _database;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'TEXT PRIMARY KEY';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
      CREATE TABLE agents (
        id $idType,
        title $textType,
        description $textType,
        imageUrl $textType
      )
    ''');
  }

  Future<bool> isAgentsTableEmpty() async {
    if (_database == null) {
      return true;
    }
    final count = Sqflite.firstIntValue(
      await _database!.rawQuery('SELECT COUNT(*) FROM agents'),
    );
    return count == 0;
  }

  // Future<void> deleteDatabaseFile() async {
  //   final dbPath = await getDatabasesPath();
  //   final path = join(dbPath, 'agents.db');
  //
  //   await deleteDatabase(path);
  // }

  Future close() async {
    final db = await instance.database;
    db?.close();
  }

}