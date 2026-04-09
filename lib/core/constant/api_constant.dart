import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstant {
  static String get baseUrl => dotenv.env['baseUrl'] ?? '';
  static String get loginEndpoint => dotenv.env['loginEndpoint'] ?? '';
  static String get registerEndpoint => dotenv.env['registerEndpoint'] ?? '';
  static String get passwordResetEndpoint => dotenv.env['passwordResetEndpoint'] ?? '';
  static String get confirmResetPasswordEndpoint => dotenv.env['confirmResetPasswordEndpoint'] ?? '';
}
