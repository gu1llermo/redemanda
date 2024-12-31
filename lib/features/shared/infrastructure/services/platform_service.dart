// platform_service.dart
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class PlatformService {
  Future<void> reloadPage();
}

class WebPlatformService implements PlatformService {
  @override
  Future<void> reloadPage() async {
    if (kIsWeb) {
      final currentUrl = Uri.base;
      await launchUrl(currentUrl);
    }
  }
}

class MobilePlatformService implements PlatformService {
  @override
  Future<void> reloadPage() async {
    // No hace nada en mobile, ya que no necesitamos recargar la página
    return;
  }
}

// Factory para obtener la implementación correcta
PlatformService getPlatformService() {
  if (kIsWeb) {
    return WebPlatformService();
  }
  return MobilePlatformService();
}
