import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');
  String _localeStr = 'en';

  Locale get locale => _locale;
  String get localeStr => _localeStr;

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }

   void changeLocale(String languageCode) {
    _locale = Locale(languageCode);
    _localeStr = languageCode;
    notifyListeners();
  }
}