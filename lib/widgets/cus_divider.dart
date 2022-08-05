import 'package:flutter/material.dart';
import '/const/theme/styles.dart';

class CusDivider extends StatelessWidget {
  const CusDivider({
    Key? key,
    this.color = Styles.white7,
    this.height = 1.0,
    this.padding = 8.0,
  }) : super(key: key);
  final Color color;
  final double height, padding;

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      color: color,
      thickness: height,
      endIndent: padding,
      indent: padding,
    );
  }
}
