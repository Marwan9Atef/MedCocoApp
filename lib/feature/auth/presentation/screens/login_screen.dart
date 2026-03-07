import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:valo/core/utils/app_snack_bars.dart';
import 'package:valo/core/utils/context_util.dart';
import 'package:valo/core/utils/sizebox_util.dart';
import 'package:valo/core/widget/custom_button.dart';
import 'package:valo/feature/auth/data/models/login_request_model.dart';
import 'package:valo/feature/auth/presentation/cubit/login/login_cubit.dart';
import 'package:valo/feature/auth/presentation/cubit/login/login_states.dart';
import 'package:valo/feature/auth/presentation/shared/auth_container.dart';
import 'package:valo/feature/auth/presentation/widget/login/forget_button.dart';
import 'package:valo/feature/auth/presentation/widget/login/login_form_fields.dart';

import '../../../../core/routes/route_center.dart';

import '../shared/auth_header.dart';
import '../shared/nav_text_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;
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
                      title: "Welcome Back",
                      subtitle: "Sign in to your medical account",
                    ),
                    AuthContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LoginFormFields(
                            onEmailSaved: (value) => _email = value,
                            onPasswordSaved: (value) => _password = value,
                          ),
                          20.hight,
                          const ForgetButton(),
                          20.hight,
                          BlocConsumer<LoginCubit, LoginStates>(
                            listener: (context, state) {
                              if (state is LoginSuccess) {
                                AppSnackBars.showSuccessSnackBar(
                                  context: context,
                                  message: state.message,
                                );
                                context.pushReplacement(RouteCenter.view);
                              } else if (state is LoginFailure) {
                                AppSnackBars.showErrorSnackBar(
                                  context: context,
                                  message: state.error,
                                );
                              }
                            },
                            builder: (context, state) {
                              return CustomButton(
                                isLoading: state is LoginLoading,
                                text: "Sign In",
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    context.read<LoginCubit>().login(LoginRequestModel(email: _email!, password: _password!));
                                  }
                                },
                              );
                            },
                          ),
                          Divider(height: 40, color: const Color(0xFF27272A)),
                          NavTextButton(
                            onTap: () {
                              context.pushReplacement(RouteCenter.register);
                            },
                            prefText: "Don't have an account? ",
                            suffixText: "Sign Up",
                          ),
                        ],
                      ),
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
