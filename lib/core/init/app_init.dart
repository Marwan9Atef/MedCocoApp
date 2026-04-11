
import 'package:flutter/material.dart';
import 'package:valo/core/di/service_locator.dart';
import 'package:valo/core/init/dotenv_init.dart';
import 'package:valo/core/init/file_downloader_init_stub.dart'
    if (dart.library.io) 'package:valo/core/init/file_downloader_init.dart';
import 'package:valo/core/init/observer_init.dart';
import 'package:valo/core/init/url_strategy_stub.dart'
    if (dart.library.html) 'package:valo/core/init/url_strategy_web.dart';
import 'package:valo/core/init/window_init.dart';
import 'package:valo/feature/auth/presentation/cubit/auth/auth_cubit.dart';

Future<void> appInit() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDotenv();
  await configureDependencies();
  await serviceLocator<AuthCubit>().checkAuth();
  await initDesktopWindow();
  await initFileDownloader();
  observerInit();
  configureUrlStrategy();
}

