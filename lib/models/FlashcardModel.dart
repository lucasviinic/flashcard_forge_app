class FlashcardModel {
  final int id;
  final int userId;
  final int subjectId;
  final int topicId;
  final String question;
  final String answer;
  final bool lastResponse;
  final String? imageUrl;

  FlashcardModel({
    required this.id,
    required this.userId,
    required this.subjectId,
    required this.topicId,
    required this.question,
    required this.answer,
    required this.lastResponse,
    this.imageUrl
  });

  factory FlashcardModel.fromJson(Map<String, dynamic> json) {
    return FlashcardModel(
      id: json['id'],
      userId: json['user_id'],
      subjectId: json['subject_id'],
      topicId: json['topic_id'],
      question: json['question'],
      answer: json['answer'],
      lastResponse: json['last_response'],
      imageUrl: json['image_url']
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'subject_id': subjectId,
        'topic_id': topicId,
        'question': question,
        'answer': answer,
        'last_response': lastResponse,
        'image_url': imageUrl
      };
}
