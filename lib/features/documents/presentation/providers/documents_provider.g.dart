// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'documents_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$documentsPaginationHash() =>
    r'88613026d5dba84b89e4fe39360ed809f66933fd';

/// See also [DocumentsPagination].
@ProviderFor(DocumentsPagination)
final documentsPaginationProvider =
    AutoDisposeNotifierProvider<DocumentsPagination, DocumentsState>.internal(
  DocumentsPagination.new,
  name: r'documentsPaginationProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$documentsPaginationHash,
  dependencies: <ProviderOrFamily>[documentsRepositoryProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    documentsRepositoryProvider,
    ...?documentsRepositoryProvider.allTransitiveDependencies
  },
);

typedef _$DocumentsPagination = AutoDisposeNotifier<DocumentsState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
