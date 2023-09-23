import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

int date = DateTime.now().day;
int month = DateTime.now().month;
int year = DateTime.now().year;
Map months = {
  1: 'JAN',
  2: 'FEB',
  3: 'MAR',
  4: 'APR',
  5: 'MAY',
  6: 'JUN',
  7: 'JUL',
  8: 'AUG',
  9: 'SEP',
  10: 'OCT',
  11: 'NOV',
  12: 'DEC'
};
List st = [1, 21, 31];
List nd = [2, 22];
List rd = [3, 23];


class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;
  bool get isSystem => themeMode == ThemeMode.system;
  bool get isDark => themeMode == ThemeMode.dark;

  void getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    themeMode = (prefs.getString('theme') ?? 0) == 'system'
        ? ThemeMode.system
        : ThemeMode.dark;
  }

  void toggleSystemTheme(bool isSystem, bool isOn) {
    var chosenThemeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    themeMode = isSystem ? ThemeMode.system : chosenThemeMode;
    notifyListeners();
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
