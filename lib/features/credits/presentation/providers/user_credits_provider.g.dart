// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_credits_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userCreditsHash() => r'692a0ecbafabee39947bd52ca5d489ac7c17f302';

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

/// See also [userCredits].
@ProviderFor(userCredits)
const userCreditsProvider = UserCreditsFamily();

/// See also [userCredits].
class UserCreditsFamily extends Family<AsyncValue<int>> {
  /// See also [userCredits].
  const UserCreditsFamily();

  /// See also [userCredits].
  UserCreditsProvider call(
    String userId,
  ) {
    return UserCreditsProvider(
      userId,
    );
  }

  @override
  UserCreditsProvider getProviderOverride(
    covariant UserCreditsProvider provider,
  ) {
    return call(
      provider.userId,
    );
  }

  static final Iterable<ProviderOrFamily> _dependencies = <ProviderOrFamily>[
    fixedCreditsProvider,
    additionalCreditsProvider
  ];

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static final Iterable<ProviderOrFamily> _allTransitiveDependencies =
      <ProviderOrFamily>{
    fixedCreditsProvider,
    ...?fixedCreditsProvider.allTransitiveDependencies,
    additionalCreditsProvider,
    ...?additionalCreditsProvider.allTransitiveDependencies
  };

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'userCreditsProvider';
}

/// See also [userCredits].
class UserCreditsProvider extends AutoDisposeStreamProvider<int> {
  /// See also [userCredits].
  UserCreditsProvider(
    String userId,
  ) : this._internal(
          (ref) => userCredits(
            ref as UserCreditsRef,
            userId,
          ),
          from: userCreditsProvider,
          name: r'userCreditsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userCreditsHash,
          dependencies: UserCreditsFamily._dependencies,
          allTransitiveDependencies:
              UserCreditsFamily._allTransitiveDependencies,
          userId: userId,
        );

  UserCreditsProvider._internal(
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
  Override overrideWith(
    Stream<int> Function(UserCreditsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserCreditsProvider._internal(
        (ref) => create(ref as UserCreditsRef),
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
  AutoDisposeStreamProviderElement<int> createElement() {
    return _UserCreditsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserCreditsProvider && other.userId == userId;
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
mixin UserCreditsRef on AutoDisposeStreamProviderRef<int> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _UserCreditsProviderElement extends AutoDisposeStreamProviderElement<int>
    with UserCreditsRef {
  _UserCreditsProviderElement(super.provider);

  @override
  String get userId => (origin as UserCreditsProvider).userId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
