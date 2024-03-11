import 'package:flashcard_forge_app/models/SubjectModel.dart';
import 'package:flashcard_forge_app/models/TopicModel.dart';
import 'package:flashcard_forge_app/models/FlashcardModel.dart';

List<SubjectResponseModel> subjectsListMock = [
  SubjectResponseModel(
    subject: SubjectModel(
      id: 1,
      subjectName: "Math",
      userId: 1,
    ),
    topics: [
      TopicResponseModel(
        topic: TopicModel(
          id: 1,
          subjectId: 1,
          topicName: "Algebra",
        ),
        flashcards: [
          FlashcardModel(
            id: 1,
            userId: 1,
            subjectId: 1,
            topicId: 1,
            question: "What is 2 + 2?",
            answer: "4",
            lastResponse: false,
          ),
          FlashcardModel(
            id: 2,
            userId: 1,
            subjectId: 1,
            topicId: 1,
            question: "What is 3 * 3?",
            answer: "9",
            lastResponse: false,
          ),
        ],
      ),
    ],
  ),
  SubjectResponseModel(
    subject: SubjectModel(
      id: 2,
      subjectName: "History",
      userId: 1,
    ),
    topics: [
      TopicResponseModel(
        topic: TopicModel(
          id: 2,
          subjectId: 2,
          topicName: "World War II",
        ),
        flashcards: [
          FlashcardModel(
            id: 3,
            userId: 1,
            subjectId: 2,
            topicId: 2,
            question: "When did World War II start?",
            answer: "1939",
            lastResponse: false,
          ),
          FlashcardModel(
            id: 4,
            userId: 1,
            subjectId: 2,
            topicId: 2,
            question: "Who was the leader of Nazi Germany?",
            answer: "Adolf Hitler",
            lastResponse: false,
          ),
        ],
      ),
    ],
  ),
  SubjectResponseModel(
    subject: SubjectModel(
      id: 3,
      subjectName: "Science",
      userId: 1,
    ),
    topics: [
      TopicResponseModel(
        topic: TopicModel(
          id: 3,
          subjectId: 3,
          topicName: "Physics",
        ),
        flashcards: [
          FlashcardModel(
            id: 5,
            userId: 1,
            subjectId: 3,
            topicId: 3,
            question: "What is the formula for force?",
            answer: "Mass x Acceleration",
            lastResponse: false,
          ),
          FlashcardModel(
            id: 6,
            userId: 1,
            subjectId: 3,
            topicId: 3,
            question: "What is the SI unit for electric current?",
            answer: "Ampere",
            lastResponse: false,
          ),
        ],
      ),
    ],
  ),
  SubjectResponseModel(
    subject: SubjectModel(
      id: 4,
      subjectName: "Literature",
      userId: 1,
    ),
    topics: [
      TopicResponseModel(
        topic: TopicModel(
          id: 4,
          subjectId: 4,
          topicName: "Shakespeare",
        ),
        flashcards: [
          FlashcardModel(
            id: 7,
            userId: 1,
            subjectId: 4,
            topicId: 4,
            question: "Who wrote 'Romeo and Juliet'?",
            answer: "William Shakespeare",
            lastResponse: false,
          ),
          FlashcardModel(
            id: 8,
            userId: 1,
            subjectId: 4,
            topicId: 4,
            question: "In which city does 'Romeo and Juliet' take place?",
            answer: "Verona",
            lastResponse: false,
          ),
        ],
      ),
    ],
  ),
  SubjectResponseModel(
    subject: SubjectModel(
      id: 5,
      subjectName: "Art",
      userId: 1,
    ),
    topics: [
      TopicResponseModel(
        topic: TopicModel(
          id: 5,
          subjectId: 5,
          topicName: "Renaissance Art",
        ),
        flashcards: [
          FlashcardModel(
            id: 9,
            userId: 1,
            subjectId: 5,
            topicId: 5,
            question: "Who painted the Mona Lisa?",
            answer: "Leonardo da Vinci",
            lastResponse: false,
          ),
          FlashcardModel(
            id: 10,
            userId: 1,
            subjectId: 5,
            topicId: 5,
            question: "Which art movement does 'The Last Supper' belong to?",
            answer: "Renaissance",
            lastResponse: false,
          ),
        ],
      ),
    ],
  ),
];
