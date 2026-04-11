import 'package:flutter/material.dart';
import 'package:valo/core/utils/context_util.dart';
import '../shared/auth_header.dart';
import '../widget/register/register_form_body.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _username;
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
              heightFactor: context.screenHeight > 1080 ? 1.7 : 1,
              child: AutofillGroup(
                child: Form(
                  key: _formKey,
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const AuthHeader(
                      title: "Create Account",
                      subtitle: "Join to your medical app to get started",
                    ),
                    RegisterFormBody(
                      formKey: _formKey,
                      onUsernameSaved: (value) => _username = value,
                      onEmailSaved: (value) => _email = value,
                      onPasswordSaved: (value) => _password = value,
                      usernameGetter: () => _username,
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
