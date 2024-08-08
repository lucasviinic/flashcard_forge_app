import 'package:flashcard_forge_app/models/FlashcardModel.dart';
import 'package:flashcard_forge_app/models/StudySessionModel.dart';
import 'package:flashcard_forge_app/models/SubjectModel.dart';
import 'package:flashcard_forge_app/models/TopicModel.dart';

abstract class FlashcardServiceContract {
  Future<List<SubjectModel>> getSubjects();
  Future<SubjectModel> createSubject(SubjectModel subject);
  Future<TopicModel> createTopic(TopicModel topic);
  Future<FlashcardModel> createFlashcard(FlashcardModel flashcard);
  Future<List<StudySessionModel>> getStudySessions();
}
