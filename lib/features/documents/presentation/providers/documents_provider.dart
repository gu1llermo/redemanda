import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/domain.dart';
import 'providers.dart';

part 'documents_provider.g.dart';

// Estado de documentos con soporte para paginación
class DocumentsState {
  final List<Document> documents;
  final bool hasMoreDocuments;
  final int currentPage;
  final int pageSize;
  final AsyncValue<void> status;

  DocumentsState({
    this.documents = const [],
    this.hasMoreDocuments = true,
    this.currentPage = 1,
    this.pageSize = 10,
    this.status = const AsyncValue.data(null),
  });

  DocumentsState copyWith({
    List<Document>? documents,
    bool? hasMoreDocuments,
    int? currentPage,
    int? pageSize,
    AsyncValue<void>? status,
  }) =>
      DocumentsState(
        documents: documents ?? this.documents,
        hasMoreDocuments: hasMoreDocuments ?? this.hasMoreDocuments,
        currentPage: currentPage ?? this.currentPage,
        pageSize: pageSize ?? this.pageSize,
        status: status ?? this.status,
      );
}

@Riverpod(dependencies: [documentsRepository])
class DocumentsPagination extends _$DocumentsPagination {
  @override
  DocumentsState build() {
    return DocumentsState();
  }

  // Cargar documentos con paginación
  Future<void> loadDocuments({bool refresh = false}) async {
    // Si ya estamos cargando o no hay más documentos, no hacemos nada
    if (state.status is AsyncLoading && !refresh) return;

    try {
      // Iniciar carga
      state = state.copyWith(
        status: const AsyncValue.loading(),
      );

      final documentsRepository = ref.read(documentsRepositoryProvider);

      // Calcular el offset basado en la página actual
      final offset = (state.currentPage - 1) * state.pageSize;

      // Cargar documentos paginados
      // NOTA: Asume que añades un método en el repositorio para manejar paginación
      final newDocuments = await documentsRepository.getDocumentsPaginated(
        page: state.currentPage,
        pageSize: state.pageSize,
        offset: offset,
      );

      // Determinar si hay más documentos
      final hasMoreDocuments = newDocuments.length == state.pageSize;

      // Actualizar estado
      state = state.copyWith(
        documents:
            refresh ? newDocuments : [...state.documents, ...newDocuments],
        hasMoreDocuments: hasMoreDocuments,
        currentPage: state.currentPage + 1,
        status: const AsyncValue.data(null),
      );
    } catch (error, stackTrace) {
      // Manejar errores
      state = state.copyWith(
        status: AsyncValue.error(error, stackTrace),
      );
    }
  }

  // Método para recargar documentos
  Future<void> refreshDocuments() async {
    state = state.copyWith(
      documents: [],
      currentPage: 1,
      hasMoreDocuments: true,
    );
    await loadDocuments(refresh: true);
  }

  // Método para crear un nuevo documento
  Future<bool> createDocument(Map<String, dynamic> documentData) async {
    try {
      final documentsRepository = ref.read(documentsRepositoryProvider);
      final newDocument =
          await documentsRepository.createDocument(documentData);

      // Actualizar lista de documentos
      state = state.copyWith(
        documents: [newDocument, ...state.documents],
      );

      return true;
    } catch (e) {
      return false;
    }
  }

  // Método para eliminar un documento
  Future<bool> deleteDocument(int id) async {
    try {
      final documentsRepository = ref.read(documentsRepositoryProvider);
      await documentsRepository.deleteDocument(id);

      // Eliminar de la lista local
      state = state.copyWith(
        documents: state.documents.where((doc) => doc.id != id).toList(),
      );

      return true;
    } catch (e) {
      return false;
    }
  }

  // Método para buscar documentos
  Future<void> searchDocuments(String term) async {
    try {
      state = state.copyWith(status: const AsyncValue.loading());

      final documentsRepository = ref.read(documentsRepositoryProvider);
      final searchResults =
          await documentsRepository.searchDocumentByTerm(term);

      state = state.copyWith(
        documents: searchResults,
        status: const AsyncValue.data(null),
        hasMoreDocuments: false,
      );
    } catch (error, stackTrace) {
      state = state.copyWith(
        status: AsyncValue.error(error, stackTrace),
      );
    }
  }
}
