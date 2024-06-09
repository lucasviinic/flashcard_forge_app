import 'package:flashcard_forge_app/models/FlashcardModel.dart';
import 'package:flashcard_forge_app/models/SubjectModel.dart';
import 'package:flashcard_forge_app/models/TopicModel.dart';
import 'package:flashcard_forge_app/services/repositories/local_storage_repo.dart';
import 'package:flutter/foundation.dart';

class StudyProvider with ChangeNotifier {
  List<SubjectModel> _subjects = [];
  List<SubjectModel> get subjects => _subjects;

  Future<void> getSubjects() async {
    _subjects = await LocalStorage().getSubjects();
    notifyListeners();
  }

  Future<void> removeSubject(int id) async {
    await LocalStorage().removeSubject(id).then((value) => getSubjects());
  }

  Future<void> createSubject(SubjectModel subject) async {
    await LocalStorage().createSubject(subject).then((value) => getSubjects());
  }

  Future<void> updateSubject(int id, String name) async {
    await LocalStorage().updateSubject(id, name).then((value) => getSubjects());
  }

  Future<void> createTopic(int subjectId, TopicModel topic) async {
    await LocalStorage().createTopic(subjectId, topic).then((value) => getSubjects());
  }

  Future<void> removeTopic(int subjectId, int topicId) async {
    await LocalStorage().removeTopic(subjectId, topicId).then((value) => getSubjects());
  }

  Future<void> updateTopic(int subjectId, int topicId, String name) async {
    await LocalStorage().updateTopic(subjectId, topicId, name).then((value) => getSubjects());
  }

  Future<void> createFlashcard(FlashcardModel flashcard) async {
    await LocalStorage().createFlashcard(flashcard).then((value) => getSubjects());
  }

  Future<void> removeFlashcard(int subjectId, int topicId, int flashcardId) async {
    await LocalStorage().removeFlashcard(subjectId, topicId, flashcardId).then((value) => getSubjects());
  }

  Future<void> updateFlashcard(int subjectId, int topicId, int flashcardId, FlashcardModel flashcard) async {
    await LocalStorage().updateFlashcard(subjectId, topicId, flashcardId, flashcard).then((value) => getSubjects());
  }
}