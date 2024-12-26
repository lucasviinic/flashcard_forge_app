class FlashcardModel {
  String? id;
  String? userId;
  String? subjectId;
  String? topicId;
  String? question;
  String? answer;
  int? difficulty; //0: easy, 1: medium, 2: hard
  bool? lastResponse;
  bool? opened;
  String? imageUrl;

  FlashcardModel({
    this.id,
    this.userId,
    this.subjectId,
    this.topicId,
    this.question,
    this.answer,
    this.difficulty,
    this.lastResponse,
    this.opened,
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
      difficulty: json['difficulty'],
      lastResponse: json['last_response'],
      opened: json['opened'],
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
    'difficulty': difficulty,
    'last_response': lastResponse,
    'opened': opened,
    'image_url': imageUrl
  };
}
