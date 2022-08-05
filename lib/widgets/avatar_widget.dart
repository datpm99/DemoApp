import 'package:flutter/material.dart';
import '/const/theme/styles.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({
    Key? key,
    this.size = 40,
    this.name = '',
  }) : super(key: key);
  final double size;
  final String name;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircleAvatar(
        backgroundColor: Styles.primaryColor,
        child: Text(
          name,
          style: Styles.bigText(color: Colors.white),
        ),
      ),
    );
  }
}
