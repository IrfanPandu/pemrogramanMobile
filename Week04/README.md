# Week 4 - Networking & REST API

Project Flutter untuk codelab Minggu 4 Pemrograman Mobile Politeknik Negeri Malang.

## Tujuan

Project ini menerapkan:

- HTTP dan REST API
- JSON serialization ke model Dart
- Dio sebagai HTTP client
- Repository pattern
- Riverpod `AsyncNotifier` dan `AsyncValue`
- Loading, error, empty, dan success state
- Error handling yang ramah pengguna
- Pagination / infinite scroll
- GoRouter untuk detail post
- Unit test model, error mapping, dan provider dengan fake repository
- Refactoring `PostTile` dan `network_errors.dart`

## API

API dummy yang digunakan adalah JSONPlaceholder:

- Base URL: `https://jsonplaceholder.typicode.com`
- `GET /posts`
- `GET /posts/:id`
- Pagination: `GET /posts?_page=1&_limit=10`

## Struktur

```text
04-week-4-networking-rest-api/
├── lib/
│   ├── data/
│   │   ├── api_client.dart
│   │   ├── network_errors.dart
│   │   ├── paged_posts.dart
│   │   ├── providers.dart
│   │   ├── models/
│   │   │   └── post.dart
│   │   └── repositories/
│   │       └── post_repository.dart
│   ├── pages/
│   │   ├── paged_post_page.dart
│   │   ├── post_detail_page.dart
│   │   └── post_list_page.dart
│   ├── widgets/
│   │   └── post_tile.dart
│   └── main.dart
├── test/
│   └── post_test.dart
├── docs/
│   ├── ai-verification.md
│   └── reflection.md
├── screenshots/
└── pubspec.yaml
```

## Teknologi

- Flutter
- Dart
- Dio 5.11.1
- Flutter Riverpod 3.4.3
- GoRouter 18.0.1
- JSONPlaceholder

Versi package di atas mengikuti versi stabil yang tersedia saat project disusun. Dio mendukung konfigurasi timeout dan interceptor, Riverpod 3.4.3 tersedia dengan minimum Dart 3.12, dan GoRouter 18.0.1 juga mendukung minimum Dart 3.12. citeturn2search1turn2search7turn3search1

## Cara Menjalankan

Pastikan Flutter sudah terpasang.

```bash
flutter pub get
flutter analyze
flutter test
flutter run
```

Jika folder ini dimasukkan ke repository Flutter yang belum memiliki folder platform, jalankan:

```bash
flutter create .
```

lalu:

```bash
flutter pub get
flutter test
flutter run
```

## Fitur yang Bisa Didemokan

### 1. Daftar post

Halaman utama mengambil data dari `/posts` melalui:

```text
UI
↓
Riverpod Provider
↓
PostRepository
↓
Dio
↓
JSONPlaceholder
```

UI tidak memanggil Dio secara langsung.

### 2. Loading / Error / Empty / Success

Aplikasi memiliki tampilan berbeda untuk:

- loading
- error + tombol Coba lagi
- empty data
- data berhasil

### 3. Refresh

Tekan tombol refresh pada AppBar atau tarik list ke bawah.

### 4. Detail post

Tekan salah satu post untuk membuka:

```text
/post/:id
```

Halaman detail mengambil data berdasarkan ID menggunakan provider.

### 5. Pagination

Tekan tombol list pada AppBar atau buka halaman pagination.

Data dimuat 10 item per halaman. Ketika scroll mendekati bagian bawah, halaman berikutnya diminta otomatis.

Guard:

```dart
if (state.isLoadingMore || !state.hasMore) return;
```

mencegah request ganda dan menghentikan request ketika data sudah habis.

## Pengujian Error

Sesuai codelab, lakukan pengujian berikut:

1. Jalankan dengan internet normal → data posts tampil.
2. Matikan internet → tekan refresh → pesan error dan tombol retry tampil.
3. Nyalakan internet kembali → tekan Coba lagi.
4. Untuk pengujian tambahan, ubah sementara `baseUrl` menjadi URL yang salah lalu jalankan aplikasi. Setelah selesai, kembalikan URL JSONPlaceholder.

## Testing

Perintah:

```bash
flutter analyze
flutter test
```

Test mencakup:

1. `Post.fromJson` ketika field JSON hilang.
2. Mapping connection error ke pesan pengguna.
3. Provider berhasil menggunakan fake repository.
4. Provider menghasilkan error menggunakan fake repository.

Test tidak melakukan request HTTP sungguhan.

## AI Verification

Codelab meminta hasil bantuan AI diverifikasi. Catatan prompt, temuan verifikasi, dan perbaikan dicatat di:

`docs/ai-verification.md`

## Refleksi

Jawaban refleksi tentang alasan penggunaan repository, pagination, AsyncError, dan perbaikan kode dicatat di:

`docs/reflection.md`

## Checklist Sebelum Commit

- [ ] `flutter analyze` tidak menghasilkan issue.
- [ ] `flutter test` lulus.
- [ ] Loading tampil.
- [ ] Success tampil.
- [ ] Error + retry dapat diuji.
- [ ] Empty state tersedia.
- [ ] Pagination berjalan.
- [ ] Tidak ada request ganda saat scroll.
- [ ] Detail post dapat dibuka.
- [ ] Dokumentasi AI sudah diisi.
- [ ] Screenshot hasil aplikasi sudah ditambahkan ke `screenshots/`.

## Referensi

- Codelab Minggu 4 Networking & REST API:
  http://jti-polinema.github.io/flutter-codelab/04-minggu-4-networking-rest-api/index.html
- JSONPlaceholder:
  https://jsonplaceholder.typicode.com
- Dio:
  https://pub.dev/packages/dio
- Flutter Riverpod:
  https://pub.dev/packages/flutter_riverpod
- GoRouter:
  https://pub.dev/packages/go_router
