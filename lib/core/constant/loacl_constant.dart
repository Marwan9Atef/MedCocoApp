import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoaclConstant {
  static String get accessTokenKey => dotenv.env['accessTokenKey'] ?? '';
  static String get refreshTokenKey => dotenv.env['refreshTokenKey'] ?? '';
  static String get userIdKey => dotenv.env['userIdKey'] ?? '';
    static String get searchCacheBox => dotenv.env['searchCacheBox'] ?? '';
      static String get searchResponseKey => dotenv.env['searchResponseKey'] ?? '';

}
