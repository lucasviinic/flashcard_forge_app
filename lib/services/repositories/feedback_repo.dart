import 'dart:async';
import 'dart:convert';

import 'package:flashcard_forge_app/services/contracts/contracts.dart';
import 'package:flashcard_forge_app/services/token_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart' as http;

class FeedbackRepository implements FeedbackRepositoryContract {
  final baseURL = "${dotenv.env['API_BASE_URL']}/feedback";

  @override
  Future<void> sendFeedback(String content) async {
    String? accessToken = await TokenManager.getAccessToken();

    try {
      final response = await http.post(Uri.parse(baseURL),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken'
        },
        body: jsonEncode({
          'feedback': content,
        }),
      );
    } catch (e) {
      print('Error on sending feedback: $e');
      rethrow;
    }
  }
}