import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/const/import_const.dart';
import 'login_controller.dart';
import 'widgets/item_language_widget.dart';
import 'widgets/login_background_widget.dart';
import 'widgets/login_form.dart';
import 'widgets/text_switch_login.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  const LoginBackGroundWidget(),

                  //Title.
                  Text(
                    'login'.tr,
                    style:
                        Styles.normalTextBold(size: 24, color: Styles.black1),
                  ).pOnly(bottom: 10.h),

                  //Form Login.
                  const LoginForm().pSymmetric(h: 30.w, v: 20.h),

                  //Login External.
                  TextSwitchLogin(
                    text: 'login_external',
                    onTap: controller.loginExternal,
                  ),
                  SizedBox(height: 10.h)
                ],
              ),
            ),

            //Dropdown Language.
            Obx(() {
              return Visibility(
                visible: controller.showChangeLang.value,
                child: GestureDetector(
                  onTap: controller.onCloseDropLang,
                  child: Container(
                    width: Get.width,
                    height: Get.height,
                    color: Colors.transparent,
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 160,
                      margin: EdgeInsets.only(
                          top: (Get.height * 0.02) + 30.2, right: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: Styles.boxShadow1(),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ItemLanguageWidget(
                            img: 'assets/icons/ic_lang_vn.png',
                            text: 'lang_vi',
                            onTap: controller.onChangedVI,
                          ),
                          const Divider(height: 1),
                          ItemLanguageWidget(
                            img: 'assets/icons/ic_lang_en.png',
                            text: 'lang_us',
                            onTap: controller.onChangeUS,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

