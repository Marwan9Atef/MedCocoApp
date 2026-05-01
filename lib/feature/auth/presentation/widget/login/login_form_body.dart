import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medcoco/core/di/service_locator.dart';
import 'package:medcoco/core/routes/route_center.dart';
import 'package:medcoco/core/utils/app_snack_bars.dart';
import 'package:medcoco/core/widget/custom_button.dart';
import 'package:medcoco/feature/auth/data/models/login_request_model.dart';
import 'package:medcoco/feature/auth/presentation/cubit/auth/auth_cubit.dart';
import 'package:medcoco/feature/auth/presentation/cubit/login/login_cubit.dart';
import 'package:medcoco/feature/auth/presentation/cubit/login/login_states.dart';
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
                TextInput.finishAutofillContext();
                AppSnackBars.showSuccessSnackBar(
                  context: context,
                  message: state.message,
                );
                serviceLocator<AuthCubit>().setAuthenticated();
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
