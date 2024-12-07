import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class FileUtils {
  static Future<void> share({
    required BuildContext context,
    required Uint8List file,
    required String fileName,
  }) async {
    try {
      // Obtener el directorio temporal
      final tempDir = await getTemporaryDirectory();

      // Crear un archivo temporal
      final tempFile = File('${tempDir.path}/$fileName');

      // Escribir los bytes del archivo
      await tempFile.writeAsBytes(file);

      // Compartir el archivo
      await Share.shareXFiles(
        [XFile(tempFile.path)],
        text: 'Compartir documento',
      );
    } catch (e) {
      // Manejar cualquier error de compartir
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
      // Get a temporary directory to save the file
      final tempDir = await getTemporaryDirectory();

      // Create a unique filename
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final filePath = '${tempDir.path}/temp_file_$timestamp.$fileExtension';

      // Write the bytes to a file
      final file = File(filePath);
      await file.writeAsBytes(fileBytes);

      // Open the file with the default application
      final result = await OpenFile.open(filePath);
      if (result.type == ResultType.error) {
        throw Exception(result.message);
      }
    } catch (e) {
      //print('Error opening file: $e');
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al abrir el archivo: $e')),
      );
    }
  }
}
