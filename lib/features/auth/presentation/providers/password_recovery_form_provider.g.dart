// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_recovery_form_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PasswordRecoveryForm)
const passwordRecoveryFormProvider = PasswordRecoveryFormProvider._();

final class PasswordRecoveryFormProvider
    extends $NotifierProvider<PasswordRecoveryForm, PasswordRecoveryFormState> {
  const PasswordRecoveryFormProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'passwordRecoveryFormProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$passwordRecoveryFormHash();

  @$internal
  @override
  PasswordRecoveryForm create() => PasswordRecoveryForm();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PasswordRecoveryFormState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PasswordRecoveryFormState>(value),
    );
  }
}

String _$passwordRecoveryFormHash() =>
    r'9eeab25f6750836f792dca7a34ca789f7298abb5';

abstract class _$PasswordRecoveryForm
    extends $Notifier<PasswordRecoveryFormState> {
  PasswordRecoveryFormState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<PasswordRecoveryFormState, PasswordRecoveryFormState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<PasswordRecoveryFormState, PasswordRecoveryFormState>,
        PasswordRecoveryFormState,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
