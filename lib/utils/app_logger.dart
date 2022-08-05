import 'package:flutter/material.dart';

class AppLog {
  late String prefix;

  AppLog(String classname) {
    prefix = '[$classname]';
  }

  void call(params) {
    debugPrint(prefix + ' $params');
  }
}
