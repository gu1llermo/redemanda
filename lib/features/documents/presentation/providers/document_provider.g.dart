// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DocumentNotifier)
const documentProvider = DocumentNotifierFamily._();

final class DocumentNotifierProvider
    extends $NotifierProvider<DocumentNotifier, DocumentState> {
  const DocumentNotifierProvider._(
      {required DocumentNotifierFamily super.from, required int super.argument})
      : super(
          retry: null,
          name: r'documentProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$documentNotifierHash();

  @override
  String toString() {
    return r'documentProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  DocumentNotifier create() => DocumentNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DocumentState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DocumentState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is DocumentNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$documentNotifierHash() => r'3fb15e54a26923ae99d4c54a176569fbd242fdea';

final class DocumentNotifierFamily extends $Family
    with
        $ClassFamilyOverride<DocumentNotifier, DocumentState, DocumentState,
            DocumentState, int> {
  const DocumentNotifierFamily._()
      : super(
          retry: null,
          name: r'documentProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  DocumentNotifierProvider call(
    int productId,
  ) =>
      DocumentNotifierProvider._(argument: productId, from: this);

  @override
  String toString() => r'documentProvider';
}

abstract class _$DocumentNotifier extends $Notifier<DocumentState> {
  late final _$args = ref.$arg as int;
  int get productId => _$args;

  DocumentState build(
    int productId,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(
      _$args,
    );
    final ref = this.ref as $Ref<DocumentState, DocumentState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<DocumentState, DocumentState>,
        DocumentState,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
