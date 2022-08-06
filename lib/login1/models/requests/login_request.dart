import 'dart:convert';

LoginRequest loginRequestFromJson(String str) =>
    LoginRequest.fromMap(json.decode(str));

class LoginRequest {
  LoginRequest({
    required this.username,
    required this.password,
    required this.guid,
    required this.captcha,
  });

  String username;
  String password;
  String guid;
  String captcha;

  factory LoginRequest.fromMap(Map<String, dynamic> map) {
    return LoginRequest(
      username: map['username'],
      password: map['password'],
      guid: map['guid'],
      captcha: map['captcha'],
    );
  }

  Map<String, dynamic> toMap() => {
        "username": username,
        "password": password,
        "guid": guid,
        "captcha": captcha,
      };

  String toJson() => json.encode(toMap());
}
