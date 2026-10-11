import 'package:week7_clean_architecture/features/notes/domain/entities/note.dart';

/// Kontrak abstrak untuk NoteRepository.
///
/// Domain layer mendefinisikan interface ini; Data layer mengimplementasikannya.
/// Aturan dependensi: domain tidak tahu detail implementasi data layer.
abstract class NoteRepository {
  /// Mengambil semua catatan dari penyimpanan lokal.
  Future<List<Note>> getAllNotes();

  /// Mengambil satu catatan berdasarkan [id].
  Future<Note?> getNoteById(String id);

  /// Menyimpan catatan baru [note].
  Future<void> addNote(Note note);

  /// Memperbarui catatan yang sudah ada [note].
  Future<void> updateNote(Note note);

  /// Menghapus catatan berdasarkan [id].
  Future<void> deleteNote(String id);
}
