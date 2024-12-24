import 'package:flutter/material.dart';

mixin AppLocale {
  static const Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'title': 'Localization',
      'bahasa': 'Language',
      'halo': 'Hello',
      'login': 'Login',
      'belajar': 'Start Learning',
      'daftar': 'Sign Up',
      'merdeka': 'Freedom to learn',
      'cari': 'Search',
      'code': 'Enter Code',
      'tamu': 'Continue as Guest',
      'choose': 'The Best For You',
      'lihat': "See More",
      'soalQuiz': "Collection of quiz",
      'selamatDatangQuiz': "Welcome to quiz",
      'matematika': "Math",
      'fisika': "Physic",
      'kimia': "Chemistry",
      'course': "Course",
      'inggris': "English",
      'setelan': "Settings",
      'skor': "Score",
      'kontak': "Contact",
      'kursusdanquiz': "Course & Quizzes",
      'riwayatQuiz': "Quiz History",
      'bantuan': "Help",
      'tentangKami': "About Us",
      'keluar': "Logout",
    },
    'id': {
      'title': 'Lokalisasi',
      'bahasa': 'Bahasa',
      'halo': 'Halo',
      'login': 'Masuk',
      'belajar': 'Mari Mulai Belajar',
      'daftar': 'Daftar',
      'merdeka': 'Merdeka Belajar',
      'cari': 'Cari',
      'code': 'Masukkan Kode',
      'tamu': 'Masuk sebagai Tamu',
      'choose': 'Pilihan Terbaik Untuk Anda',
      'lihat': 'Lihat Lebih',
      'soalQuiz': 'Kumpulan Soal Quiz',
      'selamatDatangQuiz': "Selamat datang di Quiz Kami",
      'matematika': "Matematika",
      'fisika': "Fisika",
      'kimia': "Kimia",
      'course': "Kursus",
      'inggris': "Inggris",
      'setelan': "Setelan",
      'skor': "Skor",
      'kontak': "Kontak",
      'kursusdanquiz': "Kursus dan Quiz",
      'riwayatQuiz': "Riwayat Quiz",
      'bantuan': "Bantuan",
      'tentangKami': "Tentang Kami",
      'keluar': "Keluar",
    },
  };

  static String translate(BuildContext context, String key) {
    final locale = Localizations.localeOf(context).languageCode;
    return _localizedValues[locale]?[key] ?? key;
  }
}
