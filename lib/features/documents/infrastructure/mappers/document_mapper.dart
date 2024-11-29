import 'dart:convert';

import '../../domain/domain.dart';

class DocumentMapper {
  static Map<String, dynamic> entityToJson(Document document) => {
        'id': document.id,
        'title': document.title,
        'description': document.description,
        'sizeInBytes': document.sizeInBytes,
        'createdAt': document.createdAt.toIso8601String(),
        'author': document.author,
        'tags': document.tags,
        'thumbnailPath': document.thumbnailPath,
        'docxFile': base64Encode(document.docxFile),
        // Convertir Uint8List a base64
      };

  static Document jsonToEntity(Map<String, dynamic> json) => Document(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        sizeInBytes: json['sizeInBytes'],
        createdAt: DateTime.parse(json['createdAt']),
        author: json['author'],
        tags: json['tags'] != null ? List<String>.from(json['tags']) : null,
        thumbnailPath: json['thumbnailPath'],
        docxFile: base64Decode(json['docxFile']),
        // Convertir base64 a Uint8List
      );
}
