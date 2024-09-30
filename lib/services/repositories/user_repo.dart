import 'package:flashcard_forge_app/models/UserModel.dart';
import 'package:flashcard_forge_app/services/contracts/contracts.dart';
import 'package:flashcard_forge_app/services/token_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository implements UserRepositoryContract {
  final baseURL = "${dotenv.env['API_BASE_URL']}/user";

  @override
  Future<UserModel?> getUser() async {
    try {
      final storedUser = await _getStoredUser();
      if (storedUser != null) {
        return storedUser;
      }

      final accessToken = await TokenManager.getAccessToken();

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };

      final response = await http.get(
        Uri.parse(baseURL),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final user = UserModel.fromJson(responseData);

        await _storeUser(user);

        return user;
      } else {
        print('Erro ao buscar o usuário: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Erro na chamada para buscar o usuário: $e');
      return null;
    }
  }

  Future<void> _storeUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt('user_id', user.id ?? 0);
    await prefs.setString('user_googleId', user.googleId ?? '');
    await prefs.setString('user_email', user.email ?? '');
    await prefs.setString('user_name', user.name ?? '');
    await prefs.setString('user_picture', user.picture ?? '');
    await prefs.setBool('user_isActive', user.isActive ?? false);
  }

  Future<UserModel?> _getStoredUser() async {
    final prefs = await SharedPreferences.getInstance();
    
    final id = prefs.getInt('user_id');
    final email = prefs.getString('user_email');
    final googleId = prefs.getString('user_googleId');
    final isActive = prefs.getBool('user_isActive');
    final name = prefs.getString('user_name');
    final picture = prefs.getString('user_picture');

    if (id != null && email != null && googleId != null && isActive != null && name != null && picture != null) {
      return UserModel(
        id: id,
        googleId: googleId,
        email: email,
        name: name,
        picture: picture,
        isActive: isActive,
      );
    }
    return null;
  }
}
