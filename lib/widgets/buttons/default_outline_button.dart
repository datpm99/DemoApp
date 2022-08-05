import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/const/theme/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultOutlineButton extends StatelessWidget {
  const DefaultOutlineButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.color = Styles.primaryColor,
    this.colorText = Styles.primaryColor,
    this.width = 150,
    this.height = 48,
  }) : super(key: key);
  final String text;
  final VoidCallback onTap;
  final Color color, colorText;
  final double width, height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.w,
      height: height.h,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          primary: color,
          shape: Styles.borderDialog(radius: 30),
          side: BorderSide(width: 1, color: colorText),
          backgroundColor: Colors.white,
          elevation: 2,
        ),
        onPressed: onTap,
        child: Text(
          text.tr.toUpperCase(),
          style: Styles.normalTextBold(color: colorText),
        ),
      ),
    );
  }
}
