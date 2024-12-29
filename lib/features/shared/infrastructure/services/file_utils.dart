// lib/features/shared/infrastructure/services/file_utils.dart
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'platform_file_utils.dart'
    if (dart.library.html) 'platform_file_utils_web.dart'
    if (dart.library.io) 'platform_file_utils_mobile.dart';

class FileUtils {
  static Future<void> share({
    required BuildContext context,
    required Uint8List file,
    required String fileName,
  }) async {
    try {
      await PlatformFileUtils.share(
        context: context,
        file: file,
        fileName: fileName,
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al compartir el archivo: $e')),
      );
    }
  }

  static Future<void> openWithDefaultApp({
    required Uint8List fileBytes,
    required String fileExtension,
    required BuildContext context,
  }) async {
    try {
      await PlatformFileUtils.openWithDefaultApp(
        context: context,
        fileBytes: fileBytes,
        fileExtension: fileExtension,
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al abrir el archivo: $e')),
      );
    }
  }
}
