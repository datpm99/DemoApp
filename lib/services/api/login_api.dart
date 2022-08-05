class LoginApi {
  static String login = 'public/auth/login';
  static String refreshCaptcha = 'public/captcha/generateCaptcha/';
  static String forgetPassword = 'public/auth/forget-password';
  static String changePassword = 'user/private/change-password';
  static String firstTimeLogin = 'user/private/update-first-time-login';
  static String loginOutSide = 'public/auth/loginByEmailAndCode';
  static String renewCode = 'contract/document/public/renew-verification-code';

  ///User.
  static String getProfile = 'user/private/get-user-profile';
  static String saveFcmToken = 'notification/private/save-fcm-token';
  static String getCusSupport =
      'system-parameter/private/find-system-parameters-over-systems/CSKH';
}
