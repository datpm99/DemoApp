import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExitDialog extends StatelessWidget {
  const ExitDialog({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title.tr),
      backgroundColor: Colors.white,
      actions: [
        TextButton(
          onPressed: () => Get.back(result: false),
          child: Text('cancel'.tr),
        ),
        //
        TextButton(
          onPressed: () => Get.back(result: true),
          child: Text('yes'.tr),
        ),
      ],
    );
  }
}
