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
    },
    'id': {
      'title': 'Lokalisasi',
      'bahasa': 'Bahasa',
      'halo': 'Halo',
      'login': 'Masuk',
      'belajar': 'Mari Mulai Belajar',
      'daftar': 'Daftar'
    },
  };

  static String translate(BuildContext context, String key) {
    final locale = Localizations.localeOf(context).languageCode;
    return _localizedValues[locale]?[key] ?? key;
  }
}
