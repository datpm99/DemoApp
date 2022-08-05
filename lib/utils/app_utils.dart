import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import '/widgets/images/cus_image_icon.dart';
import '/widgets/loaders.dart';
import '/const/import_const.dart';
import '/lang/lang_controller.dart';
import '/routes/routes.dart';

class AppUtils {
  static bool isLoading = false;
  static LangController lang = Get.find<LangController>();

  static Future<void> hideLoader() async {
    if (!isLoading) return;
    isLoading = false;

    if (!Get.isSnackbarOpen) Get.back();
  }

  static Future<void> showLoader() async {
    if (isLoading) return;
    isLoading = true;

    Get.dialog(
      const Center(child: LoaderCircular()),
      barrierDismissible: false,
    );
  }

  static void showError(String message) {
    if (isLoading && Get.isDialogOpen!) hideLoader();

    Get.snackbar(
      'error'.tr,
      message,
      borderRadius: 0,
      colorText: Colors.white,
      backgroundColor: Styles.red1,
      animationDuration: 0.45.seconds,
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      reverseAnimationCurve: Curves.easeOutExpo,
      overlayColor: Colors.black26,
      overlayBlur: .1,
      margin: const EdgeInsets.symmetric(vertical: 0),
      snackStyle: SnackStyle.FLOATING,
      snackPosition: SnackPosition.BOTTOM,
      padding: EdgeInsets.zero,
      messageText: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CusImageIcon(asset: 'assets/icons/ic_alert_error.png'),
              const SizedBox(width: 10),
              Text(message, style: Styles.normalTextSemi()).expand()
            ],
          ).pSymmetric(h: 22, v: 19),
          Container(height: 3, color: Styles.red2)
        ],
      ),
      titleText: const SizedBox.shrink(),
    );
  }

  static void showSuccess(String message) {
    if (isLoading && Get.isDialogOpen!) hideLoader();

    Get.snackbar(
      'success'.tr,
      message,
      borderRadius: 0,
      colorText: Styles.black1,
      backgroundColor: Styles.green1,
      animationDuration: 0.45.seconds,
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      reverseAnimationCurve: Curves.easeOutExpo,
      overlayColor: Colors.black26,
      overlayBlur: .1,
      margin: const EdgeInsets.symmetric(vertical: 0),
      snackStyle: SnackStyle.FLOATING,
      snackPosition: SnackPosition.BOTTOM,
      padding: EdgeInsets.zero,
      messageText: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CusImageIcon(asset: 'assets/icons/ic_alert_success.png'),
              const SizedBox(width: 10),
              Text(message, style: Styles.normalTextSemi()).expand(),
            ],
          ).pSymmetric(h: 22, v: 19),
          Container(height: 3, color: Styles.green2)
        ],
      ),
      titleText: const SizedBox.shrink(),
    );
  }

  static bool validateSessionTimeout() {
    final _storage = Get.find<StorageService>();
    String sessionTimeout = _storage.sessionTimeout;
    DateTime now = DateTime.now();
    if (sessionTimeout.isEmpty) return false;

    //Check current time <= timeout return false
    DateTime? sessionTimeParse = DateTime.tryParse(sessionTimeout);
    var diff = now.difference(sessionTimeParse!).inMinutes;
    if (diff >= 0) {
      _storage.sessionTimeout = '';
      return false;
    }

    //Update sessionTimeout.
    // _storage.sessionTimeout = now.add(const Duration(minutes: 30)).toString();
    return true;
  }

  static void logout() async {
    final _storage = Get.find<StorageService>();
    String routesLogout = Routes.login;
    if (_storage.loginType == AppConfigs.externalPersonal) {
      routesLogout = Routes.loginOutSide;
    }
    _storage.sessionTimeout = '';
    _storage.apiToken = '';
    _storage.userInfo = '';
    Get.offAllNamed(routesLogout);
  }

  static Future<DateTime?> datePicker(BuildContext context,
      {required DateTime initDate, required String errorFormatText}) async {
    final DateTime? picked = await showDatePicker(
      locale: lang.locale,
      context: context,
      initialDate: initDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365 * 10)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
      errorFormatText: errorFormatText,
    );
    return picked;
  }

  ///Format date.
  static String formatDate1(String val) {
    if (val.isEmpty) return '';
    final dateFormat = DateFormat("dd/MM/yyyy HH:mm:ss");
    final dateTime = dateFormat.parse(val);
    return dateFormat.format(dateTime);
  }

  static String formatDate2(DateTime date) {
    return DateFormat("dd/MM/yyyy").format(date);
  }

  static String formatDate3(DateTime date) {
    return DateFormat("ddMMyyyy").format(date);
  }

  static String formatDate4(DateTime date) {
    return DateFormat("HH:mm dd/MM/yyyy").format(date);
  }

  static String formatDate5(String val) {
    if (val.isEmpty) return '';
    final dateFormat = DateFormat("dd/MM/yyyy HH:mm:ss");
    final date = dateFormat.parse(val);
    return '${date.hour}:${date.minute} ${date.day}/${date.month}/${date.year}';
  }

  ///Write file.
  static Future<File> writeToFile(var data) async {
    Directory tempDir = await getTemporaryDirectory();
    var filePath = tempDir.path + '/file_01.png';
    return File(filePath).writeAsBytes(data);
  }

  static Future<String> writeToFilePdf(Uint8List dataPdf, int id) async {
    Directory tempDir = await getTemporaryDirectory();
    var filePath = tempDir.path + '/file_$id.pdf';
    File filePdf = await File(filePath).writeAsBytes(dataPdf);
    return filePdf.path;
  }

  static bool checkFormatImage(String path) {
    String image = path.split('.').last;
    return (image == 'png' || image == 'jpg');
  }

  static String replaceNullString(String val) {
    return val.replaceAll("null", " ");
  }

  static Future<void> closeSnackBar() async {
    await 2.5.delay();
    Get.back();
  }

  static String getFirstCharacter(String name) {
    if (name.isEmpty) return '';
    String lastWord = name.substring(name.lastIndexOf(" ") + 1);
    return lastWord[0].toUpperCase();
  }

  static String getPlatForm() {
    if (GetPlatform.isAndroid) return 'ANDROID';
    if (GetPlatform.isIOS) return 'IOS';
    return 'WEB';
  }

  static Color getColorBySignUserType(type) {
    if (type == AppConfigs.reviewer) return Styles.blue7;
    return Styles.purple1;
  }

  static Color getColorByDocState(docState) {
    if (docState == AppConfigs.inProgress) return Styles.yellow;
    if (docState == AppConfigs.reject) return Styles.red2;
    if (docState == AppConfigs.complete) return Styles.blue7;
    if (docState == AppConfigs.cancel) return Styles.pink;
    if (docState == AppConfigs.draft) return Styles.purple3;
    if (docState == AppConfigs.promulgate) return Styles.purple3;
    if (docState == AppConfigs.promulgateCancel) return Styles.red2;
    return Styles.primaryColor;
  }

  ///Format count doc (100 => 99+).
  static String formatCountDoc(int val) {
    if (val < 100) return '$val';
    return '99+';
  }

  static String getImgByFile(String fileName) {
    String formatFile = fileName.split('.').last;

    if (formatFile == AppConfigs.typeDOCX) return 'assets/icons/ic_doc.png';

    if (formatFile == AppConfigs.typeXLSX) return 'assets/icons/ic_excel.png';

    return 'assets/icons/ic_pdf.png';
  }

  static Color getColorBgPendingItem(String signUserType) {
    if (signUserType == AppConfigs.reviewer) return Colors.white;
    return Styles.white5;
  }

  static String getTextContact(String email, String phone) {
    if (email.isEmpty) return phone;
    if (phone.isEmpty) return email;
    return '$email - $phone';
  }

  ///Get text btn change MAIN, REVIEW.
  static String getTextBtnChange(String text) {
    if (text == AppConfigs.changeMain) return 'continue';
    if (text == AppConfigs.changeReview) return 'continue';
    return 'yes';
  }

  static String shortNameFile(String text) {
    if (text.isEmpty) return '';
    if (!text.contains('-')) return text;
    if (text.length <= 15) return text;
    return text.substring(0, 15) + ' ...';
  }

  static String shortNameFile2(String text) {
    if (text.isEmpty) return '';
    if (!text.contains('-')) return text;
    if (text.length <= 7) return text;
    return text.substring(0, 7) + ' ...';
  }

  ///Error api.
  static void showErrorApi(var result, String nameFunc) {
    if (result != null && result.error.isNotEmpty) {
      AppUtils.showError(result.error);
      return;
    }

    if (result == null) {
      debugPrint('error-->$nameFunc');
      AppUtils.showError('have_error_msg'.tr);
    }
  }

  static void showMessApi(var result, String nameFunc) {
    if (result != null && result.message.isNotEmpty) {
      AppUtils.showError(result.message);
      return;
    }

    if (result == null) {
      debugPrint('error-->$nameFunc');
      AppUtils.showError('have_error_msg'.tr);
    }
  }

  ///Color selectBox.
  static Color getColorBgSelectedItem(int id, var item) {
    if (item.id == id) return Styles.blue8;
    return Colors.white;
  }

  static Color getColorTextSelectedItem(int id, var item) {
    if (item.id == id) return Styles.blue7;
    return Styles.black2;
  }
}
