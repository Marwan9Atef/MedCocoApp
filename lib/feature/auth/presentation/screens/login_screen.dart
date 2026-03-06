import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:valo/core/theme/app_color.dart';
import 'package:valo/core/theme/app_style.dart';
import 'package:valo/core/utils/context_util.dart';
import 'package:valo/core/utils/sizebox_util.dart';
import 'package:valo/core/widget/custom_button.dart';
import 'package:valo/feature/auth/presentation/shared/auth_container.dart';

import '../../../../../core/generated/assets.dart';
import '../../../../../core/widget/custom_text_form_filed.dart';
import '../../../../core/routes/route_center.dart';
import '../../../../core/utils/validator.dart';
import '../shared/auth_header.dart';
import '../shared/nav_text_button.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});


  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child:
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 16),
          child: Center(
            heightFactor:context.screenHeight>1080?2:1.1,
            child: Form(
              key: _formKey,
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AuthHeader(title: "Welcome Back", subtitle: "Sign in to your medical account"),
                AuthContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Email Address",style: AppStyles.styleRegular14(context),),
                        8.hight,
                        CustomTextFormField(
                          textInputType: TextInputType.emailAddress,
                          hintText: "Email Address",
                          prefixIconPath: AppAssets.email,
                          validator: (value) => Validator.validateField(value, 'login email'),
                        ),
                        20.hight,
                        Text("Password",style: AppStyles.styleRegular14(context),),
                        8.hight,
                        CustomTextFormField(
                          textInputType: TextInputType.visiblePassword,
                          hintText: "Password",
                          isPassword: true,
                          prefixIconPath: AppAssets.password,
                          validator: (value) => Validator.validateField(value, 'login password'),
                        ),
                        20.hight,
                        GestureDetector(onTap: (){
                          context.push(RouteCenter.forget);
                        },child: Align(alignment: Alignment.centerRight,child: Text("Forgot password?",style: AppStyles.styleRegular14(context).copyWith(color:AppColor.blue ),))),
                        20.hight,
                        CustomButton(text: "Sign In", onPressed: (){
                          if (_formKey.currentState!.validate()) {
                            context.pushReplacement(RouteCenter.view);
                          }

                        }),
                        Divider(
                          height: 40,
                          color: const Color(0xFF27272A),

                        ),
                        NavTextButton(onTap: (){
                          context.pushReplacement(RouteCenter.register);

                        }, prefText: "Don't have an account? ", suffixText: "Sign Up",),



                      ],

                    ))




              ],


            ),
          ),
        ),
      )
      ),

    )
    );
  }
}
