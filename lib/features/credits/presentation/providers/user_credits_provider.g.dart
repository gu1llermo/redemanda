// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_credits_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(userCredits)
const userCreditsProvider = UserCreditsFamily._();

final class UserCreditsProvider
    extends $FunctionalProvider<AsyncValue<int>, int, Stream<int>>
    with $FutureModifier<int>, $StreamProvider<int> {
  const UserCreditsProvider._(
      {required UserCreditsFamily super.from, required String super.argument})
      : super(
          retry: null,
          name: r'userCreditsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$userCreditsHash();

  @override
  String toString() {
    return r'userCreditsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<int> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<int> create(Ref ref) {
    final argument = this.argument as String;
    return userCredits(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is UserCreditsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userCreditsHash() => r'07d4068bf3b5f073a6a9d4f088a0cec9c37df4c3';

final class UserCreditsFamily extends $Family
    with $FunctionalFamilyOverride<Stream<int>, String> {
  const UserCreditsFamily._()
      : super(
          retry: null,
          name: r'userCreditsProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  UserCreditsProvider call(
    String userId,
  ) =>
      UserCreditsProvider._(argument: userId, from: this);

  @override
  String toString() => r'userCreditsProvider';
}
