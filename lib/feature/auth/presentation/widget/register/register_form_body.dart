import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:valo/core/routes/route_center.dart';
import 'package:valo/core/utils/app_snack_bars.dart';
import 'package:valo/core/utils/sizebox_util.dart';
import 'package:valo/core/widget/custom_button.dart';
import 'package:valo/feature/auth/data/models/register_request_model.dart';
import 'package:valo/feature/auth/presentation/cubit/register/register_cubit.dart';
import 'package:valo/feature/auth/presentation/cubit/register/register_states.dart';
import '../../shared/auth_container.dart';
import '../../shared/nav_text_button.dart';
import 'register_form_fields.dart';

class RegisterFormBody extends StatelessWidget {
  const RegisterFormBody({
    super.key,
    required this.formKey,
    required this.onUsernameSaved,
    required this.onEmailSaved,
    required this.onPasswordSaved,
    required this.usernameGetter,
    required this.emailGetter,
    required this.passwordGetter,
  });

  final GlobalKey<FormState> formKey;
  final ValueChanged<String?> onUsernameSaved;
  final ValueChanged<String?> onEmailSaved;
  final ValueChanged<String?> onPasswordSaved;
  final ValueGetter<String?> usernameGetter;
  final ValueGetter<String?> emailGetter;
  final ValueGetter<String?> passwordGetter;

  @override
  Widget build(BuildContext context) {
    return AuthContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RegisterFormFields(
            onUsernameSaved: onUsernameSaved,
            onEmailSaved: onEmailSaved,
            onPasswordSaved: onPasswordSaved,
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
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    context.read<RegisterCubit>().register(
                      RegisterRequestModel(
                        username: usernameGetter(),
                        email: emailGetter(),
                        password: passwordGetter(),
                      ),
                    );
                  }
                },
              );
            },
          ),
          const Divider(height: 40, color: Color(0xFF27272A)),
          NavTextButton(
            onTap: () => context.pushReplacement(RouteCenter.login),
            prefText: "Already have an account? ",
            suffixText: "Sign in",
          ),
        ],
      ),
    );
  }
}
