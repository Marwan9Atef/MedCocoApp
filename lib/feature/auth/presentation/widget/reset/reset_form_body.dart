import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medcoco/core/generated/assets.dart';
import 'package:medcoco/core/routes/route_center.dart';
import 'package:medcoco/core/theme/app_style.dart';
import 'package:medcoco/core/utils/app_snack_bars.dart';
import 'package:medcoco/core/utils/validator.dart';
import 'package:medcoco/core/widget/custom_button.dart';
import 'package:medcoco/core/widget/custom_text_form_filed.dart';
import 'package:medcoco/feature/auth/data/models/confirm_reset_password_request_model.dart';
import 'package:medcoco/feature/auth/presentation/cubit/confirm_reset/confirm_reset_cubit.dart';
import 'package:medcoco/feature/auth/presentation/cubit/confirm_reset/confirm_reset_states.dart';
import '../../shared/auth_container.dart';
import '../code/code_form.dart';
import '../code/resend_button.dart';

class ResetFormBody extends StatelessWidget {
  const ResetFormBody({
    super.key,
    required this.email,
    required this.formKey,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.onOtpCompleted,
    required this.otpGetter,
  });

  final String email;
  final GlobalKey<FormState> formKey;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final ValueChanged<String> onOtpCompleted;
  final ValueGetter<String> otpGetter;

  @override
  Widget build(BuildContext context) {
    return AuthContainer(
      width: 0.35,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "Enter OTP",
              style: AppStyles.styleRegular14(context),
            ),
          ),
          const SizedBox(height: 20),
          CodeForm(onCompleted: onOtpCompleted),
          const SizedBox(height: 20),
          Text(
            "New Password",
            style: AppStyles.styleRegular14(context),
          ),
          const SizedBox(height: 8),
          CustomTextFormField(
            textInputType: TextInputType.visiblePassword,
            hintText: "Enter new password",
            prefixIconPath: AppAssets.password,
            isPassword: true,
            validator: (value) =>
                Validator.validateField(value, 'password'),
            controller: passwordController,
          ),
          const SizedBox(height: 20),
          Text(
            "Confirm Password",
            style: AppStyles.styleRegular14(context),
          ),
          const SizedBox(height: 8),
          CustomTextFormField(
            textInputType: TextInputType.visiblePassword,
            hintText: "Confirm new password",
            isPassword: true,
            prefixIconPath: AppAssets.password,
            validator: (value) => Validator.validateField(
              value,
              'confirmPassword',
              password: passwordController.text,
            ),
            controller: confirmPasswordController,
          ),
          const SizedBox(height: 20),
          BlocConsumer<ConfirmResetCubit, ConfirmResetStates>(
            listener: (context, state) {
              if (state is ConfirmResetSuccess) {
                AppSnackBars.showSuccessSnackBar(
                  context: context,
                  message: state.message,
                );
                Router.neglect(context, () => context.go(RouteCenter.login));
              } else if (state is ConfirmResetFailure) {
                AppSnackBars.showErrorSnackBar(
                  context: context,
                  message: state.error,
                );
              }
            },
            builder: (context, state) {
              return CustomButton(
                isLoading: state is ConfirmResetLoading,
                text: "Reset Password",
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    context.read<ConfirmResetCubit>().confirmResetPassword(
                      ConfirmResetPasswordRequest(
                        email: email,
                        otp: otpGetter(),
                        newPassword: passwordController.text,
                        confirmNewPassword: confirmPasswordController.text,
                      ),
                    );
                  }
                },
              );
            },
          ),
          const SizedBox(height: 20),
          Center(child: ResendButton(email: email)),
        ],
      ),
    );
  }
}
