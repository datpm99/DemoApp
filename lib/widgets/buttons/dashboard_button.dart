import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/const/theme/styles.dart';

class DashboardButton extends StatelessWidget {
  const DashboardButton({
    Key? key,
    required this.text,
    required this.date,
    required this.onTap,
    this.color = Styles.purple1,
    this.width = 150,
    this.height = 48,
  }) : super(key: key);
  final String text;
  final int date;
  final VoidCallback onTap;
  final Color color;
  final double width, height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.w,
      height: height.h,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          primary: color,
          shape: Styles.borderDialog(radius: 30),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AutoSizeText(
              text.tr.toUpperCase(),
              style: Styles.normalTextBold(color: Colors.white),
              maxLines: 1,
              minFontSize: 10,
              overflow: TextOverflow.ellipsis,
            ),
            Visibility(
              visible: (date != 0),
              child: AutoSizeText(
                '($date ' + 'day'.tr.toUpperCase() + ')',
                style: Styles.normalTextBold(color: Colors.white, size: 11),
                maxLines: 1,
                minFontSize: 8,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
