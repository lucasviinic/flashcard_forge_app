import 'package:flashcard_forge_app/services/contracts/contracts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesRepository implements PreferencesRepositoryContract{

  @override
  Future<void> setAppPreferences(String theme, String language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('app_theme', theme);
    await prefs.setString('app_language', language);
  }

  @override
  Future<Map<String, String?>> getAppPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final theme = prefs.getString('app_theme');
    final language = prefs.getString('app_language');
    return {
      'theme': theme,
      'language': language,
    };
  }

  @override
  Future<void> clearUserPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_id');
    await prefs.remove('user_email');
    await prefs.remove('user_googleId');
    await prefs.remove('user_isActive');
    await prefs.remove('user_name');
    await prefs.remove('user_picture');
    await prefs.remove('access_token');
  }
}