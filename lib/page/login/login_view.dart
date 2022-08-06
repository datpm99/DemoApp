
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:get/get.dart';

import '../../const/import_const.dart';



class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Colors.red,
      child: AutoSizeText(
        'login'.tr,
        style: Styles.smallText(color: Colors.red),
        maxLines: 2,
      ),
    );
  }
}
