import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medcoco/core/di/service_locator.dart';
import 'package:medcoco/core/routes/route_center.dart';
import 'package:medcoco/core/utils/app_snack_bars.dart';
import 'package:medcoco/core/widget/custom_button.dart';
import 'package:medcoco/feature/auth/data/models/register_request_model.dart';
import 'package:medcoco/feature/auth/presentation/cubit/auth/auth_cubit.dart';
import 'package:medcoco/feature/auth/presentation/cubit/register/register_cubit.dart';
import 'package:medcoco/feature/auth/presentation/cubit/register/register_states.dart';
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
          const SizedBox(height: 20),
          BlocConsumer<RegisterCubit, RegisterStates>(
            listener: (context, state) {
              if (state is RegisterSuccess) {
                TextInput.finishAutofillContext();
                AppSnackBars.showSuccessSnackBar(
                  context: context,
                  message: state.message,
                );
                serviceLocator<AuthCubit>().setAuthenticated();
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
            onTap: () =>Router.neglect(context, () => context.go(RouteCenter.login)),
            prefText: "Already have an account? ",
            suffixText: "Sign in",
          ),
        ],
      ),
    );
  }
}
