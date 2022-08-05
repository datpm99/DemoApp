import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/const/theme/styles.dart';

class IconBackButton extends StatelessWidget {
  const IconBackButton({
    Key? key,
    this.color = Styles.grey11,
  }) : super(key: key);
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.back(),
      child: Icon(Icons.arrow_back_ios, color: color),
    );
  }
}
