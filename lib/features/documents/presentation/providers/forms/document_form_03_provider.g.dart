// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_form_03_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DocumentForm03)
const documentForm03Provider = DocumentForm03Provider._();

final class DocumentForm03Provider
    extends $NotifierProvider<DocumentForm03, DocumentForm03State> {
  const DocumentForm03Provider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'documentForm03Provider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$documentForm03Hash();

  @$internal
  @override
  DocumentForm03 create() => DocumentForm03();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DocumentForm03State value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DocumentForm03State>(value),
    );
  }
}

String _$documentForm03Hash() => r'6f8df7baf0142aa8356867b1b22897187a203552';

abstract class _$DocumentForm03 extends $Notifier<DocumentForm03State> {
  DocumentForm03State build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<DocumentForm03State, DocumentForm03State>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<DocumentForm03State, DocumentForm03State>,
        DocumentForm03State,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
