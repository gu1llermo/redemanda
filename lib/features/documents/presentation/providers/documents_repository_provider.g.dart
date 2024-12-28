// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'documents_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$documentsRepositoryHash() =>
    r'2e17578c1164256d51db9b7f087c2a94ec8c5961';

/// See also [documentsRepository].
@ProviderFor(documentsRepository)
final documentsRepositoryProvider =
    AutoDisposeProvider<DocumentsRepository>.internal(
  documentsRepository,
  name: r'documentsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$documentsRepositoryHash,
  dependencies: <ProviderOrFamily>[authProvider, supabaseClientProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    authProvider,
    ...?authProvider.allTransitiveDependencies,
    supabaseClientProvider,
    ...?supabaseClientProvider.allTransitiveDependencies
  },
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DocumentsRepositoryRef = AutoDisposeProviderRef<DocumentsRepository>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
