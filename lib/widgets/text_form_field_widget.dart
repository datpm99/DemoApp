import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/const/import_const.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    Key? key,
    this.hint = '',
    this.isRequired = false,
    required this.controller,
    this.maxLength = 100,
    this.inputType = TextInputType.text,
    required this.onTap,
    this.readOnly = false,
    this.inputFormatters = const [],
  }) : super(key: key);

  final String hint;
  final bool isRequired, readOnly;
  final TextEditingController controller;
  final int maxLength;
  final TextInputType inputType;
  final Function(String?) onTap;
  final List<TextInputFormatter> inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onTap,
      controller: controller,
      maxLength: maxLength,
     // validator: (isRequired) ? FormValidations.validEmpty : null,
      keyboardType: inputType,
      autocorrect: false,
      enableSuggestions: false,
      readOnly: readOnly,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: Styles.normalText(color: Styles.grey8),
        counterStyle: Styles.normalText(color: Styles.grey3, size: 12),
        errorStyle: const TextStyle(fontSize: 10),
        counterText: '',
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
