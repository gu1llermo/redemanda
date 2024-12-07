import 'dart:typed_data';

import 'package:flutter/foundation.dart';

class Document {
  final int? id;
  final String title;
  final String description;
  final int? sizeInBytes;
  final DateTime createdAt;
  final String? author;
  final List<String>? tags;
  final String? thumbnailPath;
  final Uint8List docxFile;
  // final Uint8List pdfFile;

  const Document({
    this.id,
    required this.title,
    required this.description,
    this.sizeInBytes,
    required this.createdAt,
    this.author,
    this.tags,
    this.thumbnailPath,
    required this.docxFile,
    // required this.pdfFile,
  });

  Document copyWith({
    int? id,
    String? title,
    String? description,
    int? sizeInBytes,
    DateTime? createdAt,
    String? author,
    List<String>? tags,
    String? thumbnailPath,
    Uint8List? docxFile,
    // Uint8List? pdfFile,
  }) =>
      Document(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        sizeInBytes: sizeInBytes ?? this.sizeInBytes,
        createdAt: createdAt ?? this.createdAt,
        author: author ?? this.author,
        tags: tags ?? this.tags,
        thumbnailPath: thumbnailPath ?? this.thumbnailPath,
        docxFile: docxFile ?? this.docxFile,
        // pdfFile: pdfFile ?? this.pdfFile,
      );

  // Método para calcular el tamaño del archivo en una unidad legible
  String getReadableFileSize() {
    final units = ['B', 'KB', 'MB', 'GB', 'TB'];
    var size = sizeInBytes?.toDouble() ?? 0.0;
    var unitIndex = 0;

    while (size >= 1024 && unitIndex < units.length - 1) {
      size /= 1024;
      unitIndex++;
    }

    return '${size.toStringAsFixed(2)} ${units[unitIndex]}';
  }

  factory Document.empty({
    String title = 'Documento sin título',
    String description = 'Sin descripción',
  }) {
    return Document(
      id: 11111111111,
      title: title,
      description: description,
      sizeInBytes: 0,
      createdAt: DateTime.now(),
      docxFile: Uint8List(0),
      // pdfFile: Uint8List(0),
      author: null,
      tags: [],
      thumbnailPath: null,
    );
  }
}
