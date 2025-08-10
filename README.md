📌 Apk-Absensi
Aplikasi absensi asrama berbasis Flutter dengan tampilan modern, mudah digunakan, dan mendukung fitur pencatatan pelanggaran serta export data.

🚀 Cara Menjalankan Project Setelah Clone
Pastikan kamu sudah menginstall:

Flutter SDK (disarankan versi terbaru)

Dart SDK (biasanya sudah termasuk di Flutter)

Android Studio atau VS Code

Git

1️⃣ Clone Repository
bash
Salin
Edit
git clone https://github.com/Akramm-22/Apk-Absensi.git
cd Apk-Absensi
2️⃣ Install Dependency
bash      
Salin
Edit
flutter pub get
3️⃣ Jalankan di Emulator / Device
Pastikan device sudah terhubung:

bash
Salin
Edit
flutter devices
flutter run
Jika ingin menjalankan di mode release:

bash
Salin
Edit
flutter run --release
📂 Struktur Folder Utama
lib/ → Berisi source code utama aplikasi

assets/ → Berisi gambar, ikon, dan asset lainnya

pubspec.yaml → File konfigurasi Flutter dan dependency

✨ Fitur Utama
📋 Absensi Siswa

Mencatat kehadiran secara real-time

Pilihan status hadir, izin, sakit, atau alpha

🚨 Sistem Pelanggaran

Mencatat jenis pelanggaran siswa

Skor pelanggaran otomatis terhitung

📤 Export Data

Export data absensi ke format Excel/CSV

🖥 Tampilan Modern

UI responsif dan user-friendly

Menggunakan desain modern dengan warna yang nyaman di mata

⚡ Performa Cepat

Dibangun dengan Flutter, berjalan lancar di Android & iOS
