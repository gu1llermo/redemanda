// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_form_01_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DocumentForm01)
const documentForm01Provider = DocumentForm01Provider._();

final class DocumentForm01Provider
    extends $NotifierProvider<DocumentForm01, DocumentForm01State> {
  const DocumentForm01Provider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'documentForm01Provider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$documentForm01Hash();

  @$internal
  @override
  DocumentForm01 create() => DocumentForm01();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DocumentForm01State value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DocumentForm01State>(value),
    );
  }
}

String _$documentForm01Hash() => r'49d1822da43442e9b99d6e28e8a296db5f05fef8';

abstract class _$DocumentForm01 extends $Notifier<DocumentForm01State> {
  DocumentForm01State build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<DocumentForm01State, DocumentForm01State>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<DocumentForm01State, DocumentForm01State>,
        DocumentForm01State,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
