// lib/features/shared/infrastructure/services/platform_file_utils.dart
import 'dart:typed_data';
import 'package:flutter/material.dart';

abstract class PlatformFileUtils {
  static Future<void> share({
    required BuildContext context,
    required Uint8List file,
    required String fileName,
  }) {
    throw UnimplementedError(
        'PlatformFileUtils.share() has not been implemented.');
  }

  static Future<void> openWithDefaultApp({
    required BuildContext context,
    required Uint8List fileBytes,
    required String fileExtension,
  }) {
    throw UnimplementedError(
        'PlatformFileUtils.openWithDefaultApp() has not been implemented.');
  }
}
