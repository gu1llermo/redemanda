// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'documents_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(documentsRepository)
const documentsRepositoryProvider = DocumentsRepositoryProvider._();

final class DocumentsRepositoryProvider extends $FunctionalProvider<
    DocumentsRepository,
    DocumentsRepository,
    DocumentsRepository> with $Provider<DocumentsRepository> {
  const DocumentsRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'documentsRepositoryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$documentsRepositoryHash();

  @$internal
  @override
  $ProviderElement<DocumentsRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DocumentsRepository create(Ref ref) {
    return documentsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DocumentsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DocumentsRepository>(value),
    );
  }
}

String _$documentsRepositoryHash() =>
    r'09f7cc9c219cb420808a2cf852104b23cd109b4b';
