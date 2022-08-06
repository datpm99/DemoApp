import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/const/theme/styles.dart';

class TextSwitchLogin extends StatelessWidget {
  const TextSwitchLogin({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Text(
            text.tr.toUpperCase(),
            style: Styles.normalTextBold(color: Styles.blue7),
          ),
        ),
      ],
    );
  }
}
