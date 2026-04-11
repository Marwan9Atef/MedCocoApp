import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/widgets.dart';
import 'package:window_manager/window_manager.dart';

Future<void> initDesktopWindow() async {
  if (kIsWeb) return;

  const Size minimumSize = Size(600, 750);
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    await windowManager.ensureInitialized();
    await windowManager.setMinimumSize(minimumSize);
  }
}
