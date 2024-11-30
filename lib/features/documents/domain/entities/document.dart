import 'dart:typed_data';

class Document {
  final String id;
  final String title;
  final String description;
  final int sizeInBytes;
  final DateTime createdAt;
  final String? author;
  final List<String>? tags;
  final String? thumbnailPath;
  final Uint8List docxFile;

  const Document({
    required this.id,
    required this.title,
    required this.description,
    required this.sizeInBytes,
    required this.createdAt,
    this.author,
    this.tags,
    this.thumbnailPath,
    required this.docxFile,
  });

  // Método para calcular el tamaño del archivo en una unidad legible
  String getReadableFileSize() {
    final units = ['B', 'KB', 'MB', 'GB', 'TB'];
    var size = sizeInBytes.toDouble();
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
      id: '',
      title: title,
      description: description,
      sizeInBytes: 0,
      createdAt: DateTime.now(),
      docxFile: Uint8List(0),
      author: null,
      tags: [],
      thumbnailPath: null,
    );
  }
}
