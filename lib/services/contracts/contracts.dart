import 'dart:io';

import 'package:flashcard_forge_app/models/AuthTokenModel.dart';
import 'package:flashcard_forge_app/models/FlashcardModel.dart';
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
  Future<List<SubjectModel>?> fetchSubjects();
  Future<SubjectModel> createSubject(SubjectModel subject);
  Future<void> deleteSubject(int subjectId);
  Future<SubjectModel> updateSubject(SubjectModel subject);
}

abstract class TopicRepositoryContract {
  Future<TopicModel> updateTopic(TopicModel topic);
  Future<void> deleteTopic(int topicId);
}

abstract class FlashcardRepositoryContract {
  Future<FlashcardModel> updateFlashcard(FlashcardModel flashcard);
  Future<void> deleteFlashcard(int flashcardId);
  Future<List<FlashcardModel>> uploadFile(File file);
}
