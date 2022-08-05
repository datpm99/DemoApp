import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../buttons/default_img_button.dart';
import '/const/theme/styles.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SupportDialog extends StatelessWidget {
  const SupportDialog({
    Key? key,
    required this.onPhone,
    required this.onEmail,
  }) : super(key: key);
  final VoidCallback onPhone, onEmail;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: Styles.borderDialog(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () => Get.back(),
                child: const Icon(Icons.close, color: Styles.grey10).p8(),
              ),
            ],
          ),
          Text('support'.tr, style: Styles.normalTextBold())
              .pOnly(bottom: 35.h),

          //Phone.
          DefaultImgButton(
            onTap: onPhone,
            img: 'assets/icons/ic_phone_call.png',
            text: 'call_cskh',
          ).pOnly(bottom: 25.h),

          //Email.
          DefaultImgButton(
            onTap: onEmail,
            img: 'assets/icons/ic_email.png',
            text: 'send_email_cskh',
          ).pOnly(bottom: 35.h),
        ],
      ),
    );
  }
}
