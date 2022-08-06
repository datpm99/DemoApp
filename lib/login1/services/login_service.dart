import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/captcha_model.dart';
import '../models/login_model.dart';
import '../models/profile_model.dart';
import '/const/import_const.dart';
import '/services/api/login_api.dart';

import '/core_models/response_model.dart';

class LoginService extends BaseApiService {
  final _service = Get.find<CommonService>();
  final storageService = Get.find<StorageService>();

  Future<LoginModel?> login(String request) async {
    try {
      var response = await _service.postRequest(
        LoginApi.login,
        request,
        '',
        AppConfigs.apiCommon,
      );

      if (response != null && response.statusCode != 500) {
        var data = getDataFromResponse(response);
        return loginModelFromJson(data);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<CaptchaModel?> refreshCaptcha() async {
    try {
      var response = await _service.getRequest(
        LoginApi.refreshCaptcha + storageService.deviceID,
        '',
        AppConfigs.apiCommon,
      );
      if (response != null && response.statusCode != 500) {
        var data = getDataFromResponse(response);
        return captchaModelFromJson(data);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<ProfileModel?> getProfile() async {
    try {
      var response = await _service.getRequest(
        LoginApi.getProfile,
        storageService.apiToken,
        AppConfigs.apiCore,
      );

      if (response != null && response.statusCode != 500) {
        var data = getDataFromResponse(response);
        return profileModelFromJson(data);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<ResponseModel?> firstTimeLogin() async {
    try {
      var response = await _service.postRequest(
        LoginApi.firstTimeLogin,
        '',
        storageService.apiToken,
        AppConfigs.apiCore,
      );

      if (response != null && response.statusCode != 500) {
        var data = getDataFromResponse(response);
        return responseModelFromJson(data);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<ResponseModel?> saveFcmToken(String request) async {
    try {
      var response = await _service.postRequest(
        LoginApi.saveFcmToken,
        request,
        storageService.apiToken,
        AppConfigs.apiCore,
      );

      if (response != null && response.statusCode != 500) {
        var data = getDataFromResponse(response);
        return responseModelFromJson(data);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<ResponseModel?> forgotPassword(String request) async {
    try {
      var response = await _service.postRequest(
        LoginApi.forgetPassword,
        request,
        '',
        AppConfigs.apiCore,
      );

      if (response != null && response.statusCode != 500) {
        var data = getDataFromResponse(response);
        return responseModelFromJson(data);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
