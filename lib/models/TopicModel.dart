import 'package:flashcard_forge_app/models/FlashcardModel.dart';

class TopicModel {
  final int id;
  final int subjectId;
  final String? imageUrl;
  final String topicName;

  TopicModel({required this.id,
    required this.subjectId,
    required this.topicName,
    this.imageUrl
  });

  factory TopicModel.fromJson(Map<String, dynamic> json) {
    return TopicModel(
      id: json['id'],
      subjectId: json['subject_id'],
      imageUrl: json['image_url'],
      topicName: json['topic_name'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'subject_id': subjectId,
        'image_url': imageUrl,
        'topic_name': topicName
      };
}

class TopicResponseModel {
  final TopicModel topic;
  final List<FlashcardModel>? flashcards;

  TopicResponseModel({
    required this.topic,
    this.flashcards,
  });

  factory TopicResponseModel.fromJson(Map<String, dynamic> json) {
    return TopicResponseModel(
      topic: TopicModel.fromJson(json['topic']),
      flashcards: (json['flashcards'] as List<dynamic>)
          .map((flashcardJson) => FlashcardModel.fromJson(flashcardJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'topic': topic.toJson(),
    'flashcards': flashcards?.map((flashcard) => flashcard.toJson()).toList(),
  };
}

