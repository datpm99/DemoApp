import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../login_controller.dart';
import '/const/import_const.dart';
import '/widgets/logo_widget.dart';
import '/widgets/images/cus_image_icon.dart';

class LoginBackGroundWidget extends GetView<LoginController> {
  const LoginBackGroundWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //Image.
        Container(
          width: Get.width,
          height: Get.height * 0.17,
          color: Styles.blue6,
        ),
        Container(
          width: Get.width,
          height: Get.height * 0.25,
          alignment: Alignment.center,
          child: Image.asset(
            'assets/images/bg_login.png',
            height: Get.height * 0.25,
          ),
        ),

        //Icon logo app.
        Align(
          alignment: Alignment.topLeft,
          child: const LogoWidget()
              .pOnly(top: Get.height * 0.01, left: Get.height * 0.01),
        ),

        //Change Language.
        GetBuilder<LoginController>(
          builder: (c) {
            return Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: c.showDropChangeLang,
                child: Container(
                  height: 30,
                  width: 94,
                  margin: EdgeInsets.only(top: Get.height * 0.02, right: 6),
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: Styles.blue1,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CusImageIcon(asset: controller.logoLang, border: 30),
                      Text(controller.langCode, style: Styles.smallTextBold()),
                      const Icon(Icons.expand_more, color: Styles.black2)
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
