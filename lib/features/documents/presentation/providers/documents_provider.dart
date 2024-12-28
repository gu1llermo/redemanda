import 'package:redemanda/features/auth/infrastructure/errors/auth_errors.dart';
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
  final bool isLoading;
  final String errorMessage;
  // final AsyncValue<void> status;

  DocumentsState({
    this.documents = const [],
    this.hasMoreDocuments = true,
    this.currentPage = 1,
    this.pageSize = 10,
    this.isLoading = false,
    this.errorMessage = '',
    // this.status = const AsyncValue.data(null),
  });

  DocumentsState copyWith({
    List<Document>? documents,
    bool? hasMoreDocuments,
    int? currentPage,
    int? pageSize,
    bool? isLoading,
    String? errorMessage,
    // AsyncValue<void>? status,
  }) =>
      DocumentsState(
        documents: documents ?? this.documents,
        hasMoreDocuments: hasMoreDocuments ?? this.hasMoreDocuments,
        currentPage: currentPage ?? this.currentPage,
        pageSize: pageSize ?? this.pageSize,
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
        // status: status ?? this.status,
      );
}

@Riverpod(dependencies: [documentsRepository])
class DocumentsPagination extends _$DocumentsPagination {
  @override
  DocumentsState build() {
    Future.microtask(loadDocuments);
    return DocumentsState();
  }

  // Cargar documentos con paginación
  Future<void> loadDocuments({bool refresh = false}) async {
    // Si ya estamos cargando o no hay más documentos, no hacemos nada
    // if (state.status is AsyncLoading && !refresh) return;
    if (state.isLoading) return;
    // if (state.isLoading && !refresh) return;

    try {
      // Iniciar carga
      state = state.copyWith(
        isLoading: true,
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
        isLoading: false,
        errorMessage: '',
        // status: const AsyncValue.data(null),
      );
    } on CustomError catch (e) {
      // Manejar errores personalizados
      state = state.copyWith(
        errorMessage: e.errorMessage,
        isLoading: false,
      );
    } on Exception catch (e) {
      // Manejar errores
      state = state.copyWith(
        errorMessage: e.toString(),
        isLoading: false,
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
  Future<Document?> createDocument(Map<String, dynamic> documentRequest) async {
    try {
      final documentsRepository = ref.read(documentsRepositoryProvider);
      final newDocument =
          await documentsRepository.createDocument(documentRequest);
      // Actualizar lista de documentos
      state = state.copyWith(
        documents: [newDocument, ...state.documents],
        errorMessage: '',
      );
      return newDocument;
    } on NetworkException catch (e) {
      state = state.copyWith(
        errorMessage: e.message,
      );
      return null;
    } catch (e) {
      state = state.copyWith(
        errorMessage: e.toString(),
      );
      return null;
    }
  }

  // Método para eliminar un documento
  Future<void> deleteDocument(int id) async {
    try {
      final documentsRepository = ref.read(documentsRepositoryProvider);
      await documentsRepository.deleteDocument(id);

      // Eliminar de la lista local
      state = state.copyWith(
        documents: state.documents.where((doc) => doc.id != id).toList(),
        errorMessage: '',
      );
    } on CustomError catch (e) {
      state = state.copyWith(
        errorMessage: e.errorMessage,
      );
    } catch (e) {
      state = state.copyWith(
        errorMessage: e.toString(),
      );
    }
  }

  // Método para buscar documentos
  Future<void> searchDocumentsByTerm(String term) async {
    try {
      // state = state.copyWith(status: const AsyncValue.loading());
      state = state.copyWith(
        isLoading: true,
      );

      final documentsRepository = ref.read(documentsRepositoryProvider);
      final searchResults =
          await documentsRepository.searchDocumentByTerm(term);

      state = state.copyWith(
        documents: searchResults,
        isLoading: false,
        hasMoreDocuments: false,
        errorMessage: '',
      );
    } on CustomError catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.errorMessage,
      );
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: error.toString(),
      );
    }
  }

  Future<void> searchDocumentsByRange(
      {required DateTime startDate, required DateTime endDate}) async {
    try {
      state = state.copyWith(
        isLoading: true,
      );

      final documentsRepository = ref.read(documentsRepositoryProvider);
      final searchResults = await documentsRepository.searchDocumentByRange(
          startDate: startDate, endDate: endDate);

      state = state.copyWith(
        documents: searchResults,
        isLoading: false,
        hasMoreDocuments: false,
        errorMessage: '',
      );
    } on CustomError catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.errorMessage,
      );
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: error.toString(),
      );
    }
  }
}
