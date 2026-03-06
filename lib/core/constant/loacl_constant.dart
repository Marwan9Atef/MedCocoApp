import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoaclConstant {
  static final String token = dotenv.env['token']!;
}