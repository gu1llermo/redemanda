// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'autocomplete_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AutocompleteNotifier)
const autocompleteProvider = AutocompleteNotifierFamily._();

final class AutocompleteNotifierProvider
    extends $NotifierProvider<AutocompleteNotifier, AutocompleteState> {
  const AutocompleteNotifierProvider._(
      {required AutocompleteNotifierFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'autocompleteProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$autocompleteNotifierHash();

  @override
  String toString() {
    return r'autocompleteProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  AutocompleteNotifier create() => AutocompleteNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AutocompleteState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AutocompleteState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is AutocompleteNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$autocompleteNotifierHash() =>
    r'4fe50cc10ca40679abd658d5b282e9a9ee9d9d8e';

final class AutocompleteNotifierFamily extends $Family
    with
        $ClassFamilyOverride<AutocompleteNotifier, AutocompleteState,
            AutocompleteState, AutocompleteState, String> {
  const AutocompleteNotifierFamily._()
      : super(
          retry: null,
          name: r'autocompleteProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  AutocompleteNotifierProvider call(
    String preferencesKey,
  ) =>
      AutocompleteNotifierProvider._(argument: preferencesKey, from: this);

  @override
  String toString() => r'autocompleteProvider';
}

abstract class _$AutocompleteNotifier extends $Notifier<AutocompleteState> {
  late final _$args = ref.$arg as String;
  String get preferencesKey => _$args;

  AutocompleteState build(
    String preferencesKey,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(
      _$args,
    );
    final ref = this.ref as $Ref<AutocompleteState, AutocompleteState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AutocompleteState, AutocompleteState>,
        AutocompleteState,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
