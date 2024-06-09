import 'package:flashcard_forge_app/models/FlashcardModel.dart';

class TopicModel {
  int? id;
  int subjectId;
  String? imageUrl;
  String topicName;
  List<FlashcardModel> flashcards;

  TopicModel({
    this.id,
    required this.subjectId,
    required this.topicName,
    this.imageUrl,
    List<FlashcardModel>? flashcards,
  }) : flashcards = flashcards ?? [];

  factory TopicModel.fromJson(Map<String, dynamic> json) {
    return TopicModel(
      id: json['id'],
      subjectId: json['subject_id'],
      imageUrl: json['image_url'],
      topicName: json['topic_name'],
      flashcards: (json['flashcards'] as List<dynamic>?)
          ?.map((flashcardJson) => FlashcardModel.fromJson(flashcardJson))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'subject_id': subjectId,
        'image_url': imageUrl,
        'topic_name': topicName,
        'flashcards': flashcards.map((flashcard) => flashcard.toJson()).toList(),
      };
}
