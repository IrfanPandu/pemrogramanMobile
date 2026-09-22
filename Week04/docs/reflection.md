# Refleksi Week 4

## 1. Mengapa UI dilarang memanggil Dio secara langsung?

Karena UI sebaiknya fokus pada tampilan dan interaksi pengguna. Jika setiap widget memanggil API sendiri, kode menjadi sulit diuji, sulit dirawat, dan konfigurasi jaringan dapat tersebar di banyak tempat.

Repository menjadi satu pintu untuk sumber data sehingga perubahan API tidak perlu mengubah banyak widget.

## 2. Kapan pagination diperlukan?

Pagination cocok ketika data yang tersedia cukup banyak sehingga mengirim seluruh data sekaligus tidak efisien.

Pada project ini digunakan pagination server-side dengan `_page` dan `_limit`, kemudian UI menggunakan infinite scroll.

## 3. Bagaimana exception menjadi AsyncError?

Repository membiarkan exception naik ketika request gagal. `AsyncNotifier` menjalankan method async pada `build()`, sehingga Riverpod dapat merepresentasikan hasil asynchronous sebagai loading, data, atau error.

Try/catch eksplisit tetap dibutuhkan ketika aplikasi ingin melakukan tindakan khusus, misalnya mengubah state refresh menjadi `AsyncError` atau menampilkan pesan tertentu.

## 4. Bagian yang diperbaiki

Kode dirapikan dengan memisahkan:

- widget `PostTile`
- fungsi pesan error
- repository
- provider
- state pagination
- halaman detail

Pemisahan tersebut membuat tanggung jawab setiap file lebih jelas dan membantu testing.
