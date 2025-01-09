// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'additional_credits_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$additionalCreditsHash() => r'7cd937fc72a6fbb63d29d92ef8b6e08870c3a65e';

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

abstract class _$AdditionalCredits
    extends BuildlessAutoDisposeStreamNotifier<int> {
  late final String userId;

  Stream<int> build(
    String userId,
  );
}

/// See also [AdditionalCredits].
@ProviderFor(AdditionalCredits)
const additionalCreditsProvider = AdditionalCreditsFamily();

/// See also [AdditionalCredits].
class AdditionalCreditsFamily extends Family<AsyncValue<int>> {
  /// See also [AdditionalCredits].
  const AdditionalCreditsFamily();

  /// See also [AdditionalCredits].
  AdditionalCreditsProvider call(
    String userId,
  ) {
    return AdditionalCreditsProvider(
      userId,
    );
  }

  @override
  AdditionalCreditsProvider getProviderOverride(
    covariant AdditionalCreditsProvider provider,
  ) {
    return call(
      provider.userId,
    );
  }

  static final Iterable<ProviderOrFamily> _dependencies = <ProviderOrFamily>[
    supabaseClientProvider
  ];

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static final Iterable<ProviderOrFamily> _allTransitiveDependencies =
      <ProviderOrFamily>{
    supabaseClientProvider,
    ...?supabaseClientProvider.allTransitiveDependencies
  };

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'additionalCreditsProvider';
}

/// See also [AdditionalCredits].
class AdditionalCreditsProvider
    extends AutoDisposeStreamNotifierProviderImpl<AdditionalCredits, int> {
  /// See also [AdditionalCredits].
  AdditionalCreditsProvider(
    String userId,
  ) : this._internal(
          () => AdditionalCredits()..userId = userId,
          from: additionalCreditsProvider,
          name: r'additionalCreditsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$additionalCreditsHash,
          dependencies: AdditionalCreditsFamily._dependencies,
          allTransitiveDependencies:
              AdditionalCreditsFamily._allTransitiveDependencies,
          userId: userId,
        );

  AdditionalCreditsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  Stream<int> runNotifierBuild(
    covariant AdditionalCredits notifier,
  ) {
    return notifier.build(
      userId,
    );
  }

  @override
  Override overrideWith(AdditionalCredits Function() create) {
    return ProviderOverride(
      origin: this,
      override: AdditionalCreditsProvider._internal(
        () => create()..userId = userId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeStreamNotifierProviderElement<AdditionalCredits, int>
      createElement() {
    return _AdditionalCreditsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AdditionalCreditsProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AdditionalCreditsRef on AutoDisposeStreamNotifierProviderRef<int> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _AdditionalCreditsProviderElement
    extends AutoDisposeStreamNotifierProviderElement<AdditionalCredits, int>
    with AdditionalCreditsRef {
  _AdditionalCreditsProviderElement(super.provider);

  @override
  String get userId => (origin as AdditionalCreditsProvider).userId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
