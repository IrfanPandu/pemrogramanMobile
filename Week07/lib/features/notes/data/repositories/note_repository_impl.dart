import 'package:week7_clean_architecture/features/notes/data/datasources/note_local_datasource.dart';
import 'package:week7_clean_architecture/features/notes/data/models/note_model.dart';
import 'package:week7_clean_architecture/features/notes/domain/entities/note.dart';
import 'package:week7_clean_architecture/features/notes/domain/repositories/note_repository.dart';

/// Implementasi NoteRepository yang menjembatani domain dan data layer.
///
/// Repository ini:
/// - Menerima entity dari domain layer
/// - Mengonversinya ke model sebelum diteruskan ke data source
/// - Mengonversi model kembali ke entity saat mengembalikan data ke domain
class NoteRepositoryImpl implements NoteRepository {
  final NoteLocalDataSource _localDataSource;

  const NoteRepositoryImpl(this._localDataSource);

  @override
  Future<List<Note>> getAllNotes() async {
    final models = await _localDataSource.getAllNotes();
    return models; // NoteModel extends Note, langsung valid
  }

  @override
  Future<Note?> getNoteById(String id) async {
    return _localDataSource.getNoteById(id);
  }

  @override
  Future<void> addNote(Note note) async {
    final model = NoteModel.fromEntity(note);
    await _localDataSource.insertNote(model);
  }

  @override
  Future<void> updateNote(Note note) async {
    final model = NoteModel.fromEntity(note);
    await _localDataSource.updateNote(model);
  }

  @override
  Future<void> deleteNote(String id) async {
    await _localDataSource.deleteNote(id);
  }
}
