import '../../domain/domain.dart';

class DocumentsRepositoryImpl extends DocumentsRepository {
  final DocumentsDatasource datasource;

  DocumentsRepositoryImpl(this.datasource);

  @override
  Future<Document> createDocument(Map<String, dynamic> documentData) {
    return datasource.createDocument(documentData);
  }

  @override
  Future<void> deleteDocument(int id) {
    return datasource.deleteDocument(id);
  }

  @override
  Future<Document> getDocumentById(int id) {
    return datasource.getDocumentById(id);
  }

  @override
  Future<List<Document>> searchDocumentByTerm(String term) {
    return datasource.searchDocumentByTerm(term);
  }

  @override
  Future<List<Document>> getAllDocuments() {
    return datasource.getAllDocuments();
  }

  @override
  Future<List<Document>> searchDocumentByRange(
      {required DateTime startDate, required DateTime endDate}) {
    return datasource.searchDocumentByDateRange(
      startDate: startDate,
      endDate: endDate,
    );
  }

  @override
  Future<List<Document>> getDocumentsPaginated(
      {required int page, required int pageSize, required int offset}) async {
    return await datasource.getDocumentsPaginated(
        page: page, pageSize: pageSize, offset: offset);
  }
}
