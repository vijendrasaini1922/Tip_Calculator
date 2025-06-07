import 'package:flutter/material.dart';

class Themeprovider extends ChangeNotifier {
  bool _isDarkMode = false;

  // getter
  bool get isDarkMode => _isDarkMode;

  // Method to toggle between dark and light mode
  void toggleTheme(){
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  } 

  ThemeData get currentTheme {
    return _isDarkMode ? ThemeData.dark() : ThemeData.light();
  }
}