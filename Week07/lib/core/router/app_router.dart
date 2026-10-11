import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:week7_clean_architecture/features/notes/presentation/pages/note_detail_page.dart';
import 'package:week7_clean_architecture/features/notes/presentation/pages/note_form_page.dart';
import 'package:week7_clean_architecture/features/notes/presentation/pages/notes_list_page.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        name: 'notes',
        builder: (context, state) => const NotesListPage(),
      ),
      GoRoute(
        path: '/notes/:id',
        name: 'noteDetail',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return NoteDetailPage(noteId: id);
        },
      ),
      GoRoute(
        path: '/notes/new',
        name: 'addNote',
        builder: (context, state) => const NoteFormPage(),
      ),
      GoRoute(
        path: '/notes/:id/edit',
        name: 'editNote',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return NoteFormPage(noteId: id);
        },
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('Halaman tidak ditemukan: ${state.error}')),
    ),
  );
});
