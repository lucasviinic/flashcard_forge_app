import 'package:flashcard_forge_app/models/FlashcardModel.dart';

class StudySessionModel {
  int subjectId;
  String topicName;
  int topicId;
  int correctAnswerCount;
  int incorrectAnswerCount;
  int totalQuestions;
  String totalTimeSpent;
  int easyQuestionCount;
  int mediumQuestionCount;
  int hardQuestionCount;
  List<FlashcardModel> easyQuestions;
  List<FlashcardModel> mediumQuestions;
  List<FlashcardModel> hardQuestions;
  DateTime createdAt;

  StudySessionModel({
    required this.subjectId,
    required this.topicName,
    required this.topicId,
    required this.correctAnswerCount,
    required this.incorrectAnswerCount,
    required this.totalQuestions,
    required this.totalTimeSpent,
    required this.easyQuestionCount,
    required this.mediumQuestionCount,
    required this.hardQuestionCount,
    required this.easyQuestions,
    required this.mediumQuestions,
    required this.hardQuestions,
    required this.createdAt
  });

  factory StudySessionModel.fromJson(Map<String, dynamic> json) {
    return StudySessionModel(
      subjectId: json['subject_id'],
      topicName: json['topic_name'],
      topicId: json['topic_id'],
      correctAnswerCount: json['correct_answer_count'],
      incorrectAnswerCount: json['incorrect_answer_count'],
      totalQuestions: json['total_questions'],
      totalTimeSpent: json['total_time_spent'],
      easyQuestionCount: json['easy_question_count'],
      mediumQuestionCount: json['medium_question_count'],
      hardQuestionCount: json['hard_question_count'],
      easyQuestions: (json['easy_questions'] as List)
          .map((e) => FlashcardModel.fromJson(e))
          .toList(),
      mediumQuestions: (json['medium_questions'] as List)
          .map((e) => FlashcardModel.fromJson(e))
          .toList(),
      hardQuestions: (json['hard_questions'] as List)
          .map((e) => FlashcardModel.fromJson(e))
          .toList(),
      createdAt: json["created_at"]
    );
  }

  Map<String, dynamic> toJson() => {
    'subject_id': subjectId,
    'topic_id': topicId,
    'topic_name': topicName,
    'correct_answer_count': correctAnswerCount,
    'incorrect_answer_count': incorrectAnswerCount,
    'total_questions': totalQuestions,
    'total_time_spent': totalTimeSpent,
    'easy_question_count': easyQuestionCount,
    'medium_question_count': mediumQuestionCount,
    'hard_question_count': hardQuestionCount,
    'easy_questions': easyQuestions.map((e) => e.toJson()).toList(),
    'medium_questions': mediumQuestions.map((e) => e.toJson()).toList(),
    'hard_questions': hardQuestions.map((e) => e.toJson()).toList(),
    'created_at': createdAt
  };
}
