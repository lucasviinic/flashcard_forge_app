import 'package:flashcard_forge_app/utils/constants.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _currentTheme = AppThemes.lightTheme; // Tema inicial

  ThemeData get currentTheme => _currentTheme;

  void toggleTheme() {
    if (_currentTheme == AppThemes.lightTheme) {
      _currentTheme = AppThemes.darkTheme;
    } else {
      _currentTheme = AppThemes.lightTheme;
    }
    notifyListeners(); // Notifica os listeners sobre a mudança
  }
}