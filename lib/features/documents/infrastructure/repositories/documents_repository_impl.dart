import '../../domain/domain.dart';
import '../infrastructure.dart';

class DocumentsRepositoryImpl extends DocumentsRepository {
  final DocumentsDatasource datasource;

  DocumentsRepositoryImpl([DocumentsDatasource? datasource])
      : datasource = datasource ?? DocumentsDatasourceImpl();

  @override
  Future<Document> createDocument(Map<String, dynamic> documentData) {
    return datasource.createDocument(documentData);
  }

  @override
  Future<void> deleteDocument(String id) {
    return datasource.deleteDocument(id);
  }

  @override
  Future<Document> getDocumentById(String id) {
    return datasource.getDocumentById(id);
  }

  @override
  Future<List<Document>> searchDocumentByTerm(String term) {
    return datasource.searchDocumentByTerm(term);
  }
}
