import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

class LoginModel {
  LoginModel({
    required this.errorCode,
    required this.message,
    this.data,
  });

  String errorCode;
  String message;
  Data? data;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        errorCode: json["error_code"] ?? '',
        message: json.containsKey("message") ? json["message"] : '',
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    required this.token,
    required this.tokenTimeout,
    required this.message,
    required this.captcha,
  });

  String token;
  int tokenTimeout;
  String message;
  String captcha;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json.containsKey("token") ? json["token"] : '',
        tokenTimeout:
            json.containsKey("tokenTimeout") ? json["tokenTimeout"] : 0,
        message: json.containsKey("message") ? json["message"] : '',
        captcha: json.containsKey("captcha") ? json["captcha"] : '',
      );
}
