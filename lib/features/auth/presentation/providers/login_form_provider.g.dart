// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_form_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$loginFormHash() => r'fc50f19c06f6af3484315fdd10212302d1ccf919';

/// See also [LoginForm].
@ProviderFor(LoginForm)
final loginFormProvider =
    AutoDisposeNotifierProvider<LoginForm, LoginFormState>.internal(
  LoginForm.new,
  name: r'loginFormProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$loginFormHash,
  dependencies: <ProviderOrFamily>[authProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    authProvider,
    ...?authProvider.allTransitiveDependencies
  },
);

typedef _$LoginForm = AutoDisposeNotifier<LoginFormState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
