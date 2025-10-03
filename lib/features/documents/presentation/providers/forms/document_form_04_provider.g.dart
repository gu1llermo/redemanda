// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_form_04_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DocumentForm04)
const documentForm04Provider = DocumentForm04Provider._();

final class DocumentForm04Provider
    extends $NotifierProvider<DocumentForm04, DocumentForm04State> {
  const DocumentForm04Provider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'documentForm04Provider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$documentForm04Hash();

  @$internal
  @override
  DocumentForm04 create() => DocumentForm04();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DocumentForm04State value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DocumentForm04State>(value),
    );
  }
}

String _$documentForm04Hash() => r'639af31ed29b0f26de59e99287402afecb5ee00e';

abstract class _$DocumentForm04 extends $Notifier<DocumentForm04State> {
  DocumentForm04State build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<DocumentForm04State, DocumentForm04State>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<DocumentForm04State, DocumentForm04State>,
        DocumentForm04State,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
