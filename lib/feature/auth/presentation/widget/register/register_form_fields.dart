import 'package:flutter/material.dart';
import 'package:valo/core/generated/assets.dart';
import 'package:valo/core/theme/app_style.dart';
import 'package:valo/core/utils/sizebox_util.dart';
import 'package:valo/core/utils/validator.dart';
import 'package:valo/core/widget/custom_text_form_filed.dart';

class RegisterFormFields extends StatelessWidget {
  const RegisterFormFields({
    super.key,
    this.onUsernameSaved,
    this.onEmailSaved,
    this.onPasswordSaved,
  });

  final void Function(String?)? onUsernameSaved;
  final void Function(String?)? onEmailSaved;
  final void Function(String?)? onPasswordSaved;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Full Name", style: AppStyles.styleRegular14(context)),
        8.hight,
        CustomTextFormField(
          textInputType: TextInputType.name,
          hintText: "Full name",
          prefixIconPath: AppAssets.profile,
          validator: (value) => Validator.validateField(value, 'name'),
          onSaved: onUsernameSaved,
        ),
        20.hight,
        Text("Email Address", style: AppStyles.styleRegular14(context)),
        8.hight,
        CustomTextFormField(
          textInputType: TextInputType.emailAddress,
          hintText: "Email Address",
          prefixIconPath: AppAssets.email,
          validator: (value) => Validator.validateField(value, 'email'),
          onSaved: onEmailSaved,
        ),
        20.hight,
        Text("Password", style: AppStyles.styleRegular14(context)),
        8.hight,
        CustomTextFormField(
          textInputType: TextInputType.visiblePassword,
          hintText: "Password",
          isPassword: true,
          prefixIconPath: AppAssets.password,
          validator: (value) => Validator.validateField(value, 'password'),
          onSaved: onPasswordSaved,
        ),
      ],
    );
  }
}
