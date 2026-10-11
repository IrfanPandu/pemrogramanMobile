import 'package:week7_clean_architecture/features/notes/domain/entities/note.dart';

/// NoteModel adalah representasi data dari Note untuk layer data.
///
/// Perbedaan utama dengan entity:
/// - Model tahu cara serialisasi/deserialisasi (JSON/Map)
/// - Model extends entity agar bisa dipakai langsung di domain layer
/// - Entity tidak tahu soal database; Model yang bertanggung jawab mapping
class NoteModel extends Note {
  const NoteModel({
    required super.id,
    required super.title,
    required super.content,
    required super.createdAt,
    required super.updatedAt,
  });

  /// Membuat NoteModel dari Map (hasil query SQLite).
  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  /// Mengonversi NoteModel ke Map untuk disimpan ke SQLite.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  /// Membuat NoteModel dari Note entity.
  factory NoteModel.fromEntity(Note note) {
    return NoteModel(
      id: note.id,
      title: note.title,
      content: note.content,
      createdAt: note.createdAt,
      updatedAt: note.updatedAt,
    );
  }
}
