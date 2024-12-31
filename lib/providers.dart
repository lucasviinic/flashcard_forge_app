import 'package:flashcard_forge_app/services/repositories/auth_repo.dart';
import 'package:flashcard_forge_app/utils/constants.dart';
import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _currentTheme = AppThemes.lightTheme;

  ThemeData get currentTheme => _currentTheme;

  ThemeProvider() {
    _loadTheme();
  }

  void toggleTheme() async {
    if (_currentTheme == AppThemes.lightTheme) {
      _currentTheme = AppThemes.darkTheme;
    } else {
      _currentTheme = AppThemes.lightTheme;
    }
    notifyListeners();
    await _saveTheme();
  }

  Future<void> _saveTheme() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLightTheme', _currentTheme == AppThemes.lightTheme);
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isLightTheme = prefs.getBool('isLightTheme') ?? true;
    _currentTheme = isLightTheme ? AppThemes.lightTheme : AppThemes.darkTheme;
    notifyListeners();
  }
}

class AuthProvider with ChangeNotifier {
  GoogleSignInAccount? _currentUser;
  bool _isAuthenticated = false;
  String? _accessToken;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'openid', 'profile']);
  final AuthRepository _authRepository = AuthRepository();

  String? get accessToken => _accessToken;
  bool get isAuthenticated => _isAuthenticated;

  GoogleSignInAccount? get currentUser => _currentUser;

  AuthProvider() {
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      _currentUser = account;
      notifyListeners();
    });
    _googleSignIn.signInSilently();
    _initialize();
  }

  Future<void> _initialize() async {
    await loadAccessTokenFromPrefs();
    if (_accessToken != null) {
      _isAuthenticated = true;
      notifyListeners();
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        throw 'Login foi cancelado pelo usuário';
      }

      _currentUser = googleUser;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final String? googleAccessToken = googleAuth.accessToken;

      if (googleAccessToken == null) {
        throw 'Token do Google inválido';
      }

      await authenticate(googleAccessToken);
    } catch (e) {
      print('Erro ao fazer login com o Google: $e');
      logout();
    }
  }

  Future<void> authenticate(String googleAccessToken) async {
    try {
      final authToken = await _authRepository.authenticate(googleAccessToken);

      if (authToken != null) {
        _accessToken = authToken.accessToken;
        _isAuthenticated = true;
        notifyListeners();
      } else {
        throw 'Falha na autenticação com o backend';
      }
    } catch (e) {
      print('Erro ao autenticar no backend: $e');
      logout();
    }
  }

  Future<void> logout() async {
    try {
      await _googleSignIn.signOut();
      await _authRepository.logoutUser();

      _currentUser = null;
      _accessToken = null;
      _isAuthenticated = false;

      notifyListeners();
    } catch (e) {
      print('Erro ao fazer logout: $e');
    }
  }

  Future<void> loadAccessTokenFromPrefs() async {
    final token = await _authRepository.getStoredAccessToken();
    if (token != null) {
      _accessToken = token;
      _isAuthenticated = true;
      notifyListeners();
    }
  }
}
