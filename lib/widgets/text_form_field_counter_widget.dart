import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/const/import_const.dart';

class TextFormFieldCounterWidget extends StatelessWidget {
  const TextFormFieldCounterWidget({
    Key? key,
    this.hint = '',
    this.isRequired = false,
    this.isSearch = false,
    required this.controller,
    this.maxLength = 100,
    this.inputType = TextInputType.text,
  }) : super(key: key);

  final String hint;
  final bool isRequired, isSearch;
  final TextEditingController controller;
  final int maxLength;
  final TextInputType inputType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLength: maxLength,
      //validator: (isRequired) ? FormValidations.validEmpty : null,
      keyboardType: inputType,
      autocorrect: false,
      enableSuggestions: false,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: Styles.normalText(color: Styles.grey8),
        counterStyle: Styles.normalText(color: Styles.grey3, size: 12),
        errorStyle: const TextStyle(fontSize: 10),
        suffixIcon: (isSearch)
            ? const Icon(CupertinoIcons.search, color: Styles.grey3)
            : null,
        // border: Styles.outlineInputEnabledBorder(radius: 8),
        // enabledBorder: Styles.outlineInputEnabledBorder(radius: 8),
        // errorBorder: Styles.outlineInputErrorBorder(radius: 8),
        // focusedErrorBorder: Styles.outlineInputErrorBorder(radius: 8),
        // focusedBorder: Styles.outlineInputFocusedBorder(radius: 8),
        contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      ),
    );
  }
}
