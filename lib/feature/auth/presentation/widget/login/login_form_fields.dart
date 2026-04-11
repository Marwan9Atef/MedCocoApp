import 'package:flutter/material.dart';
import 'package:valo/core/generated/assets.dart';
import 'package:valo/core/theme/app_style.dart';
import 'package:valo/core/utils/validator.dart';
import 'package:valo/core/widget/custom_text_form_filed.dart';

class LoginFormFields extends StatelessWidget {
  const LoginFormFields({
    super.key,
    this.onEmailSaved,
    this.onPasswordSaved,
  });

  final void Function(String?)? onEmailSaved;
  final void Function(String?)? onPasswordSaved;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Email Address",style: AppStyles.styleRegular14(context),),
                        const SizedBox(height: 8),
                        CustomTextFormField(
                          textInputType: TextInputType.emailAddress,
                          hintText: "Email Address",
                          prefixIconPath: AppAssets.email,
                          autofillHints: const [AutofillHints.email],
                          validator: (value) => Validator.validateField(value, 'login email'),
                          onSaved: onEmailSaved,
                        ),
                        const SizedBox(height: 20),
                        Text("Password",style: AppStyles.styleRegular14(context),),
                        const SizedBox(height: 8),
                        CustomTextFormField(
                          textInputType: TextInputType.visiblePassword,
                          hintText: "Password",
                          isPassword: true,
                          prefixIconPath: AppAssets.password,
                          autofillHints: const [AutofillHints.password],
                          validator: (value) => Validator.validateField(value, 'login password'),
                          onSaved: onPasswordSaved,
                        ),
      ],
    );
  }
}