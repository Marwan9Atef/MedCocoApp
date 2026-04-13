/// Response from the refresh-token endpoint (matches `{ "access_token": "..." }`).
class RefreshTokenResponseModel {
  RefreshTokenResponseModel({this.accessToken});

  factory RefreshTokenResponseModel.fromJson(Map<String, dynamic> json) {
    return RefreshTokenResponseModel(
      accessToken: json['access_token'] as String?,
    );
  }

  final String? accessToken;
}
