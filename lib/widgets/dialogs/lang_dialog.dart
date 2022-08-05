import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/widgets/buttons/default_button.dart';
import '/const/theme/styles.dart';
import 'package:velocity_x/velocity_x.dart';

class LangDialog extends StatelessWidget {
  const LangDialog({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);
  final RxString value;
  final Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: Styles.borderDialog(),
      child: Theme(
        data: Theme.of(context).copyWith(
          unselectedWidgetColor: Styles.black2,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //Title.
            Text('select_lang'.tr, style: Styles.normalTextBold())
                .pOnly(bottom: 20.h),

            //Lang vi.
            Obx(() {
              return RadioListTile(
                value: 'vi',
                activeColor: Styles.black2,
                groupValue: value.value,
                onChanged: onChanged,
                title: Row(
                  children: [
                    Image.asset('assets/icons/ic_flag_vn.png',
                        width: 36.w, height: 24.h),
                    SizedBox(width: 20.w),
                    Text('lang_vi'.tr, style: Styles.smallTextBold()),
                  ],
                ),
              );
            }),

            //Lang en.
            Obx(() {
              return RadioListTile(
                value: 'en',
                activeColor: Styles.black2,
                groupValue: value.value,
                onChanged: onChanged,
                title: Row(
                  children: [
                    Image.asset('assets/icons/ic_flag_us.png',
                        width: 36.w, height: 24.h),
                    SizedBox(width: 20.w),
                    Text('lang_us'.tr, style: Styles.smallTextBold()),
                  ],
                ),
              );
            }),

            //Button close.
            DefaultButton(
              color: Styles.blue7,
              height: 40,
              width: 130,
              onTap: () => Get.back(),
              text: 'close',
            ).pOnly(top: 20.h),
          ],
        ).p(15),
      ),
    );
  }
}
