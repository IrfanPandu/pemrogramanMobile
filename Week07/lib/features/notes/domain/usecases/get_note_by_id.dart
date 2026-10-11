import 'package:week7_clean_architecture/core/usecases/usecase.dart';
import 'package:week7_clean_architecture/features/notes/domain/entities/note.dart';
import 'package:week7_clean_architecture/features/notes/domain/repositories/note_repository.dart';

/// Parameter untuk [GetNoteById].
class GetNoteByIdParams {
  final String id;
  const GetNoteByIdParams({required this.id});
}

/// Use case: mengambil satu catatan berdasarkan ID.
class GetNoteById implements UseCase<Note?, GetNoteByIdParams> {
  final NoteRepository repository;

  const GetNoteById(this.repository);

  @override
  Future<Note?> call(GetNoteByIdParams params) {
    return repository.getNoteById(params.id);
  }
}
