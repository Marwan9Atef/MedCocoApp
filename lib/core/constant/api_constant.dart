import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstant {
  static final String baseUrl = dotenv.env['baseUrl']!;
  static final String loginEndpoint = dotenv.env['loginEndpoint']!;
  static final String registerEndpoint = dotenv.env['registerEndpoint']!;
}
