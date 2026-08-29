# Praktikum Week01

## Identitas

Nama : Irfan Pandu Pratama
NIM : 244107020193

## Pertanyaan dan Jawaban Pertanyaan

### 1. Apa perbedaan Hot reload dan Hot restart?

**Jawaban :**
Hot reload digunakan untuk menerapkan perubahan kode ke aplikasi yang sedang berjalan dengan cepat, sehingga dev dapat melihat hasil dari perubahan tanpa memulai aplikasi dari awal. Sementara Hot restart akan menjalankan kembali aplikasi dari kondisi awal sehingga state yang sebelumnya tersimpan akan di reset.

### 2. Kapan native lebih tepat dipilih daripada cross-platform?

**Jawaban :**
Pengembangan native lebih sesuai ketika sebuah aplikasi membutuhkan performa yang sangat optimal, membutuhkan akses langsung atau lebih mendalam terhadap kemampuan perangkat, atau memiliki kebutuhan yang sangat spesifik terhadap sistem operasi tertentu. Dalam kondisi tersebut, penggunaan teknologi native dapat memberikan kontrol dan integrasi yang lebih baik dibandingkan pendekatan cross-platform.

### 3. Bagaimana perubahan state berhubungan dengan widget tree dan UI deklaratif?

**Jawaban :**
State merupakan data atau kondisi yang dapat berubah selama aplikasi berjalan. Pada Flutter, perubahan state dapat menyebabkan widget yang bergantung pada state tersebut melakukan rebuild. Dengan pendekatan UI deklaratif, tampilan aplikasi ditentukan berdasarkan kondisi atau state saat ini, sehingga ketika state berubah, Flutter memperbarui bagian widget tree yang diperlukan agar tampilan sesuai dengan kondisi terbaru.

### 4. Mengapa commit kecil dengan pesan yang jelas bermanfaat bagi pekerjaan tim dan portfolio?

**Jawaban :**
Commit yang dibuat dalam ukuran kecil dan menggunakan pesan yang jelas membuat setiap perubahan lebih mudah dilacak dan dipahami. Dalam kerja tim, hal ini membantu anggota tim mengetahui perubahan yang dilakukan, mempermudah proses code review, membantu menemukan sumber masalah, serta memungkinkan perubahan tertentu dikembalikan tanpa harus membatalkan seluruh pekerjaan.

Untuk portfolio, riwayat commit yang teratur dapat menunjukkan bahwa proses pengembangan dilakukan secara terstruktur. Repository juga menjadi lebih mudah dipahami oleh orang lain, termasuk recruiter atau developer yang ingin melihat bagaimana sebuah project dikembangkan.
