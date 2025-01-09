// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fixed_credits_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fixedCreditsHash() => r'65a7f60659ebf15afb46db9d63cb6f0019570092';

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

abstract class _$FixedCredits extends BuildlessAutoDisposeStreamNotifier<int> {
  late final String userId;

  Stream<int> build(
    String userId,
  );
}

/// See also [FixedCredits].
@ProviderFor(FixedCredits)
const fixedCreditsProvider = FixedCreditsFamily();

/// See also [FixedCredits].
class FixedCreditsFamily extends Family<AsyncValue<int>> {
  /// See also [FixedCredits].
  const FixedCreditsFamily();

  /// See also [FixedCredits].
  FixedCreditsProvider call(
    String userId,
  ) {
    return FixedCreditsProvider(
      userId,
    );
  }

  @override
  FixedCreditsProvider getProviderOverride(
    covariant FixedCreditsProvider provider,
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
  String? get name => r'fixedCreditsProvider';
}

/// See also [FixedCredits].
class FixedCreditsProvider
    extends AutoDisposeStreamNotifierProviderImpl<FixedCredits, int> {
  /// See also [FixedCredits].
  FixedCreditsProvider(
    String userId,
  ) : this._internal(
          () => FixedCredits()..userId = userId,
          from: fixedCreditsProvider,
          name: r'fixedCreditsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fixedCreditsHash,
          dependencies: FixedCreditsFamily._dependencies,
          allTransitiveDependencies:
              FixedCreditsFamily._allTransitiveDependencies,
          userId: userId,
        );

  FixedCreditsProvider._internal(
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
    covariant FixedCredits notifier,
  ) {
    return notifier.build(
      userId,
    );
  }

  @override
  Override overrideWith(FixedCredits Function() create) {
    return ProviderOverride(
      origin: this,
      override: FixedCreditsProvider._internal(
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
  AutoDisposeStreamNotifierProviderElement<FixedCredits, int> createElement() {
    return _FixedCreditsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FixedCreditsProvider && other.userId == userId;
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
mixin FixedCreditsRef on AutoDisposeStreamNotifierProviderRef<int> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _FixedCreditsProviderElement
    extends AutoDisposeStreamNotifierProviderElement<FixedCredits, int>
    with FixedCreditsRef {
  _FixedCreditsProviderElement(super.provider);

  @override
  String get userId => (origin as FixedCreditsProvider).userId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
