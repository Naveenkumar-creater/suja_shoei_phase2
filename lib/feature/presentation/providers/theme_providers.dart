import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  bool _darkTheme = false;

  bool get isDarkTheme => _darkTheme;

  ThemeProvider() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _darkTheme = prefs.getBool('theme') ?? false;
    notifyListeners();
  }

  Future<void> setDarkTheme(bool value) async {
    _darkTheme = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('theme', _darkTheme);
    notifyListeners();
  }
}
