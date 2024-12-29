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
  bool _isLoggedIn = false;
  String? _accessToken;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'openid', 'profile']);

  String? get accessToken => _accessToken;

  Future<void> setAccessToken(String token) async {
    _accessToken = token;
    notifyListeners();
  }

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
        _isLoggedIn = true;
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

  bool get isLoggedIn => _isLoggedIn;

  void clearLoginState() {
    _isLoggedIn = false;
    notifyListeners();
  }

  Future<GoogleSignInAccount?> signOutFromGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signOut();
      _currentUser = googleUser;
      _isLoggedIn = false;
      notifyListeners();
      return _currentUser;
    } catch (e) {
      print('Error logging out from Google: $e');
      return _currentUser;
    }
  }
}
