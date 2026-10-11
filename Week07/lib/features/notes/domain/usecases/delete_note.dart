import 'package:week7_clean_architecture/core/usecases/usecase.dart';
import 'package:week7_clean_architecture/features/notes/domain/repositories/note_repository.dart';

/// Parameter untuk [DeleteNote].
class DeleteNoteParams {
  final String id;
  const DeleteNoteParams({required this.id});
}

/// Use case: menghapus catatan berdasarkan ID.
class DeleteNote implements UseCase<void, DeleteNoteParams> {
  final NoteRepository repository;

  const DeleteNote(this.repository);

  @override
  Future<void> call(DeleteNoteParams params) {
    return repository.deleteNote(params.id);
  }
}
