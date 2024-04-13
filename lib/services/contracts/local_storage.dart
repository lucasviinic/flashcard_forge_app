import 'package:flashcard_forge_app/models/SubjectModel.dart';

abstract class LocalStorageContract {
  Future<void> saveUserData(Map<String, dynamic> userData);
  Future<Map<String, dynamic>?> loadUserData();
  Future<void> createSubject(SubjectModel subject);
  Future<List<SubjectModel>> getSubjects();
  Future<void> removeSubject(int id);
  Future<void> updateSubject(int id, String name);
}