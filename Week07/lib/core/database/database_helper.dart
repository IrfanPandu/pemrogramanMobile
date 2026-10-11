import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// Singleton helper untuk mengelola SQLite database.
class DatabaseHelper {
  static const _dbName = 'offline_notes.db';
  static const _dbVersion = 1;

  static const tableNotes = 'notes';

  Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);

    return openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableNotes (
        id          TEXT PRIMARY KEY,
        title       TEXT NOT NULL,
        content     TEXT NOT NULL,
        created_at  TEXT NOT NULL,
        updated_at  TEXT NOT NULL
      )
    ''');
  }
}
