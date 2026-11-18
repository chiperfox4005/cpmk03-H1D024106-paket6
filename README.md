# Laporan Proyek CPMK 03: Presensi Peserta Seminar (Paket 6)

## Identitas Mahasiswa
- **Nama**: Fikry Mumtaz Pratama
- **NIM**: H1D024106
- **Paket**: 6 (Presensi Peserta Seminar)
- **Mata Kuliah**: Praktikum Pemrograman Mobile
- **Program Studi**: Informatika

## Deskripsi Aplikasi
Aplikasi ini merupakan implementasi sistem manajemen data peserta seminar berbasis mobile. Aplikasi dirancang untuk melakukan operasi CRUD (Create, Read, Update, Delete) pada data pendaftar seminar dengan mekanisme penyimpanan lokal menggunakan pustaka Hive. 

Arsitektur aplikasi mengacu pada pola Model-View-Controller (MVC) untuk memisahkan tanggung jawab antara struktur data, logika bisnis, dan antarmuka pengguna. State management, dependency injection, dan navigasi ditangani menggunakan pustaka GetX untuk memastikan reaktivitas antarmuka dan kode yang terstruktur.

## Fitur Utama
1. **Operasi CRUD Lengkap**: Penambahan, pembacaan, pembaruan, dan penghapusan data peserta dengan dialog konfirmasi.
2. **Validasi Formulir**: 
   - NIM: Wajib diisi, kombinasi huruf dan angka, panjang 8–12 karakter, dan unik.
   - Nama: Wajib diisi.
   - Email: Wajib diisi dengan format yang valid.
   - Program Studi: Pilihan dari dropdown (minimal 3 opsi).
3. **Fitur Khusus Paket 6**:
   - Tombol status kehadiran yang dapat diubah secara langsung dari halaman daftar tanpa membuka formulir edit.
   - Statistik kehadiran dinamis pada AppBar (format: "Hadir X/Y").
   - Filter data reaktif berdasarkan status kehadiran (Semua, Hadir, Belum Hadir).
4. **Pencarian Data**: Filter real-time berdasarkan NIM atau nama peserta.
5. **Persistensi Data**: Data tersimpan secara permanen di perangkat menggunakan Hive, tidak hilang saat aplikasi ditutup.
6. **Pengujian Otomatis**: Unit test untuk memverifikasi integritas lapisan Service (Create/Read, Update, Delete).

## Spesifikasi Teknis
- **Framework**: Flutter & Dart
- **State Management & Routing**: GetX
- **Local Database**: Hive & Hive Flutter
- **Arsitektur**: Model-View-Controller (MVC)

## Cara Menjalankan Aplikasi
Pastikan Flutter SDK telah terinstal dan dikonfigurasi pada sistem sebelum menjalankan langkah-langkah berikut:

1. Klon repositori ini ke direktori lokal:
   ```bash
   git clone https://github.com/chiperfox4005/cpmk03-H1D024106-paket6.git

2. Youtube https://youtu.be/WvWUv4YcLnY
