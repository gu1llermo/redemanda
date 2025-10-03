// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_form_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LoginForm)
const loginFormProvider = LoginFormProvider._();

final class LoginFormProvider
    extends $NotifierProvider<LoginForm, LoginFormState> {
  const LoginFormProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'loginFormProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$loginFormHash();

  @$internal
  @override
  LoginForm create() => LoginForm();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LoginFormState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LoginFormState>(value),
    );
  }
}

String _$loginFormHash() => r'4bd64932ed42da2fa5a76922656b66fed827dd6e';

abstract class _$LoginForm extends $Notifier<LoginFormState> {
  LoginFormState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<LoginFormState, LoginFormState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<LoginFormState, LoginFormState>,
        LoginFormState,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
