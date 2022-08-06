import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/const/import_const.dart';
import '../login_controller.dart';

class FingerPrint extends GetView<LoginController> {
  const FingerPrint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Visibility(
        visible: (controller.fingerprint.value || controller.face.value) &&
            controller.useFingerprint.value,
        child: InkWell(
          onTap: controller.isAuthenticating.value
              ? controller.cancelAuthentication
              : controller.authenticate,
          child: const Icon(Icons.fingerprint,
              color: Styles.primaryColor, size: 50),
        ),
      );
    });
  }
}
