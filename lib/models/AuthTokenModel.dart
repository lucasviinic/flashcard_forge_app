class AuthTokenModel {
  String? accessToken;
  String? refreshToken;

  AuthTokenModel({
    this.accessToken,
    this.refreshToken
  });

  factory AuthTokenModel.fromJson(Map<String, dynamic> json) {
    return AuthTokenModel(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
    );
  }

  Map<String, dynamic> toJson() => {
    'access_token': accessToken,
    'refresh_token': refreshToken
  };
}
