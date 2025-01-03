// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_recovery_form_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$passwordRecoveryFormHash() =>
    r'5d575cf251ff59ac380738b85a8e900e18dff6d2';

/// See also [PasswordRecoveryForm].
@ProviderFor(PasswordRecoveryForm)
final passwordRecoveryFormProvider = AutoDisposeNotifierProvider<
    PasswordRecoveryForm, PasswordRecoveryFormState>.internal(
  PasswordRecoveryForm.new,
  name: r'passwordRecoveryFormProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$passwordRecoveryFormHash,
  dependencies: <ProviderOrFamily>[authRepositoryProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    authRepositoryProvider,
    ...?authRepositoryProvider.allTransitiveDependencies
  },
);

typedef _$PasswordRecoveryForm = AutoDisposeNotifier<PasswordRecoveryFormState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
