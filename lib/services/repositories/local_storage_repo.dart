import 'dart:convert';
import 'package:flashcard_forge_app/models/FlashcardModel.dart';
import 'package:flashcard_forge_app/models/StudySessionModel.dart';
import 'package:flashcard_forge_app/models/SubjectModel.dart';
import 'package:flashcard_forge_app/models/TopicModel.dart';
import 'package:flashcard_forge_app/services/contracts/local_storage.dart';
import 'package:flashcard_forge_app/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage implements LocalStorageContract {
  @override
  Future<void> saveUserData(Map<String, dynamic> userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(StorageKeys.userData, jsonEncode(userData));
  }

  @override
  Future<Map<String, dynamic>?> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataJson = prefs.getString(StorageKeys.userData);
    if (userDataJson != null) {
      return jsonDecode(userDataJson);
    }
    return null;
  }

  Future<Map<String, dynamic>> _ensureRequiredFields() async {
    final userData = await loadUserData() ?? {};
    userData.putIfAbsent(StorageKeys.subjects, () => []);
    userData.putIfAbsent(StorageKeys.preferences, () => {});
    userData.putIfAbsent(StorageKeys.studySessionHistory, () => []);
    return userData;
  }

  @override
  Future<void> createSubject(SubjectModel subject) async {
    final userData = await _ensureRequiredFields();

    List<dynamic> subjectsList = userData[StorageKeys.subjects];

    int nextLocalId = _calculateNextLocalId(subjectsList);
    subject.id = nextLocalId;

    subjectsList.add(subject.toJson());
    userData[StorageKeys.subjects] = subjectsList;

    await saveUserData(userData);
  }

  @override
  Future<List<SubjectModel>> getSubjects() async {
    final userData = await _ensureRequiredFields();

    List<SubjectModel> subjects = [];
    userData[StorageKeys.subjects].forEach((subjectJson) {
      subjects.add(SubjectModel.fromJson(subjectJson));
    });

    return subjects;
  }

  @override
  Future<void> removeSubject(int id) async {
    final userData = await _ensureRequiredFields();

    List<dynamic> subjectsList = userData[StorageKeys.subjects];

    subjectsList.removeWhere((subjectJson) => subjectJson['id'] == id);

    await saveUserData(userData);
  }

  @override
  Future<void> updateSubject(int id, String name) async {
    final userData = await _ensureRequiredFields();

    List<dynamic> subjectsList = userData[StorageKeys.subjects];

    for (var subjectJson in subjectsList) {
      if (subjectJson['id'] == id) {
        subjectJson['subject_name'] = name;
        break;
      }
    }

    await saveUserData(userData);
  }

  @override
  Future<void> createTopic(int subjectId, TopicModel topic) async {
    final userData = await _ensureRequiredFields();

    List<dynamic> subjectsList = userData[StorageKeys.subjects];

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

  @override
  Future<void> removeTopic(int subjectId, int topicId) async {
    final userData = await _ensureRequiredFields();

    List<dynamic> subjectsList = userData[StorageKeys.subjects];

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

  @override
  Future<void> updateTopic(int subjectId, int topicId, String name) async {
    final userData = await _ensureRequiredFields();

    List<dynamic> subjectsList = userData[StorageKeys.subjects];

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

  @override
  Future<void> createFlashcard(FlashcardModel flashcard) async {
    final userData = await _ensureRequiredFields();

    List<dynamic> subjectsList = userData[StorageKeys.subjects];

    for (var subjectJson in subjectsList) {
      if (subjectJson['id'] == flashcard.subjectId) {
        List<dynamic> topicsList = subjectJson['topics'];

        for (var topicJson in topicsList) {
          if (topicJson['id'] == flashcard.topicId) {
            List<dynamic> flashcardsList = topicJson['flashcards'] ?? [];
            int nextLocalId = _calculateNextLocalId(flashcardsList);
            flashcard.id = nextLocalId;
            flashcardsList.add(flashcard.toJson());
            topicJson['flashcards'] = flashcardsList;
            break;
          }
        }

        subjectJson['topics'] = topicsList;
        break;
      }
    }

    await saveUserData(userData);
  }

  @override
  Future<void> removeFlashcard(FlashcardModel flashcard) async {
    final userData = await _ensureRequiredFields();

    List<dynamic> subjectsList = userData[StorageKeys.subjects];

    for (var subjectJson in subjectsList) {
      if (subjectJson['id'] == flashcard.subjectId) {
        List<dynamic> topicsList = subjectJson['topics'];

        for (var topicJson in topicsList) {
          if (topicJson['id'] == flashcard.topicId) {
            List<dynamic> flashcardsList = topicJson['flashcards'] ?? [];
            flashcardsList.removeWhere((reg) => reg['id'] == flashcard.id);
            topicJson['flashcards'] = flashcardsList;
            break;
          }
        }

        subjectJson['topics'] = topicsList;
        break;
      }
    }

    await saveUserData(userData);
  }

  @override
  Future<void> updateFlashcard(FlashcardModel flashcard) async {
    final userData = await _ensureRequiredFields();

    List<dynamic> subjectsList = userData[StorageKeys.subjects];

    for (var subjectJson in subjectsList) {
      if (subjectJson['id'] == flashcard.subjectId) {
        List<dynamic> topicsList = subjectJson['topics'];

        for (var topicJson in topicsList) {
          if (topicJson['id'] == flashcard.topicId) {
            List<dynamic> flashcardsList = topicJson['flashcards'] ?? [];
            for (var flashcardJson in flashcardsList) {
              if (flashcardJson['id'] == flashcard.id) {
                flashcardJson['question'] = flashcard.question;
                flashcardJson['answer'] = flashcard.answer;
                flashcardJson['difficulty'] = flashcard.difficulty;
                break;
              }
            }
            topicJson['flashcards'] = flashcardsList;
            break;
          }
        }

        subjectJson['topics'] = topicsList;
        break;
      }
    }

    await saveUserData(userData);
  }

  @override
  Future<List<StudySessionModel>> getStudySessionHistory({TopicModel? topic}) async {
    final userData = await _ensureRequiredFields();
    
    List<StudySessionModel> sessions = [];
    userData[StorageKeys.studySessionHistory].forEach((sessionJson) {
      sessions.add(StudySessionModel.fromJson(sessionJson));
    });

    return sessions;
  }

  @override
  Future<void> saveStudySession(StudySessionModel session) async {
    final userData = await _ensureRequiredFields();

    List<dynamic> sessionsList = userData[StorageKeys.studySessionHistory];
    sessionsList.add(session.toJson());

    await saveUserData(userData);
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
