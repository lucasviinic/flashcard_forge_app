import 'package:flashcard_forge_app/models/SubjectModel.dart';
import 'package:flashcard_forge_app/models/TopicModel.dart';
import 'package:flashcard_forge_app/models/FlashcardModel.dart';

List<SubjectModel> subjectsListMock = [
  SubjectModel(
    id: 1,
    subjectName: "Math",
    userId: 1,
    topics: [
      TopicModel(
        id: 1,
        subjectId: 1,
        topicName: "Algebra",
        flashcards: [
          FlashcardModel(
            id: 1,
            userId: 1,
            subjectId: 1,
            topicId: 1,
            question: "What is 2 + 2?",
            answer: "4",
            difficulty: 0,
            lastResponse: false,
          ),
          FlashcardModel(
            id: 2,
            userId: 1,
            subjectId: 1,
            topicId: 1,
            question: "What is 3 * 3?",
            answer: "9",
            difficulty: 0,
            lastResponse: false,
          ),
        ],
      ),
    ],
  ),
  SubjectModel(
    id: 2,
    subjectName: "History",
    userId: 1,
    topics: [
      TopicModel(
          id: 2,
          subjectId: 2,
          topicName: "World War II",
        flashcards: [
          FlashcardModel(
            id: 3,
            userId: 1,
            subjectId: 2,
            topicId: 2,
            question: "When did World War II start?",
            answer: "1939",
            difficulty: 0,
            lastResponse: false,
          ),
          FlashcardModel(
            id: 4,
            userId: 1,
            subjectId: 2,
            topicId: 2,
            question: "Who was the leader of Nazi Germany?",
            answer: "Adolf Hitler",
            difficulty: 0,
            lastResponse: false,
          ),
        ],
      ),
    ],
  ),
  SubjectModel(
    id: 3,
    subjectName: "Science",
    userId: 1,
    topics: [
      TopicModel(
        id: 3,
        subjectId: 3,
        topicName: "Physics",
        flashcards: [
          FlashcardModel(
            id: 5,
            userId: 1,
            subjectId: 3,
            topicId: 3,
            question: "What is the formula for force?",
            answer: "Mass x Acceleration",
            difficulty: 0,
            lastResponse: false,
          ),
          FlashcardModel(
            id: 6,
            userId: 1,
            subjectId: 3,
            topicId: 3,
            question: "What is the SI unit for electric current?",
            answer: "Ampere",
            difficulty: 0,
            lastResponse: false,
          ),
        ],
      ),
    ],
  ),
  SubjectModel(
    id: 4,
    subjectName: "Literature",
    userId: 1,
    topics: [
      TopicModel(
        id: 4,
        subjectId: 4,
        topicName: "Shakespeare",
        flashcards: [
          FlashcardModel(
            id: 7,
            userId: 1,
            subjectId: 4,
            topicId: 4,
            question: "Who wrote 'Romeo and Juliet'?",
            answer: "William Shakespeare",
            difficulty: 0,
            lastResponse: false,
          ),
          FlashcardModel(
            id: 8,
            userId: 1,
            subjectId: 4,
            topicId: 4,
            question: "In which city does 'Romeo and Juliet' take place?",
            answer: "Verona",
            difficulty: 0,
            lastResponse: false,
          ),
        ],
      ),
    ],
  ),
  SubjectModel(
    id: 5,
    subjectName: "Art",
    userId: 1,
    topics: [
      TopicModel(
        id: 5,
        subjectId: 5,
        topicName: "Renaissance Art",
        flashcards: [
          FlashcardModel(
            id: 9,
            userId: 1,
            subjectId: 5,
            topicId: 5,
            question: "Who painted the Mona Lisa?",
            answer: "Leonardo da Vinci",
            difficulty: 0,
            lastResponse: false,
          ),
          FlashcardModel(
            id: 10,
            userId: 1,
            subjectId: 5,
            topicId: 5,
            question: "Which art movement does 'The Last Supper' belong to?",
            answer: "Renaissance",
            difficulty: 0,
            lastResponse: false,
          ),
        ],
      ),
    ],
  ),
];

List<FlashcardModel> flashcardListMock = [
    FlashcardModel(
      id: 1,
      userId: 1,
      subjectId: 1,
      topicId: 1,
      question: "Qual peça de Shakespeare apresenta o famoso monólogo 'Ser ou não ser'?",
      answer: "Hamlet",
      difficulty: 0,
      lastResponse: false,
      imageUrl: null,
    ),
    FlashcardModel(
      id: 2,
      userId: 1,
      subjectId: 1,
      topicId: 1,
      question: "Qual é o nome da filha de Shakespeare?",
      answer: "Susanna",
      difficulty: 0,
      lastResponse: false,
      imageUrl: null,
    ),
    FlashcardModel(
      id: 3,
      userId: 1,
      subjectId: 1,
      topicId: 1,
      question: "Qual é a comédia de Shakespeare que envolve uma disputa amorosa?",
      answer: "Sonho de uma Noite de Verão",
      difficulty: 0,
      lastResponse: false,
      imageUrl: null,
    ),
  ];