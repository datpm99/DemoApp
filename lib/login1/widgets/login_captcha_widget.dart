import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';

import '/widgets/get_input_text.dart';
import '/const/import_const.dart';
import '../login_controller.dart';

class LoginCaptchaWidget extends GetView<LoginController> {
  const LoginCaptchaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GetInputText(config: controller.captcha).expand(),
        SizedBox(width: 10.w),
        Obx(() {
          return Container(
            width: 130,
            height: 48,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Image.memory(
              const Base64Decoder().convert(controller.strCaptcha.value),
            ),
          );
        }),
        InkWell(
          onTap: controller.refreshCaptcha,
          child: Icon(Icons.cached, color: Styles.grey10, size: 28.w),
        ).pOnly(top: 10, left: 10),
      ],
    );
  }
}
