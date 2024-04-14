import 'package:flashcard_forge_app/models/SubjectModel.dart';
import 'package:flashcard_forge_app/services/repositories/local_storage_repo.dart';
import 'package:flutter/foundation.dart';

class SubjectProvider with ChangeNotifier {
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
}