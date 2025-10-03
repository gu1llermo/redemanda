// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'documents_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DocumentsPagination)
const documentsPaginationProvider = DocumentsPaginationProvider._();

final class DocumentsPaginationProvider
    extends $NotifierProvider<DocumentsPagination, DocumentsState> {
  const DocumentsPaginationProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'documentsPaginationProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$documentsPaginationHash();

  @$internal
  @override
  DocumentsPagination create() => DocumentsPagination();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DocumentsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DocumentsState>(value),
    );
  }
}

String _$documentsPaginationHash() =>
    r'5187ab4dec0b1395a552cc322042dccf592099bb';

abstract class _$DocumentsPagination extends $Notifier<DocumentsState> {
  DocumentsState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<DocumentsState, DocumentsState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<DocumentsState, DocumentsState>,
        DocumentsState,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
