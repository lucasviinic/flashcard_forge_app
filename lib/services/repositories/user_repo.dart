import 'package:flashcard_forge_app/models/UserModel.dart';
import 'package:flashcard_forge_app/services/contracts/contracts.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class UserRepository implements UserRepositoryContract {
  final String baseURL = 'http://127.0.0.1:8000/user';

  @override
  Future<UserModel?> getUser(String accessToken) async {
    try {
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
        return UserModel.fromJson(responseData);
      } else {
        print('Erro ao buscar o usuário: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Erro na chamada para buscar o usuário: $e');
      return null;
    }
  }
}