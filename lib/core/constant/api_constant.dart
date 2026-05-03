import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstant {
  static String get baseUrl => dotenv.env['baseUrl'] ?? '';
  static String get loginEndpoint => dotenv.env['loginEndpoint'] ?? '';
  static String get registerEndpoint => dotenv.env['registerEndpoint'] ?? '';
  static String get passwordResetEndpoint =>
      dotenv.env['passwordResetEndpoint'] ?? '';
  static String get confirmResetPasswordEndpoint =>
      dotenv.env['confirmResetPasswordEndpoint'] ?? '';
  static String get uploadImageEndpoint => dotenv.env['uploadImageEndpoint'] ?? '';
  static String get refreshTokenEndpoint => dotenv.env['refreshTokenEndpoint'] ?? '';
  static String get searchEndpoint => dotenv.env['searchEndpoint'] ?? '';
  static String get getMyImagesEndpoint =>
      dotenv.env['getMyImageEndpoint'] ?? '';
  static String get removeMyUploadImageEndpoint =>
      dotenv.env['removeMyUploadImageEndpoint'] ?? '';
  static String get remmoveOneImageFromMyUpload =>
      dotenv.env['remmoveOneImageFromMyUpload'] ?? '';


}


