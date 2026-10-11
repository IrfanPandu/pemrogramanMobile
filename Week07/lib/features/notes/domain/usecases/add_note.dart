import 'package:week7_clean_architecture/core/usecases/usecase.dart';
import 'package:week7_clean_architecture/features/notes/domain/entities/note.dart';
import 'package:week7_clean_architecture/features/notes/domain/repositories/note_repository.dart';

/// Parameter untuk [AddNote].
class AddNoteParams {
  final String title;
  final String content;

  const AddNoteParams({required this.title, required this.content});
}

/// Use case: menambahkan catatan baru.
///
/// Bertanggung jawab atas validasi bisnis sebelum menyimpan:
/// - title tidak boleh kosong
class AddNote implements UseCase<void, AddNoteParams> {
  final NoteRepository repository;

  const AddNote(this.repository);

  @override
  Future<void> call(AddNoteParams params) async {
    if (params.title.trim().isEmpty) {
      throw ArgumentError('Judul catatan tidak boleh kosong.');
    }

    final now = DateTime.now();
    final note = Note(
      id: now.millisecondsSinceEpoch.toString(),
      title: params.title.trim(),
      content: params.content.trim(),
      createdAt: now,
      updatedAt: now,
    );

    return repository.addNote(note);
  }
}
