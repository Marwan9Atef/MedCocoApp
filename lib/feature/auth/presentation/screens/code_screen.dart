import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/route_center.dart';
import '../../../../core/theme/app_style.dart';
import '../../../../core/utils/context_util.dart';
import '../../../../core/utils/sizebox_util.dart';
import '../../../../core/widget/custom_button.dart';
import '../shared/auth_container.dart';
import '../shared/auth_header.dart';
import '../widget/code/code_form.dart';
import '../widget/code/resend_button.dart';

class CodeScreen extends StatelessWidget {
  const CodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Center(
              heightFactor: context.screenHeight > 1080 ? 2 : 1.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AuthHeader(
                    title: "Verify OTP",
                    subtitle: "Enter the 6-digit code sent to your email",
                  ),
                  AuthContainer(
                    width: 0.35,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Enter OTP",
                          style: AppStyles.styleRegular14(context),
                        ),
                        20.hight,
                        const CodeForm(),
                        20.hight,
                        const ResendButton(),
                        20.hight,
                        CustomButton(
                          text: "Verify OTP",
                          onPressed: () {
                            context.go(RouteCenter.reset);
                          },
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
    );
  }
}
