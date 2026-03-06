import 'dart:developer' show log;

import 'package:flutter_dotenv/flutter_dotenv.dart';

Future dotenvInit()async{
  try {
    await dotenv.load(fileName: "assets/.env");
  } catch (exception) {

    log("Warning: .env not found: $exception");
  }

}