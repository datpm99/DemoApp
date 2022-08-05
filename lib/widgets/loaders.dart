import 'package:flutter/material.dart';
import '/const/theme/styles.dart';

class LoaderCircular extends StatelessWidget {
  const LoaderCircular({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 64,
        height: 64,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: const CircularProgressIndicator(
          strokeWidth: 2,
          backgroundColor: Styles.white1,
        ),
      ),
    );
  }
}
