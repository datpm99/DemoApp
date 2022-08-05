import 'package:get/get.dart';

class AppValidation {
  static String email(String val) {
    val = val.trim();
    if (val.isEmpty) return 'msg_empty'.trParams({'label': 'Email'});
    if (!val.isEmail) return 'msg_invalid'.trParams({'label': 'Email'});
    return '';
  }

  static String username(String val) {
    val = val.trim();
    if (val.isEmpty) return 'msg_empty'.trParams({'label': 'username'.tr});
    return '';
  }

  static String company(String val) {
    val = val.trim();
    if (val.isEmpty) return 'msg_empty'.trParams({'label': 'company'.tr});
    return '';
  }

  static String password(String val) {
    if (val.isEmpty) return 'msg_empty'.trParams({'label': 'password'.tr});
    return '';
  }

  static String acceptCode(String val) {
    if (val.isEmpty) return 'msg_empty'.trParams({'label': 'access_code'.tr});
    return '';
  }

  static String changePassword(String val, String name) {
    String pattern =
        r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[~@#$%^&*+=])[A-Za-z\d~@#$%^&*+=]{8,50}$";
    RegExp regex = RegExp(pattern);
    if (val.isEmpty) return 'msg_empty'.trParams({'label': name.tr});

    if (val.length < 8) {
      return 'msg_length_pass'.trParams({'label': name.tr});
    }

    if (!regex.hasMatch(val)) {
      return 'msg_pass_invalid'.trParams({'label': name.tr});
    }

    return '';
  }

  static String matchPasswords(String val1, String val2) {
    if (val1 != val2) return 'msg_match_pass'.tr;
    return '';
  }

  static String captcha(String val) {
    val = val.trim();
    String pattern = r"^[0-9a-zA-Z]+$";
    RegExp regex = RegExp(pattern);
    if (val.isEmpty) return 'msg_empty'.trParams({'label': 'Captcha'});
    if (val.length < 5) return 'captcha_invalid';
    if (!regex.hasMatch(val)) return 'captcha_invalid';
    return '';
  }

  static String validEmpty(String? val) {
    if (val!.isEmpty) return 'msg_required'.tr;
    return '';
  }

  static String validEmptyReject(String val) {
    if (val.isEmpty) return 'msg_error_reason'.tr;
    return '';
  }

  // Rule validate password.
  static String validRule1(String val) {
    val = val.trim();
    if (val.isEmpty) return 'null';
    if (val.length >= 8 && val.length <= 50) return 'complete';
    return 'wrong';
  }

  static String validRule2(String val) {
    val = val.trim();
    String pattern = r"[A-Z]";
    RegExp regex = RegExp(pattern);
    if (val.isEmpty) return 'null';
    if (regex.hasMatch(val)) return 'complete';
    return 'wrong';
  }

  static String validRule3(String val) {
    val = val.trim();
    String pattern = r"[a-z]";
    RegExp regex = RegExp(pattern);
    if (val.isEmpty) return 'null';
    if (regex.hasMatch(val)) return 'complete';
    return 'wrong';
  }

  static String validRule4(String val) {
    val = val.trim();
    String pattern = r"[0-9]";
    RegExp regex = RegExp(pattern);
    if (val.isEmpty) return 'null';
    if (regex.hasMatch(val)) return 'complete';
    return 'wrong';
  }

  static String validRule5(String val) {
    val = val.trim();
    String pattern = r"^(?=.*[~@#$%^&*+=])[A-Za-z\d~@#$%^&*+=]{1,50}$";
    RegExp regex = RegExp(pattern);
    if (val.isEmpty) return 'null';
    if (regex.hasMatch(val)) return 'complete';
    return 'wrong';
  }
}
