import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:week7_clean_architecture/features/notes/presentation/providers/notes_provider.dart';

/// Halaman form untuk menambah atau mengedit catatan.
///
/// Jika [noteId] diisi → mode edit; jika null → mode tambah.
class NoteFormPage extends ConsumerStatefulWidget {
  final String? noteId;

  const NoteFormPage({super.key, this.noteId});

  @override
  ConsumerState<NoteFormPage> createState() => _NoteFormPageState();
}

class _NoteFormPageState extends ConsumerState<NoteFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  bool _isLoading = false;
  bool _initialized = false;

  bool get _isEditMode => widget.noteId != null;

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Jika mode edit, isi form dengan data yang ada
    if (_isEditMode && !_initialized) {
      final noteAsync = ref.watch(noteByIdProvider(widget.noteId!));
      noteAsync.whenData((note) {
        if (note != null && !_initialized) {
          _titleController.text = note.title;
          _contentController.text = note.content;
          _initialized = true;
        }
      });
    } else {
      _initialized = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditMode ? 'Edit Catatan' : 'Catatan Baru'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Judul *',
                  hintText: 'Masukkan judul catatan',
                  prefixIcon: Icon(Icons.title),
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Judul tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Expanded(
                child: TextFormField(
                  controller: _contentController,
                  decoration: const InputDecoration(
                    labelText: 'Isi Catatan',
                    hintText: 'Tulis catatan Anda di sini...',
                    prefixIcon: Icon(Icons.notes),
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                ),
              ),
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: _isLoading ? null : _save,
                icon: _isLoading
                    ? const SizedBox.square(
                        dimension: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.save),
                label: Text(_isEditMode ? 'Simpan Perubahan' : 'Simpan Catatan'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final title = _titleController.text.trim();
      final content = _contentController.text.trim();
      final notifier = ref.read(notesProvider.notifier);

      if (_isEditMode) {
        // Mode edit: ambil note lama lalu update
        final noteAsync = ref.read(noteByIdProvider(widget.noteId!));
        final note = noteAsync.value;
        if (note == null) {
          _showError('Catatan tidak ditemukan.');
          return;
        }
        await notifier.updateNote(note, title, content);
      } else {
        // Mode tambah
        await notifier.addNote(title, content);
      }

      if (mounted) {
        context.go('/');
      }
    } catch (e) {
      _showError(e.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}
