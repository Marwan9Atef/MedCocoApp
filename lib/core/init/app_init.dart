import 'package:flutter/material.dart';
import 'package:valo/core/di/service_locator.dart';
import 'package:valo/core/init/dotenv_init.dart';
import 'package:valo/core/init/observer_init.dart';
import 'package:valo/core/init/url_strategy_stub.dart'
    if (dart.library.html) 'package:valo/core/init/url_strategy_web.dart';
import 'package:valo/core/init/window_init.dart';

Future<void> appInit() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDotenv();
  await configureDependencies();
  await initDesktopWindow();
  observerInit();
  configureUrlStrategy();
}