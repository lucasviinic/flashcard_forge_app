import 'dart:async';

import 'package:flashcard_forge_app/models/AuthTokenModel.dart';
import 'package:flashcard_forge_app/models/UserModel.dart';
import 'package:flashcard_forge_app/services/contracts/contracts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthRepository implements AuthRepositoryContract {
  final String baseURL = 'https://a7a0-45-179-129-1.ngrok-free.app/auth';

  @override
  Future<AuthTokenModel?> authenticate(String accessToken) async {
    try {
      final response = await http.post(Uri.parse('$baseURL/signin'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'access_token': accessToken,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return AuthTokenModel.fromJson(responseData);
      } else {
        print('Erro na autenticação: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Erro na chamada de autenticação: $e');
      return null;
    }
  }

  @override
  Future<UserModel?> getStoredUser() async {
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
        email: email,
        googleId: googleId,
        isActive: isActive,
        name: name,
        picture: picture,
      );
    }
    return null;
  }
}
