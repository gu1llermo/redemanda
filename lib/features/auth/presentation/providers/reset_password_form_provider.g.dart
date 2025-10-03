// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_form_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ResetPasswordForm)
const resetPasswordFormProvider = ResetPasswordFormFamily._();

final class ResetPasswordFormProvider
    extends $NotifierProvider<ResetPasswordForm, ResetPasswordFormState> {
  const ResetPasswordFormProvider._(
      {required ResetPasswordFormFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'resetPasswordFormProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$resetPasswordFormHash();

  @override
  String toString() {
    return r'resetPasswordFormProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ResetPasswordForm create() => ResetPasswordForm();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ResetPasswordFormState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ResetPasswordFormState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ResetPasswordFormProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$resetPasswordFormHash() => r'176cd2a192e8c7f4ee04664b9690114e41e31d81';

final class ResetPasswordFormFamily extends $Family
    with
        $ClassFamilyOverride<ResetPasswordForm, ResetPasswordFormState,
            ResetPasswordFormState, ResetPasswordFormState, String> {
  const ResetPasswordFormFamily._()
      : super(
          retry: null,
          name: r'resetPasswordFormProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  ResetPasswordFormProvider call(
    String code,
  ) =>
      ResetPasswordFormProvider._(argument: code, from: this);

  @override
  String toString() => r'resetPasswordFormProvider';
}

abstract class _$ResetPasswordForm extends $Notifier<ResetPasswordFormState> {
  late final _$args = ref.$arg as String;
  String get code => _$args;

  ResetPasswordFormState build(
    String code,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(
      _$args,
    );
    final ref =
        this.ref as $Ref<ResetPasswordFormState, ResetPasswordFormState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<ResetPasswordFormState, ResetPasswordFormState>,
        ResetPasswordFormState,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
