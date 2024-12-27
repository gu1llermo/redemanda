import '../domain.dart';

abstract class DocumentsRepository {
  Future<Document> getDocumentById(int id);
  Future<List<Document>> searchDocumentByTerm(String term);
  Future<Document> createDocument(Map<String, dynamic> documentRequest);
  // algo que parece un Documento
  Future<void> deleteDocument(int id);
  Future<List<Document>> getAllDocuments();
  Future<List<Document>> searchDocumentByRange(
      {required DateTime startDate, required DateTime endDate});
  Future<List<Document>> getDocumentsPaginated(
      {required int page, required int pageSize, required int offset});
}
