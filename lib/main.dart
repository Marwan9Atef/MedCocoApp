import 'dart:io';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:valo/core/di/service_locator.dart';
import 'package:valo/core/init/dot_env_init.dart';
import 'package:valo/view/valo.dart';
import 'package:window_manager/window_manager.dart';

import 'core/init/observer_init.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await dotenvInit();
  await configureDependencies();


  const Size minimumSize = Size(600, 750);
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    await windowManager.ensureInitialized();
    await windowManager.setMinimumSize(minimumSize);

  }
  observerInit();
  runApp(DevicePreview(
      enabled: false,
      builder: (context) => const Valo()));
}

