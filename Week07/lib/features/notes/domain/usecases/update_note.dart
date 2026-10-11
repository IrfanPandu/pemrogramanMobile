import 'package:week7_clean_architecture/core/usecases/usecase.dart';
import 'package:week7_clean_architecture/features/notes/domain/entities/note.dart';
import 'package:week7_clean_architecture/features/notes/domain/repositories/note_repository.dart';

/// Parameter untuk [UpdateNote].
class UpdateNoteParams {
  final Note note;
  final String newTitle;
  final String newContent;

  const UpdateNoteParams({
    required this.note,
    required this.newTitle,
    required this.newContent,
  });
}

/// Use case: memperbarui catatan yang sudah ada.
class UpdateNote implements UseCase<void, UpdateNoteParams> {
  final NoteRepository repository;

  const UpdateNote(this.repository);

  @override
  Future<void> call(UpdateNoteParams params) async {
    if (params.newTitle.trim().isEmpty) {
      throw ArgumentError('Judul catatan tidak boleh kosong.');
    }

    final updated = params.note.copyWith(
      title: params.newTitle.trim(),
      content: params.newContent.trim(),
      updatedAt: DateTime.now(),
    );

    return repository.updateNote(updated);
  }
}
