import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');
  String _localeStr = 'en';

  Locale get locale => _locale;
  String get localeStr => _localeStr;

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }

  void loadLanguageLocale() async {    
    final prefs = await SharedPreferences.getInstance();
    var codLang = prefs.getString('languageCode') ?? '';

    if(codLang.isNotEmpty){
      _localeStr = codLang;
      _locale = Locale(codLang);
    }    

    notifyListeners();
  }

  void changeLocale(String languageCode) async {
    _locale = Locale(languageCode);
    _localeStr = languageCode;

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('languageCode', languageCode); 

    notifyListeners();
  }
}