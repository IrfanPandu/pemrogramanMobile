import 'package:get_it/get_it.dart';
import 'package:week7_clean_architecture/core/database/database_helper.dart';
import 'package:week7_clean_architecture/features/notes/data/datasources/note_local_datasource.dart';
import 'package:week7_clean_architecture/features/notes/data/repositories/note_repository_impl.dart';
import 'package:week7_clean_architecture/features/notes/domain/repositories/note_repository.dart';
import 'package:week7_clean_architecture/features/notes/domain/usecases/add_note.dart';
import 'package:week7_clean_architecture/features/notes/domain/usecases/delete_note.dart';
import 'package:week7_clean_architecture/features/notes/domain/usecases/get_all_notes.dart';
import 'package:week7_clean_architecture/features/notes/domain/usecases/get_note_by_id.dart';
import 'package:week7_clean_architecture/features/notes/domain/usecases/update_note.dart';

final sl = GetIt.instance;

Future<void> setupDependencies() async {
  // ── Core ──────────────────────────────────────────────────────────────
  sl.registerSingletonAsync<DatabaseHelper>(() async {
    final db = DatabaseHelper();
    await db.database; // ensure initialized
    return db;
  });

  await sl.isReady<DatabaseHelper>();

  // ── Data sources ──────────────────────────────────────────────────────
  sl.registerLazySingleton<NoteLocalDataSource>(
    () => NoteLocalDataSourceImpl(sl<DatabaseHelper>()),
  );

  // ── Repositories ──────────────────────────────────────────────────────
  sl.registerLazySingleton<NoteRepository>(
    () => NoteRepositoryImpl(sl<NoteLocalDataSource>()),
  );

  // ── Use cases ─────────────────────────────────────────────────────────
  sl.registerLazySingleton(() => GetAllNotes(sl<NoteRepository>()));
  sl.registerLazySingleton(() => GetNoteById(sl<NoteRepository>()));
  sl.registerLazySingleton(() => AddNote(sl<NoteRepository>()));
  sl.registerLazySingleton(() => UpdateNote(sl<NoteRepository>()));
  sl.registerLazySingleton(() => DeleteNote(sl<NoteRepository>()));
}
