// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_form_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ResetPasswordForm)
const resetPasswordFormProvider = ResetPasswordFormProvider._();

final class ResetPasswordFormProvider
    extends $NotifierProvider<ResetPasswordForm, ResetPasswordFormState> {
  const ResetPasswordFormProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'resetPasswordFormProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$resetPasswordFormHash();

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
}

String _$resetPasswordFormHash() => r'bcc1db1032e0cf08ad4420f2c00f5c8071bc552f';

abstract class _$ResetPasswordForm extends $Notifier<ResetPasswordFormState> {
  ResetPasswordFormState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
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
