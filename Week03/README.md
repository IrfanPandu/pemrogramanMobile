# Week 3 — Navigation & State Management

Project Flutter untuk Codelab Pemrograman Mobile Minggu 3 JTI Polinema.

Materi utama:
- Navigation dengan GoRouter
- Route dan path parameter
- State management dengan Riverpod
- Provider, Notifier, ConsumerWidget
- `ref.watch()` dan `ref.read()`
- Widget test sederhana

## Struktur

```text
week3_navigation_state_management/
├── lib/
│   ├── main.dart
│   ├── pages/
│   │   ├── home_page.dart
│   │   ├── detail_page.dart
│   │   └── todo_page.dart
│   └── providers/
│       └── todo_provider.dart
├── test/
│   └── widget_test.dart
├── pubspec.yaml
└── README.md
```

## Menjalankan project

```powershell
flutter pub get
flutter run -d chrome
```

Untuk mengecek kode:

```powershell
flutter analyze
flutter test
```

## Bagian yang perlu dipahami sebelum dikumpulkan

1. Jelaskan perbedaan `context.go()` dan `context.push()`.
2. Jelaskan fungsi `pathParameters`.
3. Jelaskan mengapa `ProviderScope` diperlukan.
4. Jelaskan perbedaan `ref.watch()` dan `ref.read()`.
5. Jelaskan mengapa state Todo dibuat immutable dengan membuat list baru.
6. Uji penambahan, checklist, dan penghapusan Todo.
7. Ambil screenshot hasil aplikasi dan tambahkan ke laporan sesuai instruksi dosen.

## Git

Contoh:

```powershell
git add Week03
git commit -m "Week03 navigation and state management"
git push origin main
```

> Catatan akademik: project ini adalah scaffold/boilerplate untuk membantu mengejar keterlambatan. Sebelum mengumpulkan, baca dan pahami setiap file, jalankan test, verifikasi hasil, dan sesuaikan dokumentasi/screenshot dengan pekerjaan Anda.
