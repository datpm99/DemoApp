import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import '/const/theme/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListEmptyWidget extends StatelessWidget {
  const ListEmptyWidget({
    Key? key,
    this.showDivider = true,
  }) : super(key: key);

  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: showDivider,
          child: const Divider(color: Styles.white8, height: 1),
        ),
        Text('list_empty'.tr, style: Styles.bigTextBold()).pSymmetric(v: 35.h),
        Image.asset('assets/images/no_data.png').expand()
      ],
    );
  }
}
