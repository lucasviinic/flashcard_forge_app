import 'dart:io';

import 'package:flashcard_forge_app/models/FlashcardModel.dart';
import 'dart:async';

import 'package:flashcard_forge_app/services/contracts/contracts.dart';
import 'package:flashcard_forge_app/services/token_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class FlashcardRepository implements FlashcardRepositoryContract {
  final baseURL = "${dotenv.env['API_BASE_URL']}/flashcards";

  @override
  Future<List<FlashcardModel>?> fetchFlashcards(String topicId, int offset, int limit, String searchTerm) async {
    String? accessToken = await TokenManager.getAccessToken();

    try {
      final response = await http.get(
        Uri.parse("$baseURL?topic_id=$topicId&limit=$limit&offset=$offset&search=$searchTerm"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data  = jsonDecode(response.body);
        List<FlashcardModel> flashcards = data.map((json) => FlashcardModel.fromJson(json)).toList();

        return flashcards;
      } else {
        print('Failed to fetch flashcards. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error on get all user flashcards: $e');
      return null;
    }
  }

  @override
  Future<FlashcardModel?> updateFlashcard(FlashcardModel flashcard) async {
    String? accessToken = await TokenManager.getAccessToken();
    
    try {
      final response = await http.put(Uri.parse("$baseURL/${flashcard.id}"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken'
        },
        body: json.encode(flashcard.toJson())
      );

      if (response.statusCode == 200) {
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

  @override
  Future<bool> deleteFlashcard(String flashcardId) async {
    String? accessToken = await TokenManager.getAccessToken();

    try {
      final response = await http.delete(Uri.parse("$baseURL/$flashcardId"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken'
        }
      );
      return response.statusCode == 204;
    } catch (e) {
      print('Error on delete flashcard: $e');
      return false;
    }
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
