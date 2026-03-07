import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoaclConstant {
  static final String accessTokenKey = dotenv.env['accessTokenKey']!;
  static final String refreshTokenKey = dotenv.env['refreshTokenKey']!;
  static final String userIdKey = dotenv.env['userIdKey']!;
}