import 'package:flashcard_forge_app/models/FlashcardModel.dart';
import 'package:flashcard_forge_app/models/StudySessionModel.dart';
import 'package:flashcard_forge_app/models/SubjectModel.dart';
import 'package:flashcard_forge_app/models/TopicModel.dart';
import 'package:flashcard_forge_app/services/contracts/contract.dart';

class FlashcardServiceImpl implements FlashcardServiceContract {
  final String baseUrl;

  FlashcardServiceImpl({this.baseUrl = 'https://api.example.com'});

  // Mock data
  final List<SubjectModel> _mockSubjects = [
    SubjectModel(
      id: 1,
      subjectName: 'Math',
      userId: 123,
      imageUrl: 'http://example.com/math.png',
      topics: [
        TopicModel(
          id: 1,
          subjectId: 1,
          topicName: 'Algebra',
          imageUrl: 'http://example.com/algebra.png',
          flashcards: [
            FlashcardModel(
              id: 1,
              userId: 123,
              subjectId: 1,
              topicId: 1,
              question: 'What is x in the equation 2x + 3 = 7?',
              answer: '2',
              difficulty: 0,
              lastResponse: true,
              imageUrl: null
            ),
            FlashcardModel(
              id: 2,
              userId: 123,
              subjectId: 1,
              topicId: 1,
              question: 'What is the quadratic formula?',
              answer: 'x = (-b ± √(b²-4ac)) / 2a',
              difficulty: 1,
              lastResponse: false,
              imageUrl: null
            )
          ]
        ),
        TopicModel(
          id: 2,
          subjectId: 1,
          topicName: 'Geometry',
          imageUrl: 'http://example.com/geometry.png',
          flashcards: [
            FlashcardModel(
              id: 3,
              userId: 123,
              subjectId: 1,
              topicId: 2,
              question: 'What is the area of a circle?',
              answer: 'πr²',
              difficulty: 1,
              lastResponse: true,
              imageUrl: null
            )
          ]
        )
      ]
    ),
    SubjectModel(
      id: 2,
      subjectName: 'History',
      userId: 456,
      imageUrl: 'http://example.com/history.png',
      topics: [
        TopicModel(
          id: 3,
          subjectId: 2,
          topicName: 'Ancient Civilizations',
          imageUrl: 'http://example.com/ancient.png',
          flashcards: [
            FlashcardModel(
              id: 4,
              userId: 456,
              subjectId: 2,
              topicId: 3,
              question: 'Who was the first emperor of Rome?',
              answer: 'Augustus',
              difficulty: 0,
              lastResponse: false,
              imageUrl: null
            )
          ]
        )
      ]
    ),
    SubjectModel(
      id: 3,
      subjectName: 'Science',
      userId: 789,
      imageUrl: 'http://example.com/science.png',
      topics: [
        TopicModel(
          id: 4,
          subjectId: 3,
          topicName: 'Physics',
          imageUrl: 'http://example.com/physics.png',
          flashcards: [
            FlashcardModel(
              id: 5,
              userId: 789,
              subjectId: 3,
              topicId: 4,
              question: 'What is Newton\'s second law of motion?',
              answer: 'F = ma',
              difficulty: 0,
              lastResponse: true,
              imageUrl: null
            )
          ]
        )
      ]
    )
  ];

  @override
  Future<List<SubjectModel>> getSubjects() async {
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    return _mockSubjects;
  }

  @override
  Future<SubjectModel> createSubject(SubjectModel subject) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    return subject; // Return the same subject for mock
  }

  @override
  Future<TopicModel> createTopic(TopicModel topic) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    return topic; // Return the same topic for mock
  }

  @override
  Future<FlashcardModel> createFlashcard(FlashcardModel flashcard) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    return flashcard; // Return the same flashcard for mock
  }

  @override
  Future<List<StudySessionModel>> getStudySessions() async {
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    final mockSessions = [
      StudySessionModel(
        subjectId: 1,
        topicId: 1,
        correctAnswerCount: 5,
        incorrectAnswerCount: 2,
        totalQuestions: 10,
        totalTimeSpent: '15m',
        easyQuestionCount: 4,
        mediumQuestionCount: 3,
        hardQuestionCount: 3,
        easyQuestions: [],
        mediumQuestions: [],
        hardQuestions: [],
        createdAt: DateTime.now()
      )
    ];
    return mockSessions;
  }
}
