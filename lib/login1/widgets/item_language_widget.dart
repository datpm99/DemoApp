import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/widgets/images/cus_image_icon.dart';
import '/const/theme/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemLanguageWidget extends StatelessWidget {
  const ItemLanguageWidget({
    Key? key,
    required this.img,
    required this.text,
    required this.onTap,
  }) : super(key: key);
  final String img, text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150.w,
        color: Colors.transparent,
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            CusImageIcon(asset: img, border: 30),
            const SizedBox(width: 20),
            Text(text.tr, style: Styles.normalTextBold()),
          ],
        ),
      ),
    );
  }
}
