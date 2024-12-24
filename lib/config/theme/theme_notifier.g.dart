// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$keyValueStorageServiceHash() =>
    r'90f32e40cd750e63927e93d59eaa5c1662be8b62';

/// See also [keyValueStorageService].
@ProviderFor(keyValueStorageService)
final keyValueStorageServiceProvider =
    Provider<KeyValueStorageService>.internal(
  keyValueStorageService,
  name: r'keyValueStorageServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$keyValueStorageServiceHash,
  dependencies: const <ProviderOrFamily>[],
  allTransitiveDependencies: const <ProviderOrFamily>{},
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef KeyValueStorageServiceRef = ProviderRef<KeyValueStorageService>;
String _$colorPreferencesHash() => r'284f7f688e07fc5d1246917b4da653796688ee11';

/// See also [ColorPreferences].
@ProviderFor(ColorPreferences)
final colorPreferencesProvider =
    AutoDisposeNotifierProvider<ColorPreferences, Color>.internal(
  ColorPreferences.new,
  name: r'colorPreferencesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$colorPreferencesHash,
  dependencies: <ProviderOrFamily>[keyValueStorageServiceProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    keyValueStorageServiceProvider,
    ...?keyValueStorageServiceProvider.allTransitiveDependencies
  },
);

typedef _$ColorPreferences = AutoDisposeNotifier<Color>;
String _$themeNotifierHash() => r'20c5e723ff0dd96b9d7685ca80c88b54c7bbef2e';

/// See also [ThemeNotifier].
@ProviderFor(ThemeNotifier)
final themeNotifierProvider =
    AutoDisposeNotifierProvider<ThemeNotifier, ThemeMode>.internal(
  ThemeNotifier.new,
  name: r'themeNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$themeNotifierHash,
  dependencies: <ProviderOrFamily>[keyValueStorageServiceProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    keyValueStorageServiceProvider,
    ...?keyValueStorageServiceProvider.allTransitiveDependencies
  },
);

typedef _$ThemeNotifier = AutoDisposeNotifier<ThemeMode>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
