import 'dart:convert';

class SaveFcmTokenRequest {
  SaveFcmTokenRequest({
    required this.guid,
    required this.fcmToken,
    required this.deviceType,
  });

  String guid;
  String fcmToken;
  String deviceType;

  Map<String, dynamic> toMap() => {
        "guid": guid,
        "fcmToken": fcmToken,
        "deviceType": deviceType,
      };

  String toJson() => json.encode(toMap());
}
