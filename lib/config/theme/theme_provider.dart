import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import '../../features/shared/shared.dart';

const colorSeed = Color(0xff424CB8);
const scaffoldBackgroundColor = Color(0xFFF8F7F7);

// Provider para manejar el estado del tema
final themeNotifierProvider =
    NotifierProvider<ThemeNotifier, ThemeMode>(ThemeNotifier.new);

class ThemeNotifier extends Notifier<ThemeMode> {
  late final KeyValueStorageService keyValueStorageService;
  static const String _isDarkMode = 'isDarkMode';

  // Método para inicializar el tema
  @override
  ThemeMode build() {
    keyValueStorageService = KeyValueStorageServiceImpl();
    // Intentar cargar el modo de tema guardado
    Future.microtask(_loadThemeFromPrefs);
    return ThemeMode.light;
  }

  // Cambiar entre modo claro y oscuro
  void toggleTheme() {
    state = (state == ThemeMode.light) ? ThemeMode.dark : ThemeMode.light;

    // Guardar la selección de tema
    _saveThemeToPrefs();
  }

  // Cargar el tema
  Future<ThemeMode> _loadThemeFromPrefs() async {
    final isDark =
        await keyValueStorageService.getValue<bool>(_isDarkMode) ?? false;

    return isDark ? ThemeMode.dark : ThemeMode.light;
  }

  // Guardar el tema
  Future<void> _saveThemeToPrefs() async {
    await keyValueStorageService.setKeyValue<bool>(
        _isDarkMode, state == ThemeMode.dark);
  }
}

// Definición de temas personalizados
class AppThemes {
  // Tema claro
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    colorSchemeSeed: colorSeed,
    useMaterial3: true,

    ///* Scaffold Background Color
    // scaffoldBackgroundColor: scaffoldBackgroundColor,
    ///* Personaliza más propiedades del tema claro
  );

  // Tema oscuro
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorSchemeSeed: colorSeed,
    useMaterial3: true,

    ///* Scaffold Background Color
    // scaffoldBackgroundColor: scaffoldBackgroundColor,
    ///* Personaliza más propiedades del tema oscuro
  );
}
