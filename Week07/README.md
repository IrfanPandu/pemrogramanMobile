# Week 7 – Clean Architecture Flutter

## Nama: Irfan Pandu Pratama
## Mata Kuliah: Pemrograman Mobile
## Topik: Clean Architecture (Feature-First, 3-Layer)

---

## Deskripsi

Project ini merupakan implementasi **Clean Architecture** untuk aplikasi catatan offline (Offline Notes), merupakan refactoring dari project Minggu 5 (`week5_offline_notes`).

---

## Struktur Arsitektur

Project menggunakan pendekatan **feature-first** dengan 3 layer di setiap fitur:

```
lib/
├── core/
│   ├── database/        ← DatabaseHelper (SQLite)
│   ├── di/              ← Dependency Injection (GetIt)
│   ├── error/           ← Failures
│   ├── router/          ← GoRouter
│   └── usecases/        ← UseCase base contract
│
└── features/
    └── notes/
        ├── data/
        │   ├── datasources/   ← NoteLocalDataSource (SQLite)
        │   ├── models/        ← NoteModel (entity + serialization)
        │   └── repositories/  ← NoteRepositoryImpl
        ├── domain/
        │   ├── entities/      ← Note (pure business object)
        │   ├── repositories/  ← NoteRepository (abstract contract)
        │   └── usecases/      ← GetAllNotes, AddNote, UpdateNote, DeleteNote, GetNoteById
        └── presentation/
            ├── pages/         ← NotesListPage, NoteDetailPage, NoteFormPage
            ├── providers/     ← NotesNotifier (Riverpod)
            └── widgets/       ← NoteCard
```

---

## Prinsip Clean Architecture yang Diterapkan

### 1. Dependency Rule
Dependensi **selalu mengarah ke dalam**:
- Presentation → Domain (via use case)
- Data → Domain (implement repository contract)
- Domain tidak tahu apapun tentang Presentation atau Data

### 2. Entity vs Model
- **`Note` (entity)**: Pure Dart class, tidak ada serialization, dipakai domain & presentation
- **`NoteModel` (model)**: Extends `Note`, tambah `fromMap()` & `toMap()` untuk SQLite

### 3. Repository Pattern
- `NoteRepository` (abstract) di domain layer
- `NoteRepositoryImpl` di data layer mengimplementasikannya
- Domain hanya bergantung pada kontrak, bukan implementasi

### 4. Use Case (Single Responsibility)
Setiap use case punya satu tanggung jawab:
- `GetAllNotes` – ambil semua catatan
- `GetNoteById` – ambil satu catatan
- `AddNote` – tambah catatan (+ validasi bisnis)
- `UpdateNote` – update catatan (+ validasi bisnis)
- `DeleteNote` – hapus catatan

### 5. Dependency Injection
Menggunakan **GetIt** sebagai service locator; semua binding didaftarkan di `injection.dart` sebelum `runApp()`.

---

## SOLID Principles

| Prinsip | Implementasi |
|---------|-------------|
| **S**ingle Responsibility | Setiap use case hanya melakukan satu aksi bisnis |
| **O**pen/Closed | Repository dapat diganti implementasinya tanpa mengubah domain |
| **L**iskov Substitution | `NoteModel extends Note` – bisa dipakai di mana `Note` diharapkan |
| **I**nterface Segregation | `NoteRepository` hanya berisi method yang relevan |
| **D**ependency Inversion | Domain mendefinisikan abstract; Data mengimplementasikan |

---

## Teknologi

| Library | Kegunaan |
|---------|---------|
| `flutter_riverpod` | State management (AsyncNotifier) |
| `go_router` | Navigasi deklaratif |
| `sqflite` | Database lokal SQLite |
| `get_it` | Dependency injection |
| `equatable` | Value equality untuk entity |
| `mockito` | Fake repository untuk unit test |

---

## Cara Menjalankan

```bash
flutter pub get
flutter run
```

## Cara Menjalankan Test

```bash
flutter test
```

---

## Refleksi

**Trade-off feature-first vs layer-first:**
- Feature-first memudahkan navigasi kode saat proyek besar — semua yang berkaitan dengan `notes` ada di satu folder
- Layer-first lebih mudah untuk proyek kecil karena semua repository ada di satu tempat
- Untuk skala matakuliah ini, feature-first dipilih karena mempersiapkan pola yang scalable

**Justifikasi Arsitektur:**
Penggunaan use case terpisah mungkin terlihat *over-engineering* untuk aplikasi kecil, tetapi memberikan nilai dalam testabilitas — setiap use case bisa diuji dengan mock repository tanpa menyentuh database sungguhan, sesuai prinsip Clean Architecture.
