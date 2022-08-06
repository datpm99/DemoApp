import 'dart:convert';

CaptchaModel captchaModelFromJson(String str) =>
    CaptchaModel.fromJson(json.decode(str));

class CaptchaModel {
  CaptchaModel({
    required this.status,
    required this.error,
    this.data,
  });

  int status;
  String error;
  Data? data;

  factory CaptchaModel.fromJson(Map<String, dynamic> json) => CaptchaModel(
        status: json["status"] ?? 0,
        error: json["error"] ?? '',
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    required this.captcha,
  });

  String captcha;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        captcha: json["captcha"] ?? '',
      );
}
