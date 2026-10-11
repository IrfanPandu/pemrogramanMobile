import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:week7_clean_architecture/core/di/injection.dart';
import 'package:week7_clean_architecture/features/notes/domain/entities/note.dart';
import 'package:week7_clean_architecture/features/notes/domain/usecases/add_note.dart';
import 'package:week7_clean_architecture/features/notes/domain/usecases/delete_note.dart';
import 'package:week7_clean_architecture/features/notes/domain/usecases/get_all_notes.dart';
import 'package:week7_clean_architecture/features/notes/domain/usecases/get_note_by_id.dart';
import 'package:week7_clean_architecture/features/notes/domain/usecases/update_note.dart';
import 'package:week7_clean_architecture/core/usecases/usecase.dart';

// ── Use case providers (ambil dari GetIt) ──────────────────────────────
final getAllNotesUseCaseProvider = Provider<GetAllNotes>(
  (ref) => sl<GetAllNotes>(),
);

final getNotByIdUseCaseProvider = Provider<GetNoteById>(
  (ref) => sl<GetNoteById>(),
);

final addNoteUseCaseProvider = Provider<AddNote>(
  (ref) => sl<AddNote>(),
);

final updateNoteUseCaseProvider = Provider<UpdateNote>(
  (ref) => sl<UpdateNote>(),
);

final deleteNoteUseCaseProvider = Provider<DeleteNote>(
  (ref) => sl<DeleteNote>(),
);

// ── Notes list provider ────────────────────────────────────────────────

/// Provider untuk daftar semua catatan.
/// Menggunakan AsyncNotifierProvider agar UI bisa menangani loading/error.
final notesProvider = AsyncNotifierProvider<NotesNotifier, List<Note>>(
  NotesNotifier.new,
);

class NotesNotifier extends AsyncNotifier<List<Note>> {
  @override
  Future<List<Note>> build() async {
    return _fetchAll();
  }

  Future<List<Note>> _fetchAll() async {
    final useCase = ref.read(getAllNotesUseCaseProvider);
    return useCase(const NoParams());
  }

  Future<void> addNote(String title, String content) async {
    final useCase = ref.read(addNoteUseCaseProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await useCase(AddNoteParams(title: title, content: content));
      return _fetchAll();
    });
  }

  Future<void> updateNote(Note note, String newTitle, String newContent) async {
    final useCase = ref.read(updateNoteUseCaseProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await useCase(UpdateNoteParams(
        note: note,
        newTitle: newTitle,
        newContent: newContent,
      ));
      return _fetchAll();
    });
  }

  Future<void> deleteNote(String id) async {
    final useCase = ref.read(deleteNoteUseCaseProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await useCase(DeleteNoteParams(id: id));
      return _fetchAll();
    });
  }
}

// ── Single note provider ───────────────────────────────────────────────

/// Provider untuk satu catatan berdasarkan ID.
final noteByIdProvider = FutureProvider.family<Note?, String>((ref, id) async {
  final useCase = sl<GetNoteById>();
  return useCase(GetNoteByIdParams(id: id));
});
