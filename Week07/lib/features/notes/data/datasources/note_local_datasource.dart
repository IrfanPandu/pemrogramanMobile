import 'package:sqflite/sqflite.dart';
import 'package:week7_clean_architecture/core/database/database_helper.dart';
import 'package:week7_clean_architecture/features/notes/data/models/note_model.dart';

/// Kontrak abstrak untuk data source lokal catatan.
abstract class NoteLocalDataSource {
  Future<List<NoteModel>> getAllNotes();
  Future<NoteModel?> getNoteById(String id);
  Future<void> insertNote(NoteModel note);
  Future<void> updateNote(NoteModel note);
  Future<void> deleteNote(String id);
}

/// Implementasi NoteLocalDataSource menggunakan SQLite.
class NoteLocalDataSourceImpl implements NoteLocalDataSource {
  final DatabaseHelper _dbHelper;

  NoteLocalDataSourceImpl(this._dbHelper);

  Future<Database> get _db => _dbHelper.database;

  @override
  Future<List<NoteModel>> getAllNotes() async {
    final db = await _db;
    final maps = await db.query(
      DatabaseHelper.tableNotes,
      orderBy: 'updated_at DESC',
    );
    return maps.map(NoteModel.fromMap).toList();
  }

  @override
  Future<NoteModel?> getNoteById(String id) async {
    final db = await _db;
    final maps = await db.query(
      DatabaseHelper.tableNotes,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (maps.isEmpty) return null;
    return NoteModel.fromMap(maps.first);
  }

  @override
  Future<void> insertNote(NoteModel note) async {
    final db = await _db;
    await db.insert(
      DatabaseHelper.tableNotes,
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> updateNote(NoteModel note) async {
    final db = await _db;
    await db.update(
      DatabaseHelper.tableNotes,
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  @override
  Future<void> deleteNote(String id) async {
    final db = await _db;
    await db.delete(
      DatabaseHelper.tableNotes,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
