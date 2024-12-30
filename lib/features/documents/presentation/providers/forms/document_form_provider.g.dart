// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_form_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$documentFormHash() => r'b57239e04a5d59aeeebf079683a69dec94355a73';

/// See also [DocumentForm].
@ProviderFor(DocumentForm)
final documentFormProvider =
    AutoDisposeNotifierProvider<DocumentForm, DocumentFormState>.internal(
  DocumentForm.new,
  name: r'documentFormProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$documentFormHash,
  dependencies: <ProviderOrFamily>[documentsPaginationProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    documentsPaginationProvider,
    ...?documentsPaginationProvider.allTransitiveDependencies
  },
);

typedef _$DocumentForm = AutoDisposeNotifier<DocumentFormState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
