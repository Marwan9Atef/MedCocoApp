
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:medcoco/core/constant/loacl_constant.dart';
import 'package:medcoco/core/di/service_locator.dart';
import 'package:medcoco/core/init/dotenv_init.dart';
import 'package:medcoco/core/init/file_downloader_init_stub.dart'
    if (dart.library.io) 'package:medcoco/core/init/file_downloader_init.dart';
import 'package:medcoco/core/init/observer_init.dart';
import 'package:medcoco/core/init/url_strategy_stub.dart'
    if (dart.library.html) 'package:medcoco/core/init/url_strategy_web.dart';
import 'package:medcoco/core/init/window_init.dart';
import 'package:medcoco/feature/auth/presentation/cubit/auth/auth_cubit.dart';

Future<void> appInit() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDotenv();
  await Hive.initFlutter();
  await Hive.openBox<Map>(LoaclConstant.searchCacheBox);
  await configureDependencies();
  await serviceLocator<AuthCubit>().checkAuth();
  await initDesktopWindow();
  await initFileDownloader();
  observerInit();
  configureUrlStrategy();
}

