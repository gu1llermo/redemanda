// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$documentNotifierHash() => r'4f602f914ca8e80be65b1a0fbf39e81394e71b4d';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$DocumentNotifier
    extends BuildlessAutoDisposeNotifier<DocumentState> {
  late final int productId;

  DocumentState build(
    int productId,
  );
}

/// See also [DocumentNotifier].
@ProviderFor(DocumentNotifier)
const documentNotifierProvider = DocumentNotifierFamily();

/// See also [DocumentNotifier].
class DocumentNotifierFamily extends Family<DocumentState> {
  /// See also [DocumentNotifier].
  const DocumentNotifierFamily();

  /// See also [DocumentNotifier].
  DocumentNotifierProvider call(
    int productId,
  ) {
    return DocumentNotifierProvider(
      productId,
    );
  }

  @override
  DocumentNotifierProvider getProviderOverride(
    covariant DocumentNotifierProvider provider,
  ) {
    return call(
      provider.productId,
    );
  }

  static final Iterable<ProviderOrFamily> _dependencies = <ProviderOrFamily>[
    documentsRepositoryProvider
  ];

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static final Iterable<ProviderOrFamily> _allTransitiveDependencies =
      <ProviderOrFamily>{
    documentsRepositoryProvider,
    ...?documentsRepositoryProvider.allTransitiveDependencies
  };

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'documentNotifierProvider';
}

/// See also [DocumentNotifier].
class DocumentNotifierProvider
    extends AutoDisposeNotifierProviderImpl<DocumentNotifier, DocumentState> {
  /// See also [DocumentNotifier].
  DocumentNotifierProvider(
    int productId,
  ) : this._internal(
          () => DocumentNotifier()..productId = productId,
          from: documentNotifierProvider,
          name: r'documentNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$documentNotifierHash,
          dependencies: DocumentNotifierFamily._dependencies,
          allTransitiveDependencies:
              DocumentNotifierFamily._allTransitiveDependencies,
          productId: productId,
        );

  DocumentNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.productId,
  }) : super.internal();

  final int productId;

  @override
  DocumentState runNotifierBuild(
    covariant DocumentNotifier notifier,
  ) {
    return notifier.build(
      productId,
    );
  }

  @override
  Override overrideWith(DocumentNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: DocumentNotifierProvider._internal(
        () => create()..productId = productId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        productId: productId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<DocumentNotifier, DocumentState>
      createElement() {
    return _DocumentNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DocumentNotifierProvider && other.productId == productId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, productId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DocumentNotifierRef on AutoDisposeNotifierProviderRef<DocumentState> {
  /// The parameter `productId` of this provider.
  int get productId;
}

class _DocumentNotifierProviderElement
    extends AutoDisposeNotifierProviderElement<DocumentNotifier, DocumentState>
    with DocumentNotifierRef {
  _DocumentNotifierProviderElement(super.provider);

  @override
  int get productId => (origin as DocumentNotifierProvider).productId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
