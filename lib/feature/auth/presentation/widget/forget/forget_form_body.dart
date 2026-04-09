import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:valo/core/generated/assets.dart';
import 'package:valo/core/routes/route_center.dart';
import 'package:valo/core/theme/app_style.dart';
import 'package:valo/core/utils/app_snack_bars.dart';
import 'package:valo/core/utils/sizebox_util.dart';
import 'package:valo/core/utils/validator.dart';
import 'package:valo/core/widget/custom_button.dart';
import 'package:valo/core/widget/custom_text_form_filed.dart';
import 'package:valo/feature/auth/presentation/cubit/forget/forget_cubit.dart';
import 'package:valo/feature/auth/presentation/cubit/forget/forget_states.dart';
import '../../shared/auth_container.dart';

class ForgetFormBody extends StatelessWidget {
  const ForgetFormBody({
    super.key,
    required this.formKey,
    required this.onEmailSaved,
    required this.emailGetter,
  });

  final GlobalKey<FormState> formKey;
  final ValueChanged<String?> onEmailSaved;
  final ValueGetter<String?> emailGetter;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetCubit, ForgetStates>(
      listener: (context, state) {
        if (state is ForgetSuccess) {
          AppSnackBars.showSuccessSnackBar(
            context: context,
            message: state.message,
          );
          context.go(RouteCenter.reset, extra: emailGetter());
        } else if (state is ForgetFailure) {
          AppSnackBars.showErrorSnackBar(
            context: context,
            message: state.error,
          );
        }
      },
      builder: (context, state) {
        return AuthContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              CustomButton(
                isLoading: state is ForgetLoading,
                text: "Send OTP",
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    context.read<ForgetCubit>().forget(emailGetter()!);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
