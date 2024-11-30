import '../domain.dart';

abstract class DocumentsRepository {
  Future<Document> getDocumentById(String id);
  Future<List<Document>> searchDocumentByTerm(String term);
  Future<Document> createDocument(Map<String, dynamic> documentData);
  // algo que parece un Documento
  Future<void> deleteDocument(String id);
}
