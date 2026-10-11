import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:week7_clean_architecture/features/notes/domain/entities/note.dart';
import 'package:week7_clean_architecture/features/notes/domain/repositories/note_repository.dart';
import 'package:week7_clean_architecture/features/notes/domain/usecases/add_note.dart';

import 'add_note_test.mocks.dart';

@GenerateMocks([NoteRepository])
void main() {
  late AddNote useCase;
  late MockNoteRepository mockRepository;

  setUp(() {
    mockRepository = MockNoteRepository();
    useCase = AddNote(mockRepository);
  });

  test('harus memanggil repository.addNote dengan Note yang benar', () async {
    // Arrange
    when(mockRepository.addNote(any)).thenAnswer((_) async {});

    // Act
    await useCase(const AddNoteParams(
      title: 'Judul Test',
      content: 'Isi catatan test',
    ));

    // Assert: addNote dipanggil tepat sekali dengan Note apapun
    verify(mockRepository.addNote(any));
    verifyNoMoreInteractions(mockRepository);
  });

  test('harus melempar ArgumentError jika judul kosong', () async {
    expect(
      () async => useCase(const AddNoteParams(title: '  ', content: 'isi')),
      throwsA(isA<ArgumentError>()),
    );

    verifyNever(mockRepository.addNote(any));
  });
}
