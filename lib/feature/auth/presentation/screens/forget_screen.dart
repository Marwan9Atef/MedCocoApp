import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:medcoco/core/utils/context_util.dart';
import '../shared/auth_header.dart';
import '../widget/forget/forget_form_body.dart';

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
      appBar:kIsWeb? null : AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Center(
              heightFactor: context.screenHeight > 1080 ? 2 : 1.5,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const AuthHeader(
                      title: "Forgot Password",
                      subtitle: "We'll send you an OTP to reset your password",
                    ),
                    ForgetFormBody(
                      formKey: _formKey,
                      onEmailSaved: (value) => _email = value,
                      emailGetter: () => _email,
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
