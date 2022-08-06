import 'package:flutter/material.dart';
import '/utils/app_validation.dart';
import '/const/theme/styles.dart';
import '/const/app_configs.dart';
import '/widgets/get_input_text.dart';

class LoginFields {
  GetInputTextConfig company = GetInputTextConfig(
    hint: 'company',
    maxLength: AppConfigs.maxLength255,
    onValidate: AppValidation.company,
    keyboardType: TextInputType.emailAddress,
    validationPlace: ValidationPlace.focus,
    textInputAction: TextInputAction.next,
    enabledBorder: Styles.inputBorder30(),
    focusedBorder: Styles.inputBorder30(color: Styles.primaryColor),
    errorBorder: Styles.inputBorder30(color: Colors.red),
    focusedErrorBorder: Styles.inputBorder30(color: Colors.red),
  );

  GetInputTextConfig email = GetInputTextConfig(
    hint: 'enter_userName',
    maxLength: AppConfigs.maxLength255,
    onValidate: AppValidation.username,
    keyboardType: TextInputType.emailAddress,
    validationPlace: ValidationPlace.focus,
    textInputAction: TextInputAction.next,
    enabledBorder: Styles.inputBorder30(),
    focusedBorder: Styles.inputBorder30(color: Styles.primaryColor),
    errorBorder: Styles.inputBorder30(color: Colors.red),
    focusedErrorBorder: Styles.inputBorder30(color: Colors.red),
  );

  GetInputTextConfig password = GetInputTextConfig(
    hint: 'enter_password',
    maxLength: AppConfigs.maxLength50,
    isPassword: true,
    onValidate: AppValidation.password,
    keyboardType: TextInputType.visiblePassword,
    validationPlace: ValidationPlace.focus,
    textInputAction: TextInputAction.done,
    enabledBorder: Styles.inputBorder30(),
    focusedBorder: Styles.inputBorder30(color: Styles.primaryColor),
    errorBorder: Styles.inputBorder30(color: Colors.red),
    focusedErrorBorder: Styles.inputBorder30(color: Colors.red),
  );

  GetInputTextConfig captcha = GetInputTextConfig(
    hint: 'enter_captcha',
    maxLength: AppConfigs.maxLength5,
    onValidate: AppValidation.captcha,
    keyboardType: TextInputType.text,
    validationPlace: ValidationPlace.focus,
    textInputAction: TextInputAction.done,
    enabledBorder: Styles.inputBorder30(),
    focusedBorder: Styles.inputBorder30(color: Styles.primaryColor),
    errorBorder: Styles.inputBorder30(color: Colors.red),
    focusedErrorBorder: Styles.inputBorder30(color: Colors.red),
  );

  GetInputTextConfig emailForgotPass = GetInputTextConfig(
    hint: 'enter_email_forgot_pass',
    maxLength: AppConfigs.maxLength255,
    onValidate: AppValidation.email,
    keyboardType: TextInputType.emailAddress,
    validationPlace: ValidationPlace.focus,
    textInputAction: TextInputAction.send,
    enabledBorder: Styles.inputBorder30(),
    focusedBorder: Styles.inputBorder30(color: Styles.primaryColor),
    errorBorder: Styles.inputBorder30(color: Colors.red),
    focusedErrorBorder: Styles.inputBorder30(color: Colors.red),
  );
}
