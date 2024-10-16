import 'package:flashcard_forge_app/models/SubjectModel.dart';
import 'package:flashcard_forge_app/models/TopicModel.dart';
import 'package:flashcard_forge_app/models/FlashcardModel.dart';

List<SubjectModel> subjectsListMock = [
  SubjectModel(
    id: '3545356456345gv63456v3',
    subjectName: "Math",
    userId: 'sdfgjqo48tqh4fi8q4wti8',
    topics: [
      TopicModel(
        id: '',
        subjectId: '',
        topicName: "Algebra",
        flashcards: [
          FlashcardModel(
            id: '',
            userId: '',
            subjectId: '',
            topicId: '',
            question: "What is 2 + 2?",
            answer: "4",
            difficulty: 0,
            lastResponse: false,
          ),
          FlashcardModel(
            id: '',
            userId: '',
            subjectId: '',
            topicId: '',
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
    id: 'wfqasw54w435grfg',
    subjectName: "History",
    userId: 'sdfgjqo48tqh4fi8q4wti8',
    topics: [
      TopicModel(
          id: 'jsdfjkashdjkfgasdgfvasdfgvfgadfbghdfgthsrtfhwdfg',
          subjectId: 'kjdfskgvadklfgsalkdfjgsalçif',
          topicName: "World War II",
        flashcards: [
          FlashcardModel(
            id: 'dsfjhaskujfhazlsuhf',
            userId: '',
            subjectId: '',
            topicId: '',
            question: "When did World War II start?",
            answer: "1939",
            difficulty: 0,
            lastResponse: false,
          ),
          FlashcardModel(
            id: '',
            userId: '',
            subjectId: '',
            topicId: '',
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
    id: '56457t8y4e85uhgugfdhbfgsdhn',
    subjectName: "Science",
    userId: 'sdfgjqo48tqh4fi8q4wti8',
    topics: [
      TopicModel(
        id: 'dsjkfgaksfghlksdhvuahfsukh',
        subjectId: 'kjdskjfghaldfgksadfgiafg',
        topicName: "Physics",
        flashcards: [
          FlashcardModel(
            id: '',
            userId: '',
            subjectId: '',
            topicId: '',
            question: "What is the formula for force?",
            answer: "Mass x Acceleration",
            difficulty: 0,
            lastResponse: false,
          ),
          FlashcardModel(
            id: '',
            userId: '',
            subjectId: '',
            topicId: '',
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
    id: 'efedkgimnqei8hfudgbsukdrgvsdfug',
    subjectName: "Literature",
    userId: 'sdfgjqo48tqh4fi8q4wti8',
    topics: [
      TopicModel(
        id: '3485ywerfywe8rfhiwuednvsdfhvbsb',
        subjectId: 'fdgivhiadsfhgvsdfugvsdfujg',
        topicName: "Shakespeare",
        flashcards: [
          FlashcardModel(
            id: '',
            userId: '',
            subjectId: '',
            topicId: '',
            question: "Who wrote 'Romeo and Juliet'?",
            answer: "William Shakespeare",
            difficulty: 0,
            lastResponse: false,
          ),
          FlashcardModel(
            id: '',
            userId: '',
            subjectId: '',
            topicId: '',
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
    id: 'ergfwnir78gfrdsfsudgdfgsdfg',
    subjectName: "Art",
    userId: 'sdfgjqo48tqh4fi8q4wti8',
    topics: [
      TopicModel(
        id: 'dfjghaulfhgvsudfcgusdfhgkuv',
        subjectId: 'jsdnfgjkashfbgvujashdkguvj',
        topicName: "Renaissance Art",
        flashcards: [
          FlashcardModel(
            id: '',
            userId: '',
            subjectId: '',
            topicId: '',
            question: "Who painted the Mona Lisa?",
            answer: "Leonardo da Vinci",
            difficulty: 0,
            lastResponse: false,
          ),
          FlashcardModel(
            id: '',
            userId: '',
            subjectId: '',
            topicId: '',
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
      id: 'jksdnflkjasdnfkijahsndif',
      userId: '',
      subjectId: '',
      topicId: '',
      question: "Qual peça de Shakespeare apresenta o famoso monólogo 'Ser ou não ser'?",
      answer: "Hamlet",
      difficulty: 0,
      lastResponse: false,
      imageUrl: null,
    ),
    FlashcardModel(
      id: 'jksdnflkjasdnfkijahsndif',
      userId: '',
      subjectId: '',
      topicId: '',
      question: "Qual é o nome da filha de Shakespeare?",
      answer: "Susanna",
      difficulty: 0,
      lastResponse: false,
      imageUrl: null,
    ),
    FlashcardModel(
      id: 'jksdnflkjasdnfkijahsndif',
      userId: '',
      subjectId: '',
      topicId: '',
      question: "Qual é a comédia de Shakespeare que envolve uma disputa amorosa?",
      answer: "Sonho de uma Noite de Verão",
      difficulty: 0,
      lastResponse: false,
      imageUrl: null,
    ),
  ];