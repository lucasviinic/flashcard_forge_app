import 'package:flashcard_forge_app/models/SubjectModel.dart';
import 'package:flashcard_forge_app/models/TopicModel.dart';
import 'package:flashcard_forge_app/models/FlashcardModel.dart';
import 'dart:math';

import 'package:flashcard_forge_app/services/contracts/contracts.dart';

class SubjectRepository implements SubjectRepositoryContract {

  @override
  Future<List<SubjectModel>> fetchSubjects() async {
    List<SubjectModel> subjects = List.generate(7, (index) {
      return SubjectModel(
        id: index + 1,
        subjectName: "Subject ${index + 1}",
        userId: 1,
        imageUrl: "https://example.com/image${index + 1}.png",
        topics: List.generate(3, (topicIndex) {
          return TopicModel(
            id: topicIndex + 1,
            subjectId: index + 1,
            topicName: "Topic ${topicIndex + 1}",
            flashcards: List.generate(5, (flashcardIndex) {
              return FlashcardModel(
                id: flashcardIndex + 1,
                userId: 1,
                subjectId: index + 1,
                topicId: topicIndex + 1,
                question: "Question ${flashcardIndex + 1}",
                answer: "Answer ${flashcardIndex + 1}",
                difficulty: Random().nextInt(3),
                lastResponse: Random().nextBool(),
                imageUrl: "https://example.com/flashcard${flashcardIndex + 1}.png",
              );
            }),
          );
        }),
      );
    });

    return Future.value(subjects);
  }

  @override
  Future<SubjectModel> createSubject(SubjectModel subject) async {
    subject.id = Random().nextInt(1000);
    return Future.value(subject);
  }

  @override
  Future<void> deleteSubject(int subjectId) async {
    return Future.value();
  }

  @override
  Future<SubjectModel> updateSubject(SubjectModel subject) async {
    return Future.value(subject);
  }
}
