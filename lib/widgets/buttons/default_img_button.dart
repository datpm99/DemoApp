import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/const/theme/styles.dart';

class DefaultImgButton extends StatelessWidget {
  const DefaultImgButton({
    Key? key,
    this.width = 166,
    this.height = 40,
    required this.onTap,
    required this.img,
    required this.text,  }) : super(key: key);
  final double width, height;

  final VoidCallback onTap;
  final String img, text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.w,
      height: height.h,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          primary: Styles.blue7,
          shape: Styles.borderDialog(radius: 30),
        ),
        child: Row(
          children: [
            Image.asset(img, width: 24, height: 24),
            SizedBox(width: 10.w),
            Flexible(
              child: AutoSizeText(
                text.tr.toUpperCase(),
                style: Styles.normalTextBold(color: Colors.white),
                maxLines: 1,
                minFontSize: 10,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
