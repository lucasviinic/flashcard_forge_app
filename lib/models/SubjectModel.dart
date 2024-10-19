import 'package:flashcard_forge_app/models/TopicModel.dart';

class SubjectModel {
  String? id;
  String? subjectName;
  String? userId;
  String? imageUrl;
  List<TopicModel>? topics = [];

  SubjectModel({
    this.id,
    this.subjectName,
    this.userId,
    this.imageUrl,
    this.topics
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    List<TopicModel> topics = [];
    if (json['topics'] != null) {
      json['topics'].forEach((topicJson) {
        topics.add(TopicModel.fromJson(topicJson));
      });
    }

    return SubjectModel(
      id: json['id'],
      subjectName: json['subject_name'],
      imageUrl: json['image_url'],
      userId: json['user_id'],
      topics: topics
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'subject_name': subjectName,
    'image_url': imageUrl,
    'user_id': userId,
    'topics': topics?.map((topic) => topic.toJson()).toList(),
  };
}