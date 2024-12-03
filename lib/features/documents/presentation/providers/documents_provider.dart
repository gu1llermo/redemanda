import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/domain.dart';
import 'providers.dart';

final documentsProvider =
    NotifierProvider<DocumentsNotifier, DocumentsState>(DocumentsNotifier.new);

class DocumentsNotifier extends Notifier<DocumentsState> {
  late final DocumentsRepository documentsRepository;
  @override
  DocumentsState build() {
    documentsRepository = ref.watch(documentsRepositoryProvider);
    Future.microtask(loadAllDocuments);
    return DocumentsState();
  }

  Future<bool> createDocument(Map<String, dynamic> documentData) async {
    try {
      final document = await documentsRepository.createDocument(documentData);

      state = state.copyWith(documents: [...state.documents, document]);

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteDocument(int id) async {
    try {
      await documentsRepository.deleteDocument(id);
      state = state.copyWith(
          documents:
              state.documents.where((document) => document.id != id).toList());

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> loadAllDocuments() async {
    // para éste caso en especifico no me parece necesario paginar
    // los documentos, es decir pedirlo por páginas

    try {
      final documents = await documentsRepository.getAllDocuments();
      state =
          state.copyWith(documents: documents); // me parece que puedo hacer así
      // para cargar los documentos iniciales al iniciar la app
      // state = state.copyWith(documents: [...documents]);
    } catch (e) {
      rethrow;
    }
  }
}

class DocumentsState {
  final List<Document> documents;

  DocumentsState({this.documents = const []});

  DocumentsState copyWith({
    List<Document>? documents,
  }) =>
      DocumentsState(
        documents: documents ?? this.documents,
      );
}
