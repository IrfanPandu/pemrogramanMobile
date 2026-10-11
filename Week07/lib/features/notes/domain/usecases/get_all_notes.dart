import 'package:week7_clean_architecture/core/usecases/usecase.dart';
import 'package:week7_clean_architecture/features/notes/domain/entities/note.dart';
import 'package:week7_clean_architecture/features/notes/domain/repositories/note_repository.dart';

/// Use case: mengambil semua catatan.
///
/// Mengikuti prinsip Single Responsibility - hanya bertanggung jawab
/// untuk satu aksi bisnis: mengambil semua catatan.
class GetAllNotes implements UseCase<List<Note>, NoParams> {
  final NoteRepository repository;

  const GetAllNotes(this.repository);

  @override
  Future<List<Note>> call(NoParams params) {
    return repository.getAllNotes();
  }
}
