import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeChanger with ChangeNotifier {
  ThemeData _themeData;
  bool _isSortedByTotal = false;

  ThemeData lightTheme = ThemeData.light();
  ThemeData darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Color(0xff121212),
    accentColor: Colors.grey[850],
    cardColor: Colors.grey[900],
  );

  ThemeChanger({bool isDarkMode, bool isSortedByTotal}) {
    _themeData = isDarkMode ? darkTheme : lightTheme;
    _isSortedByTotal = isSortedByTotal;
  }

  ThemeData get getTheme => _themeData;
  bool get getSortStatus => _isSortedByTotal;

  Future<void> swapSort() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    if (preferences.getBool('isSortedByTotal')) {
      preferences.setBool('isSortedByTotal', false);
    } else
      preferences.setBool('isSortedByTotal', true);

    _isSortedByTotal = preferences.getBool('isSortedByTotal');
    notifyListeners();
  }

  Future<void> swapTheme() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (_themeData == darkTheme) {
      _themeData = lightTheme;
      preferences.setBool('isDarkTheme', false);
    } else {
      _themeData = darkTheme;
      preferences.setBool('isDarkTheme', true);
    }
    notifyListeners();
  }
}
