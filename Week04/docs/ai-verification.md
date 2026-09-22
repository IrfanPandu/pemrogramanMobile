# AI Verification

## Prompt yang digunakan

Bantuan AI digunakan untuk menyusun struktur repository layer Flutter, model Post, Dio client, Riverpod provider, pagination, testing, dan refactoring.

Prompt inti:

> Buatkan implementasi Flutter untuk codelab Week 4 Networking & REST API menggunakan Dio dan flutter_riverpod. Terapkan model Post dengan fromJson aman null, repository sebagai satu-satunya akses API, AsyncNotifierProvider untuk loading/error/data, pagination 10 item per halaman dengan guard request ganda, unit test tanpa HTTP sungguhan, dan dokumentasikan keputusan teknis.

## Verifikasi yang dilakukan

### 1. UI tidak memanggil Dio secara langsung

UI membaca provider menggunakan Riverpod.

Alur:

```text
PostListPage / PagedPostPage
        ↓
Riverpod Provider
        ↓
PostRepository
        ↓
Dio
        ↓
JSONPlaceholder
```

### 2. fromJson aman terhadap null

Model menggunakan cast nullable dan fallback:

```dart
(json['userId'] as num?)?.toInt() ?? 0
json['title'] as String? ?? ''
```

Dengan demikian field yang hilang tidak langsung menyebabkan cast null menjadi tipe non-nullable.

### 3. Timeout terpusat

`baseUrl`, `connectTimeout`, `receiveTimeout`, dan header didefinisikan pada `lib/data/api_client.dart`.

### 4. Error handling

`DioExceptionType` yang relevan dipetakan ke pesan pengguna:

- timeout
- connection error
- bad response 404
- 401/403
- error jaringan lainnya

### 5. Pagination

Pagination menggunakan `_page` dan `_limit`.

Guard:

```dart
if (state.isLoadingMore || !state.hasMore) return;
```

Digunakan untuk mencegah request ganda ketika listener scroll dipanggil berulang kali.

### 6. Testing

Test provider menggunakan `FakePostRepository`, sehingga test tidak bergantung pada koneksi internet.

## Perbaikan yang dilakukan

Beberapa hasil awal dari pola codelab dirapikan menjadi struktur yang lebih mudah dirawat:

- `PostTile` diekstrak ke `lib/widgets/post_tile.dart`.
- `friendlyErrorMessage` dipindahkan ke `lib/data/network_errors.dart`.
- Detail post ditambahkan melalui GoRouter pada `/post/:id`.
- Provider detail menggunakan repository, sehingga halaman detail tidak melakukan request Dio langsung.

## Catatan

Kode tetap perlu diuji pada environment lokal dengan:

```bash
flutter analyze
flutter test
flutter run
```

Hasil akhir testing harus dicatat setelah project dijalankan di perangkat/emulator.
