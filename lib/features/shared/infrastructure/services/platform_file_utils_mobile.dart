// lib/features/shared/infrastructure/services/platform_file_utils_mobile.dart
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class PlatformFileUtils {
  static Future<void> share({
    required BuildContext context,
    required Uint8List file,
    required String fileName,
  }) async {
    final tempDir = await getTemporaryDirectory();
    final tempFile = File('${tempDir.path}/$fileName');

    await tempFile.writeAsBytes(file);

    await Share.shareXFiles(
      [XFile(tempFile.path)],
      text: 'Compartir documento',
    );
  }

  static Future<void> openWithDefaultApp({
    required BuildContext context,
    required Uint8List fileBytes,
    required String fileExtension,
  }) async {
    final tempDir = await getTemporaryDirectory();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final filePath = '${tempDir.path}/temp_file_$timestamp.$fileExtension';

    final file = File(filePath);
    await file.writeAsBytes(fileBytes);

    final result = await OpenFile.open(filePath);
    if (result.type == ResultType.error) {
      throw Exception(result.message);
    }
  }
}
