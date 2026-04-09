import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:valo/core/routes/route_center.dart';
import 'package:valo/core/utils/app_snack_bars.dart';
import 'package:valo/feature/auth/data/models/confirm_reset_password_request_model.dart';
import 'package:valo/feature/auth/presentation/cubit/confirm_reset/confirm_reset_cubit.dart';
import 'package:valo/feature/auth/presentation/cubit/confirm_reset/confirm_reset_states.dart';
import '../../../../core/generated/assets.dart';
import '../../../../core/theme/app_style.dart';
import '../../../../core/utils/context_util.dart';
import '../../../../core/utils/sizebox_util.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widget/custom_button.dart';
import '../../../../core/widget/custom_text_form_filed.dart';
import '../shared/auth_container.dart';
import '../shared/auth_header.dart';
import '../widget/code/code_form.dart';
import '../widget/code/resend_button.dart';

class ResetScreen extends StatefulWidget {
  const ResetScreen({super.key, required this.email});

  final String email;

  @override
  State<ResetScreen> createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String _otp = '';

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Center(
              heightFactor: context.screenHeight > 1080 ? 2 : 1.1,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const AuthHeader(
                      title: "Reset Password",
                      subtitle: "Enter the OTP and create a new password",
                    ),
                    BlocConsumer<ConfirmResetCubit, ConfirmResetStates>(
                      listener: (context, state) {
                        if (state is ConfirmResetSuccess) {
                          AppSnackBars.showSuccessSnackBar(
                            context: context,
                            message: state.message,
                          );
                          context.go(RouteCenter.login);
                        } else if (state is ConfirmResetFailure) {
                          AppSnackBars.showErrorSnackBar(
                            context: context,
                            message: state.error,
                          );
                        }
                      },
                      builder: (context, state) {
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
                              20.hight,
                              CodeForm(onCompleted: (value) => _otp = value),
                              20.hight,
                              Text(
                                "New Password",
                                style: AppStyles.styleRegular14(context),
                              ),
                              8.hight,
                              CustomTextFormField(
                                textInputType: TextInputType.visiblePassword,
                                hintText: "Enter new password",
                                prefixIconPath: AppAssets.password,
                                isPassword: true,
                                validator: (value) =>
                                    Validator.validateField(value, 'password'),
                                controller: _passwordController,
                              ),
                              20.hight,
                              Text(
                                "Confirm Password",
                                style: AppStyles.styleRegular14(context),
                              ),
                              8.hight,
                              CustomTextFormField(
                                textInputType: TextInputType.visiblePassword,
                                hintText: "Confirm new password",
                                isPassword: true,
                                prefixIconPath: AppAssets.password,
                                validator: (value) => Validator.validateField(
                                  value,
                                  'confirmPassword',
                                  password: _passwordController.text,
                                ),
                                controller: _confirmPasswordController,
                              ),
                              20.hight,
                              CustomButton(
                                isLoading: state is ConfirmResetLoading,
                                text: "Reset Password",
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<ConfirmResetCubit>().confirmResetPassword(
                                      ConfirmResetPasswordRequest(
                                        email: widget.email,
                                        otp: _otp,
                                        newPassword: _passwordController.text,
                                        confirmNewPassword: _confirmPasswordController.text,
                                      ),
                                    );
                                  }
                                },
                              ),
                              20.hight,
                              Center(child: ResendButton(email: widget.email)),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
