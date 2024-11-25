import 'package:flashcard_forge_app/models/StudySessionModel.dart';
import 'dart:async';

import 'package:flashcard_forge_app/services/contracts/contracts.dart';
import 'package:flashcard_forge_app/services/token_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class StudySessionRepository implements StudySessionRepositoryContract {
  final baseURL = "${dotenv.env['API_BASE_URL']}/sessions";

  @override
  Future<List<StudySessionModel>?> fetchStudyHistory(int limit, int offset, String? searchTerm) async {
    String? accessToken = await TokenManager.getAccessToken();

    try {
      final response = await http.get(
        Uri.parse("$baseURL?limit=$limit&offset=$offset&search=${searchTerm ?? ''}"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data  = jsonDecode(response.body);
        List<StudySessionModel> sessions = data.map((json) => StudySessionModel.fromJson(json)).toList();

        return sessions;
      } else {
        print('Failed to fetch study history. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error on get study history: $e');
      return null;
    }
  }

  @override
  Future<void> saveStudySession(StudySessionModel studySession) async {
    String? accessToken = await TokenManager.getAccessToken();
    
    try {
      final response = await http.post(
        Uri.parse(baseURL),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: json.encode(studySession.toJson()),
      );

      if (response.statusCode == 201) {
        print('Study session saved successfully');
      } else {
        print('Failed to save study session: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Error on save study session: $e');
    }
  }
}
