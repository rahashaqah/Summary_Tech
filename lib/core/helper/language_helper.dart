import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageHelper {
  static const _key = "selected_locale";

  static Future<void> saveLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, locale.languageCode);
  }

  static Future<Locale> getSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final langCode = prefs.getString(_key) ?? 'en';
    return Locale(langCode);
  }
}
