import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:universal_io/io.dart';

import 'app_desktop_service.dart';
import 'package:window_manager/window_manager.dart';

class AppDesktopServiceImpl extends AppDesktopService {
  @override
  Future<void> config() async {
    if (isDesktop()) {
      await windowManager.ensureInitialized();

      WindowOptions windowOptions = WindowOptions(
        minimumSize: const Size(800, 600),
        //maximumSize: const Size(1200, 900),
        // Otras configuraciones opcionales
        center: true,
        title: 'Redemanda',
      );

      windowManager.waitUntilReadyToShow(windowOptions, () async {
        await windowManager.show();
        await windowManager.focus();
      });
    }
  }

  bool isDesktop() {
    if (kIsWeb) return false;
    return Platform.isWindows;
    // return Platform.isWindows || Platform.isMacOS || Platform.isLinux;
  }
}
