class RegisterResposneModel {
  RegisterResposneModel({
      this.message, 
      this.accessToken, 
      this.refreshToken, 
      this.user,});

  RegisterResposneModel.fromJson(dynamic json) {
    message = json['message'];
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  String? message;
  String? accessToken;
  String? refreshToken;
  User? user;
RegisterResposneModel copyWith({  String? message,
  String? accessToken,
  String? refreshToken,
  User? user,
}) => RegisterResposneModel(  message: message ?? this.message,
  accessToken: accessToken ?? this.accessToken,
  refreshToken: refreshToken ?? this.refreshToken,
  user: user ?? this.user,
);


}

class User {
  User({
      this.email, 
      this.uid,});

  User.fromJson(dynamic json) {
    email = json['email'];
    uid = json['uid'];
  }
  String? email;
  String? uid;
User copyWith({  String? email,
  String? uid,
}) => User(  email: email ?? this.email,
  uid: uid ?? this.uid,
);


}