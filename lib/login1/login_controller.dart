import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';

import '/const/import_const.dart';
// import '/econtract/routes/routes_econtract.dart';
// import '/esignature/routes/routes_esignature.dart';
import '/lang/lang_controller.dart';
import 'services/login_service.dart';
import '/routes/routes.dart';
import '/widgets/get_input_text.dart';
import 'widgets/sheet_forgot_pass_widget.dart';
import 'login_fields.dart';
import 'models/profile_model.dart';
import 'models/requests/forgot_password_request.dart';
import 'models/requests/login_request.dart';
import 'models/requests/save_fcm_token_request.dart';

class LoginController extends GetxController {
  final lang = Get.find<LangController>();
  final _storage = Get.find<StorageService>();

  //final _firebase = Get.find<FirebaseService>();
  final _loginService = LoginService();
  final _fields = LoginFields();

  String typeLogin = AppConfigs.loginEContract;

  RxBool showCaptcha = false.obs; //check show captcha.
  RxString strCaptcha = ''.obs; //data captcha.
  bool isFirstLogin = false; //check login firstTime.
  List role = []; //list role user.

  GetInputTextConfig get company => _fields.company;

  GetInputTextConfig get email => _fields.email;

  GetInputTextConfig get password => _fields.password;

  GetInputTextConfig get captcha => _fields.captcha;

  GetInputTextConfig get emailForgotPass => _fields.emailForgotPass;

  //Data language.
  String logoLang = 'assets/icons/ic_lang_vn.png';
  String langCode = 'VNI';
  RxBool showChangeLang = false.obs; // check show dropdown change lang.

  //Local auth
  final auth = LocalAuthentication();
  RxBool useFingerprint = false.obs;
  RxBool face = false.obs;
  RxBool fingerprint = false.obs;
  RxBool isAuthenticating = false.obs;

  Future<void> _getAvailableBiometrics() async {
    try {
      final isAvailable = await auth.canCheckBiometrics;
      final isDeviceSupported = await auth.isDeviceSupported();
      if (!isAvailable || !isDeviceSupported) return;

      useFingerprint.value = _storage.useFingerprint;
      final availableBiometrics = await auth.getAvailableBiometrics();
      face.value = availableBiometrics.contains(BiometricType.face);
      fingerprint.value =
          availableBiometrics.contains(BiometricType.fingerprint);
    } catch (e) {
      debugPrint(e.toString());
      AppUtils.showError('have_error_msg'.tr);
    }
  }

  Future<void> authenticate() async {
    try {
      isAuthenticating.value = true;
      //update();
      bool authenticated = await auth.authenticate(
        localizedReason: 'authenticate_title'.tr,
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
        authMessages: <AuthMessages>[
          IOSAuthMessages(
            localizedFallbackTitle: 'sign_in_title'.tr,
            goToSettingsDescription: 'setup_biometric_label'.tr,
            goToSettingsButton: 'setting'.tr,
            cancelButton: 'cancel'.tr,
            lockOut: 'open_biometric'.tr,
          ),
          AndroidAuthMessages(
            signInTitle: 'sign_in_title'.tr,
            biometricRequiredTitle: 'biometric_required_title'.tr,
            goToSettingsDescription: 'setup_biometric_label'.tr,
            goToSettingsButton: 'setting'.tr,
            cancelButton: 'cancel'.tr,
            biometricNotRecognized: 'biometric_failed'.tr,
          )
        ],
      );

      if (authenticated) await _login(isLocalAuth: true);
      isAuthenticating.value = false;
      //update();
    } catch (e) {
      debugPrint(e.toString());
      await auth.stopAuthentication();
    }
  }

  void cancelAuthentication() {
    auth.stopAuthentication();
  }

  void onLogin() {
    bool validCompany = company.validate();
    bool validEmail = email.validate();
    bool validPass = password.validate();
    if (validEmail && validPass && validCompany) {
      Get.focusScope!.unfocus();
      if (showCaptcha.value && !captcha.validate()) return;
      _login();
    }
  }

  Future<void> _login({bool isLocalAuth = false}) async {
    AppUtils.showLoader();
    LoginRequest request;

    if (isLocalAuth) {
      request = loginRequestFromJson(_storage.authModel);
      String username = _fields.email.value.trim();
      if (username != request.username) {
        return AppUtils.showError('auth_account'.tr + request.username);
      }
    } else {
      request = LoginRequest(
        username: _fields.email.value.trim(),
        password: _fields.password.value,
        guid: _storage.deviceID,
        captcha: _fields.captcha.value.trim(),
      );
    }

    _storage.companyCode = company.value.trim();
    var result = await _loginService.login(request.toJson());
    if (result != null && result.errorCode == '${StatusCodes.ok}') {
      ///Set token.
      if (result.data == null) return;
      DateTime sessionTimeout =
          DateTime.now().add(Duration(seconds: result.data!.tokenTimeout));
      _storage.apiToken = result.data!.token;
      _storage.sessionTimeout = sessionTimeout.toString();
      _storage.loginType = AppConfigs.internal;
      _storage.authModel = request.toJson();

      ///Check first time login.
      bool resultProfile = await getProfile();
      if (!resultProfile) await handleErrorCallApi();
      if (isFirstLogin) {
        bool resultFirstLogin = await firstTimeLogin();
        if (!resultFirstLogin) await handleErrorCallApi();
      }

      ///check userExternal (role = 0 EXTERNAL GROUP) (role = 1 INTERNAL)
      if (role.isEmpty) _storage.loginType = AppConfigs.externalGroup;
      await saveFcmToken();
      await AppUtils.hideLoader();
      resetData();

      Get.offAllNamed(redirectHome());
    } else if (result != null && result.message.isNotEmpty) {
      if (result.data != null && result.data!.captcha.isNotEmpty) {
        showCaptcha.value = true;
        strCaptcha.value = result.data!.captcha;
      }
      AppUtils.showError(result.message);
    } else {
      debugPrint('error --> _login');
      AppUtils.showError('have_error_msg'.tr);
    }
  }

  Future<bool> getProfile() async {
    var result = await _loginService.getProfile();
    if (result != null && result.status == StatusCodes.ok) {
      if (result.data == null) return false;
      isFirstLogin = result.data!.isFirstLogin;
      role = result.data!.roles;
      _storage.userInfo = profileModelToJson(result);
      return true;
    } else if (result != null && result.error.isNotEmpty) {
      AppUtils.showError(result.error);
      return false;
    } else {
      AppUtils.showError('have_error_msg'.tr);
      debugPrint('error --> getProfile');
      return false;
    }
  }

  Future<bool> firstTimeLogin() async {
    var result = await _loginService.firstTimeLogin();
    if (result != null && result.status == StatusCodes.ok) {
      return true;
    } else if (result != null && result.message.isNotEmpty) {
      AppUtils.showError(result.message);
      return false;
    } else {
      AppUtils.showError('have_error_msg'.tr);
      debugPrint('error --> firstTimeLogin');
      return false;
    }
  }

  Future<void> saveFcmToken() async {
    // SaveFcmTokenRequest request = SaveFcmTokenRequest(
    //   guid: _storage.deviceID,
    //   fcmToken: _firebase.fcmToken,
    //   deviceType: AppUtils.getPlatForm(),
    // );
    //
    // var result = await _loginService.saveFcmToken(request.toJson());
    // AppUtils.showErrorApi(result, 'saveFcmToken');
  }

  Future<void> handleErrorCallApi() async {
    await AppUtils.hideLoader();
    _storage.apiToken = '';
    _storage.sessionTimeout = '';
    return;
  }

  void refreshCaptcha() async {
    AppUtils.showLoader();
    var result = await _loginService.refreshCaptcha();
    await AppUtils.hideLoader();

    if (result != null && result.status == StatusCodes.ok) {
      if (result.data == null) return;
      strCaptcha.value = result.data!.captcha;
    }

    AppUtils.showErrorApi(result, 'refreshCaptcha');
  }

  void resetData() {
    password.value = '';
    captcha.value = '';
    resetError();
  }

  void resetError() {
    email.error = '';
    password.error = '';
    captcha.error = '';
    company.error = '';
  }

  void showDropChangeLang() => showChangeLang.value = !showChangeLang.value;

  //Changed language to vietnamese.
  void onChangedVI() {
    resetError();
    logoLang = 'assets/icons/ic_lang_vn.png';
    langCode = 'VNI';
    lang.changeLang('vi', 'VN');
    onCloseDropLang();
  }

  //Changed language to english.
  void onChangeUS() {
    resetError();
    logoLang = 'assets/icons/ic_lang_en.png';
    langCode = 'EN';
    lang.changeLang('en', 'US');
    onCloseDropLang();
  }

  void onCloseDropLang() => showChangeLang.value = false;

  void loginExternal() {
    Get.offNamed(Routes.loginOutSide);
  }

  void showSheetForgotPass() {
    emailForgotPass.error = '';
    Get.bottomSheet(const SheetForgotPassWidget());
  }

  void onForgotPassword() async {
    if (emailForgotPass.validate()) {
      Get.focusScope!.unfocus();
      await _forgotPassword();
    }
  }

  Future<void> _forgotPassword() async {
    AppUtils.showLoader();
    ForgotPasswordRequest request = ForgotPasswordRequest(
      email: emailForgotPass.value.trim(),
    );
    var result = await _loginService.forgotPassword(request.toJson());
    await AppUtils.hideLoader();

    if (result != null && result.status == StatusCodes.ok) {
      AppUtils.showSuccess(result.message);
      emailForgotPass.value = '';
      AppUtils.closeSnackBar();
    }

    AppUtils.showMessApi(result, '_forgotPassword');
  }

  void initDataLogin() {
    //Init language.
    final langStore = _storage.language;
    if (langStore.contains('en')) {
      logoLang = 'assets/icons/ic_lang_en.png';
      langCode = 'EN';
    }

    //Init company.
    final valCompany = _storage.companyCode;
    if (valCompany.isNotEmpty) company.value = valCompany;

    //Init field username.
    if (_storage.authModel.isNotEmpty &&
        _storage.loginType != AppConfigs.externalPersonal) {
      LoginRequest request = loginRequestFromJson(_storage.authModel);
      email.value = request.username;
    }
  }

  String redirectHome() {
    // if (typeLogin == AppConfigs.loginEContract) return RoutesEContract.root;
    // if (typeLogin == AppConfigs.loginESignature) return RoutesESignature.root;
     return '/login';
  }

  @override
  void onInit() async {
    super.onInit();
    initDataLogin();
    await _getAvailableBiometrics();
  }

  @override
  void onReady() {
    super.onReady();
    if (_storage.sessionTimeout.isNotEmpty) Get.offAllNamed(redirectHome());
  }
}
