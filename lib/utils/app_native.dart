import 'package:device_info_plus/device_info_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:get/get.dart';
import '/const/app_configs.dart';

class AppNative {
  static Future<String> deviceName() async {
    final deviceInfo = DeviceInfoPlugin();
    String appVersion = AppConfigs.appName + '-' + AppConfigs.appVersion;

    if (GetPlatform.isIOS) {
      var deviceData = await deviceInfo.iosInfo;
      return '${deviceData.model}|${deviceData.name}|${deviceData.systemVersion}|$appVersion|${deviceData.identifierForVendor}';
    }

    if (GetPlatform.isAndroid) {
      var deviceData = await deviceInfo.androidInfo;
      return '${deviceData.manufacturer}|${deviceData.model}|$appVersion|${deviceData.androidId}';
    }

    return '';
  }

  static Future<void> makePhoneCall(String number) async {
    if (await canLaunchUrlString('tel:$number')) {
      await launchUrlString('tel:$number');
    } else {
      throw 'Could not launch tel:$number';
    }
  }

  static Future<void> sendSms(String number) async {
    if (await canLaunchUrlString('sms:$number')) {
      await launchUrlString('sms:$number');
    } else {
      throw 'Could not launch sms:$number';
    }
  }

  static Future<void> sendEmail(String email) async {
    if (await canLaunchUrlString('mailto:$email')) {
      await launchUrlString('mailto:$email');
    } else {
      throw 'Could not launch mailto:$email';
    }
  }
}
