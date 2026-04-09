import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:valo/core/di/service_locator.dart';
import 'package:valo/view/valo.dart';

import 'core/init/dotenv_init.dart';
import 'core/init/observer_init.dart';
import 'core/init/window_init_stub.dart'
    if (dart.library.io) 'core/init/window_init.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDotenv();
  await configureDependencies();
  await initDesktopWindow();
  observerInit();
  runApp(DevicePreview(
      enabled: false,
      builder: (context) => const Valo()));
}

