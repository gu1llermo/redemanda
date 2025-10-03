// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ColorPreferences)
const colorPreferencesProvider = ColorPreferencesProvider._();

final class ColorPreferencesProvider
    extends $NotifierProvider<ColorPreferences, Color> {
  const ColorPreferencesProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'colorPreferencesProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$colorPreferencesHash();

  @$internal
  @override
  ColorPreferences create() => ColorPreferences();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Color value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Color>(value),
    );
  }
}

String _$colorPreferencesHash() => r'c59e70646ccacb67d982733fe6a56daccae9177e';

abstract class _$ColorPreferences extends $Notifier<Color> {
  Color build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Color, Color>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<Color, Color>, Color, Object?, Object?>;
    element.handleValue(ref, created);
  }
}

@ProviderFor(ThemeNotifier)
const themeProvider = ThemeNotifierProvider._();

final class ThemeNotifierProvider
    extends $NotifierProvider<ThemeNotifier, ThemeMode> {
  const ThemeNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'themeProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$themeNotifierHash();

  @$internal
  @override
  ThemeNotifier create() => ThemeNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ThemeMode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ThemeMode>(value),
    );
  }
}

String _$themeNotifierHash() => r'e90928fd469cbde87e20a625ee045faa779babdb';

abstract class _$ThemeNotifier extends $Notifier<ThemeMode> {
  ThemeMode build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ThemeMode, ThemeMode>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<ThemeMode, ThemeMode>, ThemeMode, Object?, Object?>;
    element.handleValue(ref, created);
  }
}

@ProviderFor(keyValueStorageService)
const keyValueStorageServiceProvider = KeyValueStorageServiceProvider._();

final class KeyValueStorageServiceProvider extends $FunctionalProvider<
    KeyValueStorageService,
    KeyValueStorageService,
    KeyValueStorageService> with $Provider<KeyValueStorageService> {
  const KeyValueStorageServiceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'keyValueStorageServiceProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$keyValueStorageServiceHash();

  @$internal
  @override
  $ProviderElement<KeyValueStorageService> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  KeyValueStorageService create(Ref ref) {
    return keyValueStorageService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(KeyValueStorageService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<KeyValueStorageService>(value),
    );
  }
}

String _$keyValueStorageServiceHash() =>
    r'81017f407e6bfabdc0305e1bf4848a2a5fe1698f';
