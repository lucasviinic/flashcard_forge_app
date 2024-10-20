import 'dart:io';

import 'package:flashcard_forge_app/models/FlashcardModel.dart';
import 'dart:async';

import 'package:flashcard_forge_app/services/contracts/contracts.dart';
import 'package:flashcard_forge_app/services/token_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class FlashcardRepository implements FlashcardRepositoryContract {
  final baseURL = "${dotenv.env['API_BASE_URL']}/flashcards/";

  @override
  Future<FlashcardModel> updateFlashcard(FlashcardModel flashcard) async {
    return Future.value(flashcard);
  }

  @override
  Future<void> deleteFlashcard(String flashcardId) async {
    return Future.value();
  }

  @override
  Future<List<FlashcardModel>> uploadFile(File file) async {
    return [];
  }

  @override
  Future<FlashcardModel?> createFlashcard(FlashcardModel flashcard) async {
    String? accessToken = await TokenManager.getAccessToken();
    
    try {
      final response = await http.post(Uri.parse(baseURL),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken'
        },
        body: json.encode(flashcard.toJson())
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        FlashcardModel flashcard_ = FlashcardModel.fromJson(data);
        return flashcard_;
      } else {
        print('Error on create flashcard');
        return null;
      }
    } catch (e) {
      print('Error on create flashcard: $e');
      return null;
    }
    
  }
}
