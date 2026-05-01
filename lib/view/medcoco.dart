import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:medcoco/core/routes/app_router.dart';

import '../core/theme/app_theme.dart';

class MedCoco extends StatelessWidget {
  const MedCoco({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      title: 'MedCoco',
      routerConfig: AppRouter.routes,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
    );
  }
}
