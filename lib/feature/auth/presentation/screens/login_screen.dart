import 'package:flutter/material.dart';
import 'package:medcoco/core/utils/context_util.dart';
import '../shared/auth_header.dart';
import '../widget/login/login_form_body.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
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
              heightFactor: context.screenHeight > 1080 ? 2 : 1.1,
              child: AutofillGroup(
                child: Form(
                  key: _formKey,
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const AuthHeader(
                      title: "Welcome Back",
                      subtitle: "Sign in to your medical account",
                    ),
                    LoginFormBody(
                      formKey: _formKey,
                      onEmailSaved: (value) => _email = value,
                      onPasswordSaved: (value) => _password = value,
                      emailGetter: () => _email,
                      passwordGetter: () => _password,
                    ),
                    
                  ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
