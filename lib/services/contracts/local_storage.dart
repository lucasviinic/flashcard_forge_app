import 'package:flashcard_forge_app/models/SubjectModel.dart';
import 'package:flashcard_forge_app/models/TopicModel.dart';

abstract class LocalStorageContract {
  Future<void> saveUserData(Map<String, dynamic> userData);
  Future<Map<String, dynamic>?> loadUserData();
  Future<void> createSubject(SubjectModel subject);
  Future<List<SubjectModel>> getSubjects();
  Future<void> removeSubject(int id);
  Future<void> updateSubject(int id, String name);
  Future<void> createTopic(int subjectId, TopicModel topic);
  Future<void> removeTopic(int subjectId, int topicId);
  Future<void> updateTopic(int subjectId, int topicId, String name);
}