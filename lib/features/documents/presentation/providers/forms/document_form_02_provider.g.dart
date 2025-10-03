// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_form_02_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DocumentForm02)
const documentForm02Provider = DocumentForm02Provider._();

final class DocumentForm02Provider
    extends $NotifierProvider<DocumentForm02, DocumentForm02State> {
  const DocumentForm02Provider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'documentForm02Provider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$documentForm02Hash();

  @$internal
  @override
  DocumentForm02 create() => DocumentForm02();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DocumentForm02State value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DocumentForm02State>(value),
    );
  }
}

String _$documentForm02Hash() => r'5b2566beac1c37fe4cff5aeaad9afc625bece640';

abstract class _$DocumentForm02 extends $Notifier<DocumentForm02State> {
  DocumentForm02State build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<DocumentForm02State, DocumentForm02State>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<DocumentForm02State, DocumentForm02State>,
        DocumentForm02State,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
