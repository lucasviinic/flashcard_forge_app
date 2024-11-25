import 'dart:io';

import 'package:flashcard_forge_app/models/AuthTokenModel.dart';
import 'package:flashcard_forge_app/models/FlashcardModel.dart';
import 'package:flashcard_forge_app/models/StudySessionModel.dart';
import 'package:flashcard_forge_app/models/SubjectModel.dart';
import 'package:flashcard_forge_app/models/TopicModel.dart';
import 'package:flashcard_forge_app/models/UserModel.dart';

abstract class AuthRepositoryContract {
  Future<AuthTokenModel?> authenticate(String accessToken);
  Future<UserModel?> getStoredUser();
}

abstract class UserRepositoryContract {
  Future<UserModel?> getUser();
}

abstract class PreferencesRepositoryContract {
  Future<void> setAppPreferences(String theme, String language);
  Future<Map<String, String?>> getAppPreferences();
  Future<void> clearUserPrefs();
}

abstract class SubjectRepositoryContract {
  Future<List<SubjectModel>?> fetchSubjects(int offset, int limit, String searchTerm);
  Future<SubjectModel> createSubject(SubjectModel subject);
  Future<bool> deleteSubject(String subjectId);
  Future<SubjectModel?> updateSubject(String id, String name);
}

abstract class TopicRepositoryContract {
  Future<TopicModel> createTopic(String subjectId, String topicName);
  Future<TopicModel> updateTopic(String subjectId, String topicId, String topicName);
  Future<bool> deleteTopic(String topicId);
}

abstract class FlashcardRepositoryContract {
  Future<List<FlashcardModel>?> fetchFlashcards(String topicId, int offset, int limit, String searchTerm);
  Future<FlashcardModel?> updateFlashcard(FlashcardModel flashcard);
  Future<void> deleteFlashcard(String flashcardId);
  Future<List<FlashcardModel>> uploadFile(File file);
  Future<FlashcardModel?> createFlashcard(FlashcardModel flashcard);
}

abstract class StudySessionRepositoryContract{
  Future<List<StudySessionModel>?> fetchStudyHistory(int limit, int offset, String? search);
  Future<void> saveStudySession(StudySessionModel studySession);
}