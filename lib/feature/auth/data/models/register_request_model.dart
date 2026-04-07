class RegisterRequestModel {
  RegisterRequestModel({
      this.username, 
      this.email, 
      this.password,});


  String? username;
  String? email;
  String? password;
RegisterRequestModel copyWith({  String? username,
  String? email,
  String? password,
}) => RegisterRequestModel(  username: username ?? this.username,
  email: email ?? this.email,
  password: password ?? this.password,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['username'] = username;
    map['email'] = email;
    map['password'] = password;
    return map;
  }

}