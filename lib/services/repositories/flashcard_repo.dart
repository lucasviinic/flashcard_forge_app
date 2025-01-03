import 'dart:io';

import 'package:flashcard_forge_app/models/FlashcardModel.dart';
import 'package:flashcard_forge_app/models/ResponseModel.dart';
import 'dart:async';

import 'package:flashcard_forge_app/services/contracts/contracts.dart';
import 'package:flashcard_forge_app/services/token_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class FlashcardRepository implements FlashcardRepositoryContract {
  final baseURL = "${dotenv.env['API_BASE_URL']}/flashcards";

  @override
  Future<FlashcardListResponseModel?> fetchFlashcards(String topicId, {int? limit, int? offset = 0, String searchTerm = ""}) async {
    String? accessToken = await TokenManager.getAccessToken();

    try {
      final queryParameters = {
        'topic_id': topicId,
        'limit': limit != null ? limit.toString() : '0',
        'offset': offset.toString(),
        'search': searchTerm,
      };

      final response = await http.get(
        Uri.parse(baseURL).replace(queryParameters: queryParameters),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        return FlashcardListResponseModel.fromJson(data);
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
  Future<List<FlashcardModel>> uploadFile(
      File file, int quantity, int difficulty, String subjectId, String topicId) async {
    String? accessToken = await TokenManager.getAccessToken();
    
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse("$baseURL/generate?quantity=$quantity&difficulty=$difficulty&subject_id=$subjectId&topic_id=$topicId")
      );

      var fileStream = http.ByteStream(file.openRead());
      var length = await file.length();
      
      var multipartFile = http.MultipartFile(
        'file',
        fileStream,
        length,
        filename: file.path.split('/').last
      );
      
      request.headers.addAll({
        'Authorization': 'Bearer $accessToken'
      });
      
      request.files.add(multipartFile);
      
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      
      if (response.statusCode == 201) {
        var jsonResponse = json.decode(response.body) as Map<String, dynamic>;
        if (jsonResponse.containsKey('flashcards')) {
          List<dynamic> flashcardsJson = jsonResponse['flashcards'];
          return flashcardsJson
              .map((json) => FlashcardModel.fromJson(json))
              .toList();
        } else {
          throw Exception('Invalid response format');
        }
      } else {
        throw Exception('Failed to upload file: ${response.reasonPhrase}');
      }
      
    } catch (e) {
      print('Error on create flashcard: $e');
      return [];
    }
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
