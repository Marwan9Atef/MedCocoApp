import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:valo/feature/auth/data/models/register_request_model.dart';
import '../../../../core/routes/route_center.dart';
import '../../../../core/utils/app_snack_bars.dart';
import '../../../../core/utils/context_util.dart';
import '../../../../core/utils/sizebox_util.dart';
import '../../../../core/widget/custom_button.dart';
import '../cubit/register/register_cubit.dart';
import '../cubit/register/register_states.dart';
import '../shared/auth_container.dart';
import '../shared/auth_header.dart';
import '../shared/nav_text_button.dart';
import '../widget/register/register_form_fields.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _username;
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
              heightFactor: context.screenHeight > 1080 ? 1.7 : 1,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const AuthHeader(
                      title: "Create Account",
                      subtitle: "Join to your medical app to get started",
                    ),
                    AuthContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RegisterFormFields(
                            onUsernameSaved: (value) => _username = value,
                            onEmailSaved: (value) => _email = value,
                            onPasswordSaved: (value) => _password = value,
                          ),
                          20.hight,
                          BlocConsumer<RegisterCubit, RegisterStates>(
                            listener: (context, state) {
                              if (state is RegisterSuccess) {
                                AppSnackBars.showSuccessSnackBar(
                                  context: context,
                                  message: state.message,
                                );
                                context.pushReplacement(RouteCenter.view);
                              } else if (state is RegisterFailure) {
                                AppSnackBars.showErrorSnackBar(
                                  context: context,
                                  message: state.error,
                                );
                              }
                            },
                            builder: (context, state) {
                              return CustomButton(
                                isLoading: state is RegisterLoading,
                                text: "Create Account",
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    context.read<RegisterCubit>().register(
                                      RegisterRequestModel(
                                        username: _username,
                                        email: _email,
                                        password: _password,
                                      ),
                                    );
                                  }
                                },
                              );
                            },
                          ),
                          Divider(height: 40, color: const Color(0xFF27272A)),
                          NavTextButton(
                            onTap: () {
                              context.pushReplacement(RouteCenter.login);
                            },
                            prefText: "Already have an account? ",
                            suffixText: "Sign in",
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
