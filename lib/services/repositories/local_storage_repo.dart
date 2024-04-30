import 'dart:convert';
import 'package:flashcard_forge_app/models/SubjectModel.dart';
import 'package:flashcard_forge_app/models/TopicModel.dart';
import 'package:flashcard_forge_app/services/contracts/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage implements LocalStorageContract {

  @override
  Future<void> saveUserData(Map<String, dynamic> userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_data', jsonEncode(userData));
  }

  @override
  Future<Map<String, dynamic>?> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataJson = prefs.getString('user_data');
    if (userDataJson != null) {
      return jsonDecode(userDataJson);
    }
    return null;
  }

  @override
  Future<void> createSubject(SubjectModel subject) async {
    final userData = await loadUserData() ?? {'subjects': [], 'preferences': {}};

    List<dynamic> subjectsList = userData['subjects'];

    int nextLocalId = _calculateNextLocalId(subjectsList);
    subject.id = nextLocalId;

    subjectsList.add(subject.toJson());
    userData['subjects'] = subjectsList;

    await saveUserData(userData);
  }

  @override
  Future<List<SubjectModel>> getSubjects() async {
    final userData = await loadUserData() ?? {'subjects': [], 'preferences': {}};

    List<SubjectModel> subjects = [];
    userData['subjects'].forEach((subjectJson) {
      subjects.add(SubjectModel.fromJson(subjectJson));
    });

    return subjects;
  }

  @override
  Future<void> removeSubject(int id) async {
    Map<String, dynamic>? userData = await loadUserData();
  
    if (userData != null) {
      List<dynamic> subjectsList = userData['subjects'];

      subjectsList.removeWhere((subjectJson) => subjectJson['id'] == id);

      await saveUserData(userData);
    }
  }

  @override
  Future<void> updateSubject(int id, String name) async {
    Map<String, dynamic>? userData = await loadUserData();

    if (userData != null) {
      List<dynamic> subjectsList = userData['subjects'];

      for (var subjectJson in subjectsList) {
        if (subjectJson['id'] == id) {
          subjectJson['subject_name'] = name;
          break;
        }
      }

      await saveUserData(userData);
    }
  }

  @override
  Future<void> createTopic(int subjectId, TopicModel topic) async {
    Map<String, dynamic>? userData = await loadUserData();

    if (userData != null) {
      List<dynamic> subjectsList = userData['subjects'];

      for (var subjectJson in subjectsList) {
        if (subjectJson['id'] == subjectId) {
          subjectJson['topics'] = subjectJson['topics'] ?? [];
          topic.id = _calculateNextLocalId(subjectJson['topics']);
          subjectJson['topics'].add(topic.toJson());
          subjectsList[subjectsList.indexOf(subjectJson)] = subjectJson;
          break;
        }
      }

      await saveUserData(userData);
    }
  }

  @override
  Future<void> removeTopic(int subjectId, int topicId) async {
    Map<String, dynamic>? userData = await loadUserData();

    if (userData != null) {
      List<dynamic> subjectsList = userData['subjects'];

      for (var subjectJson in subjectsList) {
        if (subjectJson['id'] == subjectId) {
          List<dynamic> topicsList = subjectJson['topics'];
          topicsList.removeWhere((topicJson) => topicJson['id'] == topicId);
          subjectJson['topics'] = topicsList;
          break;
        }
      }

      await saveUserData(userData);
    }
  }

  @override
  Future<void> updateTopic(int subjectId, int topicId, String name) async {
    Map<String, dynamic>? userData = await loadUserData();

    if (userData != null) {
      List<dynamic> subjectsList = userData['subjects'];

      for (var subjectJson in subjectsList) {
        if (subjectJson['id'] == subjectId) {
          List<dynamic> topicsList = subjectJson['topics'];

          for (var topicJson in topicsList) {
            if (topicJson['id'] == topicId) {
              topicJson['topic_name'] = name;
              break;
            }
          }

          subjectJson['topics'] = topicsList;
          break;
        }
      }

      await saveUserData(userData);
    }
  }

  int _calculateNextLocalId(List<dynamic> items) {
    int maxId = 0;
    for (var item in items) {
      int generatedId = item['id'] ?? 0;
      if (generatedId > maxId) {
        maxId = generatedId;
      }
    }
    return maxId + 1;
  }
}
