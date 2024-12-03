// solo útil para las vistas previas

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/domain.dart';

final documentProvider = AutoDisposeProviderFamily<DocumentNotifier, int>(
    (ref, productId) => DocumentNotifier());

class DocumentNotifier extends AutoDisposeFamilyNotifier<DocumentState, int> {
  @override
  build(arg) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class DocumentState {
  final String id;
  final Document? document;
  final bool isLoading;

  DocumentState({
    required this.id,
    this.document,
    // se coloca en loading desde el principio porque en realidad va hacer una consulta a la base de datos
    // para recuperar el documento
    this.isLoading = true,
  });
  DocumentState copyWith({
    String? id,
    Document? product,
    bool? isLoading,
  }) =>
      DocumentState(
        id: id ?? this.id,
        document: product ?? this.document,
        isLoading: isLoading ?? this.isLoading,
      );
}
