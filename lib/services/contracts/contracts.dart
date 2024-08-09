import 'package:flashcard_forge_app/models/FlashcardModel.dart';
import 'package:flashcard_forge_app/models/SubjectModel.dart';
import 'package:flashcard_forge_app/models/TopicModel.dart';

abstract class SubjectRepositoryContract {
  Future<List<SubjectModel>> fetchSubjects();
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
}
