import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:week7_clean_architecture/core/usecases/usecase.dart';
import 'package:week7_clean_architecture/features/notes/domain/entities/note.dart';
import 'package:week7_clean_architecture/features/notes/domain/repositories/note_repository.dart';
import 'package:week7_clean_architecture/features/notes/domain/usecases/get_all_notes.dart';

import 'get_all_notes_test.mocks.dart';

@GenerateMocks([NoteRepository])
void main() {
  late GetAllNotes useCase;
  late MockNoteRepository mockRepository;

  setUp(() {
    mockRepository = MockNoteRepository();
    useCase = GetAllNotes(mockRepository);
  });

  final tNotes = [
    Note(
      id: '1',
      title: 'Test Note 1',
      content: 'Content 1',
      createdAt: DateTime(2026, 10, 1),
      updatedAt: DateTime(2026, 10, 1),
    ),
    Note(
      id: '2',
      title: 'Test Note 2',
      content: 'Content 2',
      createdAt: DateTime(2026, 10, 2),
      updatedAt: DateTime(2026, 10, 2),
    ),
  ];

  test('harus mengembalikan daftar Note dari repository', () async {
    // Arrange: repository palsu (fake/mock) dikonfigurasi
    when(mockRepository.getAllNotes()).thenAnswer((_) async => tNotes);

    // Act: jalankan use case
    final result = await useCase(const NoParams());

    // Assert: hasil sesuai ekspektasi
    expect(result, equals(tNotes));
    verify(mockRepository.getAllNotes());
    verifyNoMoreInteractions(mockRepository);
  });

  test('harus mengembalikan daftar kosong jika tidak ada catatan', () async {
    when(mockRepository.getAllNotes()).thenAnswer((_) async => []);

    final result = await useCase(const NoParams());

    expect(result, isEmpty);
    verify(mockRepository.getAllNotes());
  });
}
