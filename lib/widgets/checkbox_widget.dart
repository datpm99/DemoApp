import 'package:flutter/material.dart';
import '/const/import_const.dart';

class CheckBoxWidget extends StatelessWidget {
  const CheckBoxWidget({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final bool value;
  final Function(bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        unselectedWidgetColor: Styles.grey5,
      ),
      child: Checkbox(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
        activeColor: Styles.blue7,
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
