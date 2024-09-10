import 'package:flashcard_forge_app/utils/constants.dart';
import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';

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


class AuthProvider with ChangeNotifier {
  GoogleSignInAccount? _currentUser;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'openid', 'profile']);

  GoogleSignInAccount? get currentUser => _currentUser;

  AuthProvider() {
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      _currentUser = account;
      notifyListeners();
    });
    _googleSignIn.signInSilently();
  }

  Future<GoogleSignInAccount?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser != null) {
        _currentUser = googleUser;
        notifyListeners();
        return _currentUser;
      } else {
        return null;
      }
    } catch (e) {
      print('Error logging in with Google: $e');
      return null;
    }
  }

  Future<void> signOutFromGoogle() async {
    try {
      await _googleSignIn.signOut();
      _currentUser = null;
      notifyListeners();
    } catch (e) {
      print('Error logging out from Google: $e');
    }
  }
}
