import 'package:cgpa/theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  bool get isLightMode => _themeData == lightMode;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  ThemeProvider() {
    _loadTheme();
  }

  Future<void> toggleTheme() async {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
    await _saveTheme();
  }

  _saveTheme() async {
    final pref = await SharedPreferences.getInstance();
    pref.setBool('isLightMode', isLightMode);
  }

  _loadTheme() async {
    final pref = await SharedPreferences.getInstance();
    if (pref.getBool('isLightMode') == true) {
      themeData = lightMode;
    } else {
      themeData = darkMode;
    }
    notifyListeners();
  }
}
