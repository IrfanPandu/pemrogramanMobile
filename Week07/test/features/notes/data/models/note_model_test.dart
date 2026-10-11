import 'package:flutter_test/flutter_test.dart';
import 'package:week7_clean_architecture/features/notes/data/models/note_model.dart';
import 'package:week7_clean_architecture/features/notes/domain/entities/note.dart';

void main() {
  final tCreatedAt = DateTime(2026, 10, 1, 10, 0);
  final tUpdatedAt = DateTime(2026, 10, 1, 12, 0);

  final tNoteModel = NoteModel(
    id: '1',
    title: 'Test Title',
    content: 'Test Content',
    createdAt: tCreatedAt,
    updatedAt: tUpdatedAt,
  );

  final tMap = {
    'id': '1',
    'title': 'Test Title',
    'content': 'Test Content',
    'created_at': tCreatedAt.toIso8601String(),
    'updated_at': tUpdatedAt.toIso8601String(),
  };

  group('NoteModel', () {
    test('harus merupakan subclass dari Note entity', () {
      expect(tNoteModel, isA<Note>());
    });

    test('fromMap harus menghasilkan NoteModel yang valid', () {
      final result = NoteModel.fromMap(tMap);
      expect(result, equals(tNoteModel));
    });

    test('toMap harus menghasilkan Map yang sesuai', () {
      final result = tNoteModel.toMap();
      expect(result, equals(tMap));
    });

    test('fromEntity harus mengonversi Note entity ke NoteModel', () {
      const tNote = Note(
        id: '1',
        title: 'Test Title',
        content: 'Test Content',
        createdAt: tCreatedAt,
        updatedAt: tUpdatedAt,
      );

      final result = NoteModel.fromEntity(tNote);
      expect(result, equals(tNoteModel));
    });
  });
}

// Extension untuk DateTime const support di test
extension on DateTime {
  static const tCreatedAt = DateTime.fromMillisecondsSinceEpoch(0);
}
