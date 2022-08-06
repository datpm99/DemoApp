import 'dart:convert';

class ForgotPasswordRequest {
  ForgotPasswordRequest({
    required this.email,
  });

  String email;

  Map<String, dynamic> toMap() => {
        "email": email,
      };

  String toJson() => json.encode(toMap());
}
