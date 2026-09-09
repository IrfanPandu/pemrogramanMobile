## Refleksi

### 1. Apa perbedaan imperative dan declarative UI?

Declarative UI mendeskripsikan tampilan berdasarkan state saat ini.
Ketika state berubah, Flutter akan membangun kembali bagian UI
yang diperlukan.

Sedangkan imperative UI lebih berfokus pada instruksi perubahan
UI secara langsung.

### 2. Kapan Expanded membantu?

Expanded membantu membagi ruang yang tersedia di dalam Row atau
Column agar child dapat menggunakan ruang yang tersedia.

Expanded dapat menyebabkan layout error apabila digunakan pada
konteks yang tidak memiliki batas ukuran yang sesuai.

### 3. Bagaimana breakpoint memengaruhi UI?

Breakpoint digunakan untuk menentukan kapan layout berubah.
Pada aplikasi ini breakpoint 700 px digunakan untuk menentukan
apakah dashboard menampilkan satu atau dua kolom.

### 4. Apa yang diverifikasi dari AI?

AI digunakan setelah implementasi utama untuk membandingkan
alternatif layout, memahami penggunaan Expanded, serta
memverifikasi responsive layout dan accessibility.