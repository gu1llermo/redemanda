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
String _$colorPreferencesHash() => r'6eca00ba83e1ac72729c27dfb24d8287c9a866fd';

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
String _$themeNotifierHash() => r'e94434185bbdee85768f78a3df809b6fc97c4eab';

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
