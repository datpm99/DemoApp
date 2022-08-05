import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/instance_manager.dart';
import 'package:http_parser/http_parser.dart';
import '../../const/app_configs.dart';
import '../../utils/app_utils.dart';
import '/services/storage/storage_service.dart';

const domainPublic = 'https://service.mdo.com.vn';
//const domainPublic = 'https://mdo-staging.bssd.vn';
//const domainPublic = 'https://vpswebdev.bssd.vn';

//URL
const urlCommon = '$domainPublic/api/common/';
const urlCore = '$domainPublic/api/core/';
const urlBasic = '$domainPublic/api/';
final _store = Get.find<StorageService>();

class CommonService {
  late Dio dio;

  interceptors() async {
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      if (validateSessionTimeout(options.path)) {
        return handler.next(options);
      }
      //continue
    }, onResponse: (response, handler) async {
      if (!kReleaseMode) {
        debugPrint('=================================================\n');
        debugPrint('METHOD: ${response.requestOptions.method}');
        debugPrint('REQUEST: ${response.requestOptions.uri}');
        debugPrint('PARAMS: ${response.requestOptions.data}');
        debugPrint('HEADER: ${response.requestOptions.headers}');
        debugPrint('RESPONSE: ${jsonEncode(response.data)}');
        debugPrint('=================================================\n');
      }

      return handler.next(response); // continue
    }, onError: (DioError e, handler) {
      debugPrint('=================================================\n');
      debugPrint('ERROR: ${e.message}');
      debugPrint('=================================================\n');
      return handler.next(e); //continue
    }));
  }

  validateSessionTimeout(String path) {
    bool isAuth = path.contains('generateCaptcha') ||
        path.contains('login') ||
        path.contains('forget-password') ||
        path.contains('renew-verification-code') ||
        path.contains('loginByEmailAndCode');
    if (!isAuth) {
      bool isValidateSessionTimeout = AppUtils.validateSessionTimeout();
      if (!isValidateSessionTimeout) {
        AppUtils.logout();
        AppUtils.showError('msg_session_timeout'.tr);
        return false;
      }
    }

    return true;
  }

  Future<void> init() async {
    dio = Dio(BaseOptions(
        baseUrl: urlBasic,
        headers: {
          'content-type': 'application/json',
        },
        connectTimeout: 120 * 1000, // 120 seconds
        receiveTimeout: 120 * 1000 // 120 seconds
        ));
    await interceptors();
  }

  void settingDio(String apiToken, int type) {
    if (apiToken.isNotEmpty) {
      dio.options.headers['Authorization'] = 'Bearer $apiToken';
    }
    dio.options.headers['domain'] = _store.companyCode;
    dio.options.responseType = ResponseType.json;

    //Check lang code.
    String localeCode = _store.language.split('_')[0];
    dio.options.headers['Accept-Language'] = localeCode;

    //Check url.
    if (type == AppConfigs.apiCore) dio.options.baseUrl = urlCore;
    if (type == AppConfigs.apiBase) dio.options.baseUrl = urlBasic;
    if (type == AppConfigs.apiCommon) dio.options.baseUrl = urlCommon;
  }

  Future<Response?> getRequest(String url, String apiToken, int type,
      {var data}) async {
    try {
      settingDio(apiToken, type);
      if (data != null) return await dio.get(url, queryParameters: data);

      return await dio.get(url);
    } on DioError catch (e) {
      if (e.response != null) return e.response;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<Response?> getFileRequest(String url, String apiToken, int type,
      {var data}) async {
    try {
      settingDio(apiToken, type);
      dio.options.responseType = ResponseType.bytes;

      if (data != null) return await dio.get(url, queryParameters: data);

      return await dio.get(url);
    } on DioError catch (e) {
      if (e.response != null) return e.response;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<Response?> postRequest(
      String url, String data, String apiToken, int type) async {
    try {
      settingDio(apiToken, type);
      return await dio.post(url, data: data);
    } on DioError catch (e) {
      if (e.response != null) return e.response;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<Response?> putRequest(
      String url, String data, String apiToken, int type) async {
    try {
      settingDio(apiToken, type);
      return await dio.put(url, data: data);
    } on DioError catch (e) {
      if (e.response != null) return e.response;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<Response?> uploadFile(
      File file, String url, String apiToken, String fileType, int type) async {
    try {
      String fileName = file.path.split('/').last;
      settingDio(apiToken, type);

      final parFile = await MultipartFile.fromFile(
        file.path,
        filename: fileName,
        contentType: MediaType('image', 'png'),
      );
      FormData formData = FormData.fromMap({
        "file": parFile,
        "fileType": fileType,
      });
      return await dio.post(url, data: formData);
    } on DioError catch (e) {
      if (e.response != null) return e.response;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
