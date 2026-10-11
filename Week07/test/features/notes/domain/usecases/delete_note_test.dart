import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:week7_clean_architecture/features/notes/domain/repositories/note_repository.dart';
import 'package:week7_clean_architecture/features/notes/domain/usecases/delete_note.dart';

import 'delete_note_test.mocks.dart';

@GenerateMocks([NoteRepository])
void main() {
  late DeleteNote useCase;
  late MockNoteRepository mockRepository;

  setUp(() {
    mockRepository = MockNoteRepository();
    useCase = DeleteNote(mockRepository);
  });

  test('harus memanggil repository.deleteNote dengan id yang benar', () async {
    const tId = '123';
    when(mockRepository.deleteNote(tId)).thenAnswer((_) async {});

    await useCase(const DeleteNoteParams(id: tId));

    verify(mockRepository.deleteNote(tId));
    verifyNoMoreInteractions(mockRepository);
  });
}
