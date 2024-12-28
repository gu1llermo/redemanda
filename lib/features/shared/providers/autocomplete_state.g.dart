// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'autocomplete_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$autocompleteNotifierHash() =>
    r'ce0d9e8354383155b1e2578140422f81aec9ad74';

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

abstract class _$AutocompleteNotifier
    extends BuildlessAutoDisposeNotifier<AutocompleteState> {
  late final String preferencesKey;

  AutocompleteState build(
    String preferencesKey,
  );
}

/// See also [AutocompleteNotifier].
@ProviderFor(AutocompleteNotifier)
const autocompleteNotifierProvider = AutocompleteNotifierFamily();

/// See also [AutocompleteNotifier].
class AutocompleteNotifierFamily extends Family<AutocompleteState> {
  /// See also [AutocompleteNotifier].
  const AutocompleteNotifierFamily();

  /// See also [AutocompleteNotifier].
  AutocompleteNotifierProvider call(
    String preferencesKey,
  ) {
    return AutocompleteNotifierProvider(
      preferencesKey,
    );
  }

  @override
  AutocompleteNotifierProvider getProviderOverride(
    covariant AutocompleteNotifierProvider provider,
  ) {
    return call(
      provider.preferencesKey,
    );
  }

  static final Iterable<ProviderOrFamily> _dependencies = <ProviderOrFamily>[
    keyValueStorageServiceProvider
  ];

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static final Iterable<ProviderOrFamily> _allTransitiveDependencies =
      <ProviderOrFamily>{
    keyValueStorageServiceProvider,
    ...?keyValueStorageServiceProvider.allTransitiveDependencies
  };

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'autocompleteNotifierProvider';
}

/// See also [AutocompleteNotifier].
class AutocompleteNotifierProvider extends AutoDisposeNotifierProviderImpl<
    AutocompleteNotifier, AutocompleteState> {
  /// See also [AutocompleteNotifier].
  AutocompleteNotifierProvider(
    String preferencesKey,
  ) : this._internal(
          () => AutocompleteNotifier()..preferencesKey = preferencesKey,
          from: autocompleteNotifierProvider,
          name: r'autocompleteNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$autocompleteNotifierHash,
          dependencies: AutocompleteNotifierFamily._dependencies,
          allTransitiveDependencies:
              AutocompleteNotifierFamily._allTransitiveDependencies,
          preferencesKey: preferencesKey,
        );

  AutocompleteNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.preferencesKey,
  }) : super.internal();

  final String preferencesKey;

  @override
  AutocompleteState runNotifierBuild(
    covariant AutocompleteNotifier notifier,
  ) {
    return notifier.build(
      preferencesKey,
    );
  }

  @override
  Override overrideWith(AutocompleteNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: AutocompleteNotifierProvider._internal(
        () => create()..preferencesKey = preferencesKey,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        preferencesKey: preferencesKey,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<AutocompleteNotifier, AutocompleteState>
      createElement() {
    return _AutocompleteNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AutocompleteNotifierProvider &&
        other.preferencesKey == preferencesKey;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, preferencesKey.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AutocompleteNotifierRef
    on AutoDisposeNotifierProviderRef<AutocompleteState> {
  /// The parameter `preferencesKey` of this provider.
  String get preferencesKey;
}

class _AutocompleteNotifierProviderElement
    extends AutoDisposeNotifierProviderElement<AutocompleteNotifier,
        AutocompleteState> with AutocompleteNotifierRef {
  _AutocompleteNotifierProviderElement(super.provider);

  @override
  String get preferencesKey =>
      (origin as AutocompleteNotifierProvider).preferencesKey;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
