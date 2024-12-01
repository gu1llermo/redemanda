import '../domain.dart';

abstract class DocumentsDatasource {
  Future<Document> getDocumentById(int id);
  Future<List<Document>> searchDocumentByTerm(String term);
  Future<Document> createDocument(Map<String, dynamic> documentData);
  // algo que parece un Documento
  Future<void> deleteDocument(int id);
  Future<List<Document>> getAllDocuments();
  Future<List<Document>> searchDocumentByDateRange(
      {required DateTime startDate, required DateTime endDate});
}
