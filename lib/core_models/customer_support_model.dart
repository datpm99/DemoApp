import 'dart:convert';

CustomerSupportModel customerSupportModelFromJson(String str) =>
    CustomerSupportModel.fromJson(json.decode(str));

class CustomerSupportModel {
  CustomerSupportModel({
    required this.status,
    required this.error,
    required this.data,
  });

  int status;
  String error;
  List<CustomerSupport> data;

  factory CustomerSupportModel.fromJson(Map<String, dynamic> json) =>
      CustomerSupportModel(
        status: json["status"] ?? 0,
        error: json["error"] ?? '',
        data: json["data"] == null
            ? []
            : List<CustomerSupport>.from(
                json["data"].map((x) => CustomerSupport.fromJson(x))),
      );
}

class CustomerSupport {
  CustomerSupport({
    required this.id,
    required this.code,
    required this.name,
  });

  int id;
  String code;
  String name;

  factory CustomerSupport.fromJson(Map<String, dynamic> json) =>
      CustomerSupport(
        id: json["id"] ?? 0,
        code: json["code"] ?? '',
        name: json["name"] ?? '',
      );
}
