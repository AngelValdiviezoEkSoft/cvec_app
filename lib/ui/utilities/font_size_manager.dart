import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FontSizeManager extends ChangeNotifier {
  final Map<String, double> fontSizes = {};

  double factor = 1.0;

  Future<void> loadFontSizes() async {
    final prefs = await SharedPreferences.getInstance();
    factor = (prefs.getInt('PorcFontSize') ?? 100) / 100.0;

    final baseSizes = [
      9, 10, 11, 12, 13, 14, 15,
      16, 17, 18, 20, 22, 23, 24,
      25, 26, 28, 30, 32, 34, 35, 40,
      44, 45, 48, 50, 52, 58, 60,
      64, 74, 110
    ];

    for (var size in baseSizes) {
      fontSizes["FontSize$size"] = size * factor;
    }

    notifyListeners();
  }

  double get(String key) => fontSizes[key] ?? 14.0;
}