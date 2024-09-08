class UserModel {
  int? id;
  String? googleId;
  String? email;
  String? name;
  String? picture;
  bool? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;

  UserModel({
    this.id,
    this.googleId,
    this.email,
    this.name,
    this.picture,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      googleId: json['google_id'],
      email: json['email'],
      name: json['name'],
      picture: json['picture'],
      isActive: json['is_active'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      deletedAt: json['deleted_at'] != null ? DateTime.parse(json['deleted_at']) : null,
    );
  }

  // Método para converter o UserModel em um JSON
  Map<String, dynamic> toJson() => {
    'id': id,
    'google_id': googleId,
    'email': email,
    'name': name,
    'picture': picture,
    'is_active': isActive,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
    'deleted_at': deletedAt?.toIso8601String(),
  };
}
