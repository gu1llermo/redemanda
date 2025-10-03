// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fixed_credits_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FixedCredits)
const fixedCreditsProvider = FixedCreditsFamily._();

final class FixedCreditsProvider
    extends $StreamNotifierProvider<FixedCredits, int> {
  const FixedCreditsProvider._(
      {required FixedCreditsFamily super.from, required String super.argument})
      : super(
          retry: null,
          name: r'fixedCreditsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$fixedCreditsHash();

  @override
  String toString() {
    return r'fixedCreditsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  FixedCredits create() => FixedCredits();

  @override
  bool operator ==(Object other) {
    return other is FixedCreditsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fixedCreditsHash() => r'ae7d91c2b3a00282e1dde146a7581b6f0b9121e1';

final class FixedCreditsFamily extends $Family
    with
        $ClassFamilyOverride<FixedCredits, AsyncValue<int>, int, Stream<int>,
            String> {
  const FixedCreditsFamily._()
      : super(
          retry: null,
          name: r'fixedCreditsProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  FixedCreditsProvider call(
    String userId,
  ) =>
      FixedCreditsProvider._(argument: userId, from: this);

  @override
  String toString() => r'fixedCreditsProvider';
}

abstract class _$FixedCredits extends $StreamNotifier<int> {
  late final _$args = ref.$arg as String;
  String get userId => _$args;

  Stream<int> build(
    String userId,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(
      _$args,
    );
    final ref = this.ref as $Ref<AsyncValue<int>, int>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<int>, int>, AsyncValue<int>, Object?, Object?>;
    element.handleValue(ref, created);
  }
}
