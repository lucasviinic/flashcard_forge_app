import 'package:flashcard_forge_app/models/SubjectModel.dart';
import 'package:flashcard_forge_app/services/contracts/contracts.dart';
import 'package:flashcard_forge_app/services/token_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class SubjectRepository implements SubjectRepositoryContract {
  final baseURL = "${dotenv.env['API_BASE_URL']}/subjects";

  @override
  Future<List<SubjectModel>?> fetchSubjects(int offset, int limit) async {
    String? accessToken = await TokenManager.getAccessToken();

    try {
      final response = await http.get(Uri.parse("$baseURL?limit=$limit&offset=$offset"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken'
        }
      );

      if (response.statusCode == 200) {
        final List<dynamic> data  = jsonDecode(response.body);
        List<SubjectModel> subjects = data.map((json) => SubjectModel.fromJson(json)).toList();

        return subjects;
      } else {
        print('Failed to fetch subjects. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error on get all user subjects: $e');
      return null;
    }
  }

  @override
  Future<SubjectModel> createSubject(SubjectModel subject) async {
    //subject.id = Random().nextInt(1000);
    return Future.value(subject);
  }

  @override
  Future<bool> deleteSubject(String subjectId) async {
    String? accessToken = await TokenManager.getAccessToken();

    try {
      final response = await http.delete(Uri.parse("$baseURL/$subjectId"),
        headers: {
          'Authorization': 'Bearer $accessToken'
        }
      );

      if (response.statusCode == 204) {
        return true;
      }

      return false;
    } catch (e) {
      // exibe modal de erro
      return false;
    }
  }

  @override
  Future<SubjectModel> updateSubject(SubjectModel subject) async {
    return Future.value(subject);
  }
}
