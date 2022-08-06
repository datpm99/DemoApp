import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/widgets/get_input_text.dart';
import '/widgets/buttons/default_button.dart';
import '../login_controller.dart';
import '/const/import_const.dart';

class SheetForgotPassWidget extends GetView<LoginController> {
  const SheetForgotPassWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Styles.boxDecorationSheet(),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            //Header.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 24),
                Text(
                  'forgot_password2'.tr.toUpperCase(),
                  style: Styles.bigTextW800(size: 16),
                ),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: const Icon(Icons.close, color: Styles.grey10),
                ),
              ],
            ).pSymmetric(h: 20, v: 18),

            //Email.
            Text(
              'Email'.tr.toUpperCase(),
              style: Styles.smallTextBold(color: Styles.grey11),
            ).pOnly(top: 18, bottom: 10, left: 30, right: 30),
            GetInputText(config: controller.emailForgotPass).pSymmetric(h: 30),

            //Button send
            DefaultButton(
              color: Styles.blue7,
              width: Get.width,
              text: 'pass_retrieval',
              onTap: controller.onForgotPassword,
            ).pSymmetric(h: 30, v: 30),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
