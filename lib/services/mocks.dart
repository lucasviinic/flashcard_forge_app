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
    FlashcardModel(
      id: 4,
      userId: 1,
      subjectId: 1,
      topicId: 1,
      question: "Qual é o nome do rei em 'Hamlet'?",
      answer: "Claudius",
      difficulty: 0,
      lastResponse: false,
      imageUrl: null,
    ),
    FlashcardModel(
      id: 5,
      userId: 1,
      subjectId: 1,
      topicId: 1,
      question: "Quem mata Romeu em 'Romeu e Julieta'?",
      answer: "Paris",
      difficulty: 0,
      lastResponse: false,
      imageUrl: null,
    ),
    FlashcardModel(
      id: 6,
      userId: 1,
      subjectId: 1,
      topicId: 1,
      question: "Como morre Julieta?",
      answer: "Ela se mata com uma adaga",
      difficulty: 0,
      lastResponse: false,
      imageUrl: null,
    ),
    FlashcardModel(
      id: 7,
      userId: 1,
      subjectId: 1,
      topicId: 1,
      question: "Quem é o mentor e guia espiritual de Hamlet?",
      answer: "O fantasma de seu pai",
      difficulty: 0,
      lastResponse: false,
      imageUrl: null,
    ),
    FlashcardModel(
      id: 8,
      userId: 1,
      subjectId: 1,
      topicId: 1,
      question: "Qual é o nome do irmão de Otelo que o trai?",
      answer: "Iago",
      difficulty: 0,
      lastResponse: false,
      imageUrl: null,
    ),
    FlashcardModel(
      id: 9,
      userId: 1,
      subjectId: 1,
      topicId: 1,
      question: "Qual é a tragédia de Shakespeare ambientada em Veneza?",
      answer: "Otelo",
      difficulty: 0,
      lastResponse: false,
      imageUrl: null,
    ),
    FlashcardModel(
      id: 10,
      userId: 1,
      subjectId: 1,
      topicId: 1,
      question: "Como termina 'A Tempestade'?",
      answer: "Com o perdão do protagonista Prospero",
      difficulty: 0,
      lastResponse: false,
      imageUrl: null,
    ),
    FlashcardModel(
      id: 11,
      userId: 1,
      subjectId: 1,
      topicId: 1,
      question: "Qual é o nome do antagonista em 'Rei Lear'?",
      answer: "Edmund",
      difficulty: 0,
      lastResponse: false,
      imageUrl: null,
    ),
    FlashcardModel(
      id: 12,
      userId: 1,
      subjectId: 1,
      topicId: 1,
      question: "Qual peça de Shakespeare é frequentemente considerada uma das suas mais sombrias?",
      answer: "Macbeth",
      difficulty: 0,
      lastResponse: false,
      imageUrl: null,
    ),
    FlashcardModel(
      id: 13,
      userId: 1,
      subjectId: 1,
      topicId: 1,
      question: "Qual é o nome do duque em 'Muito Barulho por Nada'?",
      answer: "Pedro",
      difficulty: 0,
      lastResponse: false,
      imageUrl: null,
    ),
    FlashcardModel(
      id: 14,
      userId: 1,
      subjectId: 1,
      topicId: 1,
      question: "Qual é o nome do príncipe em 'Henrique V'?",
      answer: "Henrique",
      difficulty: 0,
      lastResponse: false,
      imageUrl: null,
    ),
    FlashcardModel(
      id: 15,
      userId: 1,
      subjectId: 1,
      topicId: 1,
      question: "Quem é conhecido por dizer 'Tudo o que reluz não é ouro'?",
      answer: "Falstaff",
      difficulty: 0,
      lastResponse: false,
      imageUrl: null,
    ),
  ];