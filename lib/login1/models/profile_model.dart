import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  ProfileModel({
    required this.status,
    required this.error,
    this.data,
  });

  int status;
  String error;
  Data? data;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        status: json["status"] ?? 0,
        error: json["error"] ?? '',
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "error": error,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    required this.userId,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.rootGroupId,
    required this.groupPathName,
    required this.isFirstLogin,
    required this.roles,
    this.avatar,
  });

  int userId;
  String fullName;
  String email;
  String phone;
  int rootGroupId;
  String groupPathName;
  bool isFirstLogin;
  List<String> roles;
  Avatar? avatar;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["userId"] ?? 0,
        fullName: json["fullName"] ?? '',
        email: json["email"] ?? '',
        phone: json["phone"] ?? '',
        rootGroupId: json["rootGroupId"] ?? 0,
        groupPathName: json["groupPathName"] ?? '',
        isFirstLogin: json["isFirstLogin"] ?? false,
        roles: (json["roles"] == null) ? [] : List<String>.from(json["roles"].map((x) => x)),
        avatar: Avatar.fromJson(json["avatar"]),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "fullName": fullName,
        "email": email,
        "phone": phone,
        "rootGroupId": rootGroupId,
        "groupPathName": groupPathName,
        "isFirstLogin": isFirstLogin,
        "roles": List<dynamic>.from(roles.map((x) => x)),
        "avatar": avatar!.toJson(),
      };
}

class Avatar {
  Avatar({
    required this.storage,
    required this.filePath,
  });

  String storage;
  String filePath;

  factory Avatar.fromJson(Map<String, dynamic> json) => Avatar(
        storage: json["storage"] ?? '',
        filePath: json["filePath"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "storage": storage,
        "filePath": filePath,
      };
}
