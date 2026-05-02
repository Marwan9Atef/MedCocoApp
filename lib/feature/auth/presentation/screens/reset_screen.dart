import 'package:flutter/material.dart';
import 'package:medcoco/core/utils/context_util.dart';
import '../shared/auth_header.dart';
import '../widget/reset/reset_form_body.dart';

class ResetScreen extends StatefulWidget {
  const ResetScreen({super.key, required this.email});

  final String email;

  @override
  State<ResetScreen> createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String _otp = '';

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

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
                      title: "Reset Password",
                      subtitle: "Enter the OTP and create a new password",
                    ),
                    ResetFormBody(
                      email: widget.email,
                      formKey: _formKey,
                      passwordController: _passwordController,
                      confirmPasswordController: _confirmPasswordController,
                      onOtpCompleted: (value) => _otp = value,
                      otpGetter: () => _otp,
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
