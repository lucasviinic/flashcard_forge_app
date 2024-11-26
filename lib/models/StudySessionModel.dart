import 'package:flashcard_forge_app/models/FlashcardModel.dart';

class StudySessionModel {
  String? id;
  String subjectId;
  String topicName;
  String topicId;
  int correctAnswerCount;
  int incorrectAnswerCount;
  int totalQuestions;
  String totalTimeSpent;
  int easyQuestionCount;
  int mediumQuestionCount;
  int hardQuestionCount;
  DateTime? createdAt;

  StudySessionModel({
    this.id,
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
    this.createdAt
  });

  factory StudySessionModel.fromJson(Map<String, dynamic> json) {
    return StudySessionModel(
      id: json['id'],
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
      createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : null
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
    'created_at': createdAt
  };
}
