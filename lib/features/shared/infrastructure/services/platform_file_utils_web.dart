// lib/features/shared/infrastructure/services/platform_file_utils_web.dart
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:universal_html/html.dart' as html;

class PlatformFileUtils {
  static Future<void> share({
    required BuildContext context,
    required Uint8List file,
    required String fileName,
  }) async {
    final blob = html.Blob([file]);
    final url = html.Url.createObjectUrlFromBlob(blob);

    try {
      await Share.shareXFiles(
        [XFile.fromData(file, name: fileName)],
        text: 'Compartir documento',
      );
    } catch (e) {
      // Si Web Share API falla, descargar el archivo
      final anchor = html.AnchorElement(href: url)
        ..setAttribute('download', fileName)
        ..click();
    } finally {
      html.Url.revokeObjectUrl(url);
    }
  }

  static Future<void> openWithDefaultApp({
    required BuildContext context,
    required Uint8List fileBytes,
    required String fileExtension,
  }) async {
    final blob = html.Blob([fileBytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);

    html.window.open(url, '_blank');

    // Limpiar el URL después de un breve delay
    Future.delayed(const Duration(seconds: 1), () {
      html.Url.revokeObjectUrl(url);
    });
  }
}
