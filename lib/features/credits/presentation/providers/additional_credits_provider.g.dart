// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'additional_credits_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AdditionalCredits)
const additionalCreditsProvider = AdditionalCreditsFamily._();

final class AdditionalCreditsProvider
    extends $StreamNotifierProvider<AdditionalCredits, int> {
  const AdditionalCreditsProvider._(
      {required AdditionalCreditsFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'additionalCreditsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$additionalCreditsHash();

  @override
  String toString() {
    return r'additionalCreditsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  AdditionalCredits create() => AdditionalCredits();

  @override
  bool operator ==(Object other) {
    return other is AdditionalCreditsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$additionalCreditsHash() => r'db851f9a3629c634c2cf9f7c15173610b74c1894';

final class AdditionalCreditsFamily extends $Family
    with
        $ClassFamilyOverride<AdditionalCredits, AsyncValue<int>, int,
            Stream<int>, String> {
  const AdditionalCreditsFamily._()
      : super(
          retry: null,
          name: r'additionalCreditsProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  AdditionalCreditsProvider call(
    String userId,
  ) =>
      AdditionalCreditsProvider._(argument: userId, from: this);

  @override
  String toString() => r'additionalCreditsProvider';
}

abstract class _$AdditionalCredits extends $StreamNotifier<int> {
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
