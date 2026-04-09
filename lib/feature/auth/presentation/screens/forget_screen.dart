import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:valo/core/generated/assets.dart';
import 'package:valo/core/routes/route_center.dart';
import 'package:valo/core/theme/app_style.dart';
import 'package:valo/core/utils/app_snack_bars.dart';
import 'package:valo/core/utils/context_util.dart';
import 'package:valo/core/utils/sizebox_util.dart';
import 'package:valo/core/utils/validator.dart';
import 'package:valo/core/widget/custom_button.dart';
import 'package:valo/core/widget/custom_text_form_filed.dart';
import 'package:valo/feature/auth/presentation/cubit/forget/forget_cubit.dart';
import 'package:valo/feature/auth/presentation/cubit/forget/forget_states.dart';
import '../shared/auth_container.dart';
import '../shared/auth_header.dart';


class ForgetScreen extends StatefulWidget {
  const ForgetScreen({super.key});

  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: SafeArea(child:
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 16),
          child: Center(
            heightFactor:context.screenHeight>1080?2:1.5,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AuthHeader(title: "Forgot Password", subtitle: "We'll send you an OTP to reset your password"),
                  BlocConsumer<ForgetCubit, ForgetStates>(
                    listener: (context, state) {
                      if (state is ForgetSuccess) {
                        AppSnackBars.showSuccessSnackBar(
                          context: context,
                          message: state.message,
                        );
                        context.go(RouteCenter.reset, extra: _email);
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
                            Text("Email Address",style: AppStyles.styleRegular14(context),),
                            8.hight,
                            CustomTextFormField(
                              textInputType: TextInputType.emailAddress,
                              hintText: "Email Address",
                              prefixIconPath: AppAssets.email,
                              validator: (value) => Validator.validateField(value, 'email'),
                              onSaved: (value) => _email = value,
                            ),
                            20.hight,
                            CustomButton(
                              isLoading: state is ForgetLoading,
                              text: "Send OTP",
                              onPressed: (){
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  context.read<ForgetCubit>().forget(_email!);
                                }
                              },
                            ),
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
      )
      ),
    );
  }
}
