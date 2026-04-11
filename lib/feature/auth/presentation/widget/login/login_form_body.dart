import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:valo/core/routes/route_center.dart';
import 'package:valo/core/utils/app_snack_bars.dart';
import 'package:valo/core/widget/custom_button.dart';
import 'package:valo/feature/auth/data/models/login_request_model.dart';
import 'package:valo/feature/auth/presentation/cubit/login/login_cubit.dart';
import 'package:valo/feature/auth/presentation/cubit/login/login_states.dart';
import '../../shared/auth_container.dart';
import '../../shared/nav_text_button.dart';
import 'forget_button.dart';
import 'login_form_fields.dart';

class LoginFormBody extends StatelessWidget {
  const LoginFormBody({
    super.key,
    required this.formKey,
    required this.onEmailSaved,
    required this.onPasswordSaved,
    required this.emailGetter,
    required this.passwordGetter,
  });

  final GlobalKey<FormState> formKey;
  final ValueChanged<String?> onEmailSaved;
  final ValueChanged<String?> onPasswordSaved;
  final ValueGetter<String?> emailGetter;
  final ValueGetter<String?> passwordGetter;

  @override
  Widget build(BuildContext context) {
    return AuthContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LoginFormFields(
            onEmailSaved: onEmailSaved,
            onPasswordSaved: onPasswordSaved,
          ),
          const SizedBox(height: 20),
          const ForgetButton(),
          const SizedBox(height: 20),
          BlocConsumer<LoginCubit, LoginStates>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                AppSnackBars.showSuccessSnackBar(
                  context: context,
                  message: state.message,
                );
                Router.neglect(context, () => context.go(RouteCenter.view));
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
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    context.read<LoginCubit>().login(
                      LoginRequestModel(
                        email: emailGetter()!,
                        password: passwordGetter()!,
                      ),
                    );
                  }
                },
              );
            },
          ),
          const Divider(height: 40, color: Color(0xFF27272A)),
          NavTextButton(
            onTap: () => Router.neglect(context, () => context.go(RouteCenter.register)),
            prefText: "Don't have an account? ",
            suffixText: "Sign Up",
          ),
        ],
      ),
    );
  }
}
