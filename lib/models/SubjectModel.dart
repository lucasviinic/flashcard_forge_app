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
