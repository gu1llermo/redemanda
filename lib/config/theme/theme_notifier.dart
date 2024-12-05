import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../features/shared/shared.dart';

part 'theme_notifier.g.dart';

// const scaffoldBackgroundColor = Color(0xFFF8F7F7);
const colorSeed = Color(0xff424CB8);

@Riverpod(dependencies: [keyValueStorageService])
class ColorPreferences extends _$ColorPreferences {
  static const _colorSeed = 'colorSeed';

  @override
  Color build() {
    final keyValueStorageService = ref.watch(keyValueStorageServiceProvider);
    Future.microtask(() => _loadColorFromPrefs(keyValueStorageService));

    return colorSeed;
  }

  Future<void> _loadColorFromPrefs(
      KeyValueStorageService keyValueStorageService) async {
    final color = Color(
        await keyValueStorageService.getValue<int>(_colorSeed) ??
            colorSeed.value);
    state = color;
  }

  void resetColor() {
    changeColorSeed(colorSeed);
  }

  void changeColorSeed(Color newColor) {
    final keyValueStorageService = ref.read(keyValueStorageServiceProvider);
    state = newColor;
    _saveColorToPrefs(keyValueStorageService, newColor);
  }

  Future<void> _saveColorToPrefs(
      KeyValueStorageService keyValueStorageService, Color newColor) async {
    await keyValueStorageService.setKeyValue<int>(_colorSeed, newColor.value);
  }
}

@Riverpod(dependencies: [keyValueStorageService])
class ThemeNotifier extends _$ThemeNotifier {
  static const String _isDarkMode = 'isDarkMode';

  @override
  ThemeMode build() {
    // Usar ref.watch para obtener el servicio de almacenamiento
    final keyValueStorageService = ref.watch(keyValueStorageServiceProvider);

    // Intentar cargar el modo de tema guardado
    Future.microtask(() => _loadThemeFromPrefs(keyValueStorageService));

    return ThemeMode.light;
  }

  void toggleTheme() {
    // Cambiar entre modo claro y oscuro
    final newTheme =
        (state == ThemeMode.light) ? ThemeMode.dark : ThemeMode.light;

    // Usar ref.read para obtener el servicio de almacenamiento
    final keyValueStorageService = ref.read(keyValueStorageServiceProvider);

    // Actualizar el estado
    state = newTheme;

    // Guardar la selección de tema
    _saveThemeToPrefs(keyValueStorageService);
  }

  Future<void> _loadThemeFromPrefs(
      KeyValueStorageService keyValueStorageService) async {
    final isDark =
        await keyValueStorageService.getValue<bool>(_isDarkMode) ?? false;
    state = isDark ? ThemeMode.dark : ThemeMode.light;
  }

  Future<void> _saveThemeToPrefs(
      KeyValueStorageService keyValueStorageService) async {
    await keyValueStorageService.setKeyValue<bool>(
        _isDarkMode, state == ThemeMode.dark);
  }
}

// Definición de temas personalizados
class AppThemes {
  static ThemeData lightTheme([Color? seedColor]) => ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
        colorSchemeSeed: seedColor,
      );

  static ThemeData darkTheme([Color? seedColor]) => ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        colorSchemeSeed: seedColor,
      );
}

// Provider para el servicio de almacenamiento
// la diferencia es que en minúsculas viene con autodispose, pero en mayúsculas
// puedes especificar ese comportamiento entre paréntesis
@Riverpod(keepAlive: true, dependencies: [])
KeyValueStorageService keyValueStorageService(Ref ref) {
  return KeyValueStorageServiceImpl();
}
