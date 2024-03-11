import 'package:flashcard_forge_app/models/TopicModel.dart';

class SubjectModel {
  final int id;
  final String subjectName;
  final int userId;
  final String? imageUrl;

  SubjectModel({
    required this.id,
    required this.subjectName,
    required this.userId,
    this.imageUrl
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
      id: json['id'],
      subjectName: json['subject_name'],
      imageUrl: json['image_url'],
      userId: json['user_id']
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'subject_name': subjectName,
    'image_url': imageUrl,
    'user_id': userId
  };
}

class SubjectResponseModel {
  final SubjectModel subject;
  final List<TopicResponseModel> topics;

  SubjectResponseModel({
    required this.subject,
    required this.topics,
  });

  factory SubjectResponseModel.fromJson(Map<String, dynamic> json) {
    return SubjectResponseModel(
      subject: SubjectModel.fromJson(json['subject']),
      topics: (json['topics'] as List<dynamic>)
          .map((topicJson) => TopicResponseModel.fromJson(topicJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'subject': subject.toJson(),
    'topics': topics.map((topic) => topic.toJson()).toList(),
  };
}