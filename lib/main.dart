import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

import 'package:valo/core/init/app_init.dart';
import 'package:valo/view/valo.dart';


void main() async {
await appInit();  
  runApp(DevicePreview(
      enabled: false,
      builder: (context) => const Valo()));
}

