import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

import 'package:medcoco/core/init/app_init.dart';
import 'package:medcoco/view/medcoco.dart';

void main() async {
  await appInit();
  runApp(DevicePreview(enabled: false, builder: (context) => const MedCoco()));
}
