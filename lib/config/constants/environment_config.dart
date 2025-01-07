import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Enum para ambientes
// enum Environment { development, production, staging }

class EnvironmentConfig {
  static final EnvironmentConfig _instance = EnvironmentConfig._internal();
  factory EnvironmentConfig() => _instance;
  EnvironmentConfig._internal();

  // static Environment get currentEnvironment {
  //   return Environment.development;
  // }

  static bool get isGithubPages {
    if (kIsWeb) {
      try {
        final host = Uri.base.host;
        return host.contains('github.io');
      } catch (e) {
        return false;
      }
    }
    return false;
  }

  // static String get supabaseUrl {
  //   const value = 'SUPABASE_URL';
  //   if (isGithubPages) {
  //     // En GitHub Pages, la variable se inyecta en tiempo de build
  //     return const String.fromEnvironment(value);
  //   }
  //   // En desarrollo local, usa .env
  //   return dotenv.env[value] ?? 'No hay valor';
  // }

  String get supabaseUrl {
    final value = _getValue('SUPABASE_URL');
    if (value.isEmpty) throw Exception('SUPABASE_URL es requerido');
    return value;
  }

  String get supabaseAnonKey {
    final value = _getValue('SUPABASE_ANON_KEY');
    if (value.isEmpty) throw Exception('SUPABASE_ANON_KEY es requerido');
    return value;
  }

  // static String get supabaseAnonKey {
  //   const value = 'SUPABASE_ANON_KEY';
  //   if (isGithubPages) {
  //     // En GitHub Pages, la variable se inyecta en tiempo de build
  //     return const String.fromEnvironment(value);
  //   }
  //   // En desarrollo local, usa .env
  //   return dotenv.env[value] ?? 'No hay valor';
  // }

  String get databasePassword {
    final value = _getValue('DATA_BASE_PASSWORD');
    if (value.isEmpty) throw Exception('DATA_BASE_PASSWORD es requerido');
    return value;
  }

  static Future<void> initialize() async {
    if (!isGithubPages) {
      await dotenv.load();
    }
  }

  static String _getValue(String key) {
    if (isGithubPages) {
      // No podemos usar const String.fromEnvironment con un parámetro no constante
      // Usamos String.fromEnvironment sin const
      return String.fromEnvironment(key);
    }
    return dotenv.env[key] ?? 'No hay valor';
  }
}
