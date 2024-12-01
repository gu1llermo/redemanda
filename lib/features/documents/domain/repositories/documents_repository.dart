import '../domain.dart';

abstract class DocumentsRepository {
  Future<Document> getDocumentById(int id);
  Future<List<Document>> searchDocumentByTerm(String term);
  Future<Document> createDocument(Map<String, dynamic> documentData);
  // algo que parece un Documento
  Future<void> deleteDocument(int id);
  Future<List<Document>> getAllDocuments();
  Future<List<Document>> searchDocumentByRange(
      {required DateTime startDate, required DateTime endDate});
}
