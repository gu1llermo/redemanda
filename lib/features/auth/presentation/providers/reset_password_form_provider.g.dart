// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_form_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$resetPasswordFormHash() => r'f94bf66000a41ab43a8e776eb1068d101a85d886';

/// See also [ResetPasswordForm].
@ProviderFor(ResetPasswordForm)
final resetPasswordFormProvider = AutoDisposeNotifierProvider<ResetPasswordForm,
    ResetPasswordFormState>.internal(
  ResetPasswordForm.new,
  name: r'resetPasswordFormProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$resetPasswordFormHash,
  dependencies: <ProviderOrFamily>[authRepositoryProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    authRepositoryProvider,
    ...?authRepositoryProvider.allTransitiveDependencies
  },
);

typedef _$ResetPasswordForm = AutoDisposeNotifier<ResetPasswordFormState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
