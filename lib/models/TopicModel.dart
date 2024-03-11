class TopicModel {
  final int id;
  final int subjectId;
  final String? imageUrl;
  final String topicName;

  TopicModel({
    required this.id,
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
