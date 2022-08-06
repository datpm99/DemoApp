import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/widgets/get_input_text.dart';
import '/const/import_const.dart';
import '/widgets/buttons/default_button.dart';
import '../login_controller.dart';
import 'finger_print.dart';
import 'login_captcha_widget.dart';

class LoginForm extends GetView<LoginController> {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: controller.onCloseDropLang,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Company.
          Text(
            'company'.tr.toUpperCase(),
            style: Styles.smallTextBold(color: Styles.grey11),
          ).pOnly(bottom: 10.h),
          GetInputText(config: controller.company),

          //Username.
          Text(
            'username'.tr.toUpperCase(),
            style: Styles.smallTextBold(color: Styles.grey11),
          ).pOnly(bottom: 10.h, top: 5.h),
          GetInputText(config: controller.email),

          //Password.
          Text(
            'password'.tr.toUpperCase(),
            style: Styles.smallTextBold(color: Styles.grey11),
          ).pOnly(bottom: 10.h, top: 5.h),
          GetInputText(config: controller.password),

          //Captcha.
          Obx(() {
            return Visibility(
              visible: controller.showCaptcha.value,
              child: const LoginCaptchaWidget().pOnly(top: 10.h),
            );
          }),

          //Forgot password.
          Obx(() {
            return Row(
              children: [
                const FingerPrint(),
                const Spacer(),
                Visibility(
                  visible: !controller.showCaptcha.value,
                  child: GestureDetector(
                    onTap: controller.showSheetForgotPass,
                    child: Text(
                      'forgot_password'.tr,
                      style: Styles.normalTextBold(color: Styles.blue7),
                    ),
                  ),
                ),
              ],
            );
          }),

          //Button.
          SizedBox(height: 20.h),
          DefaultButton(
            color: Styles.blue7,
            width: Get.width,
            text: 'login',
            onTap: controller.onLogin,
          ),
        ],
      ),
    );
  }
}
