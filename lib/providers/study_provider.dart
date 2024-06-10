import 'package:flashcard_forge_app/models/FlashcardModel.dart';
import 'package:flashcard_forge_app/models/StudySessionModel.dart';
import 'package:flashcard_forge_app/models/SubjectModel.dart';
import 'package:flashcard_forge_app/models/TopicModel.dart';
import 'package:flashcard_forge_app/services/repositories/local_storage_repo.dart';
import 'package:flutter/foundation.dart';

class StudyProvider with ChangeNotifier {
  List<SubjectModel> _subjects = [];
  List<StudySessionModel> _studySessionHistory = [];

  List<SubjectModel> get subjects => _subjects;
  List<StudySessionModel> get studySessionHistory => _studySessionHistory;

  Future<void> getStudySessionHistory() async {
    _studySessionHistory = await LocalStorage().getStudySessionHistory();
    notifyListeners();
  }

  Future<void> saveStudySession(StudySessionModel session) async {
    await LocalStorage().saveStudySession(session);
  }

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

  Future<void> removeFlashcard(FlashcardModel flashcard) async {
    await LocalStorage().removeFlashcard(flashcard).then((value) => getSubjects());
  }

  Future<void> updateFlashcard(FlashcardModel flashcard) async {
    await LocalStorage().updateFlashcard(flashcard).then((value) => getSubjects());
  }
}