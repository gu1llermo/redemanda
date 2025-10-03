import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/domain.dart';
import 'providers.dart';

part 'document_provider.g.dart';

// final documentProvider = AutoDisposeProviderFamily<DocumentNotifier, int>(
//     (ref, productId) => DocumentNotifier());
    

@Riverpod()
class DocumentNotifier extends _$DocumentNotifier {
  @override
  DocumentState build(int productId) {
    // Estado inicial con el ID proporcionado
    return DocumentState(id: productId);
  }

  // Método para cargar el documento
  Future<void> loadDocument() async {
    try {
      // Establecer estado de carga
      state = state.copyWith(isLoading: true);

      // Aquí deberías implementar la lógica real de obtención del documento
      // Por ejemplo:
      final documentsRepository = ref.read(documentsRepositoryProvider);
      final document = await documentsRepository.getDocumentById(state.id);

      // Actualizar estado con el documento cargado
      state = state.copyWith(document: document, isLoading: false);
    } catch (error) {
      // Manejar error
      state = state.copyWith(
        isLoading: false,
        // Podrías agregar manejo de error si es necesario
      );
      // Opcionalmente, relanzar el error si quieres que se propague
      rethrow;
    }
  }
}

class DocumentState {
  final int id;
  final Document? document;
  final bool isLoading;

  DocumentState({
    required this.id,
    this.document,
    // Se coloca en loading desde el principio porque va a hacer
    // una consulta a la base de datos para recuperar el documento
    this.isLoading = true,
  });

  DocumentState copyWith({
    int? id,
    Document? document,
    bool? isLoading,
  }) =>
      DocumentState(
        id: id ?? this.id,
        document: document ?? this.document,
        isLoading: isLoading ?? this.isLoading,
      );
}
