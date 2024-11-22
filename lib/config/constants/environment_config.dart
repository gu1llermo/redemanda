import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvironmentConfig {
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

  static String get supabaseUrl {
    const value = 'SUPABASE_URL';
    if (isGithubPages) {
      // En GitHub Pages, la variable se inyecta en tiempo de build
      return const String.fromEnvironment(value);
    }
    // En desarrollo local, usa .env
    return dotenv.env[value] ?? 'No hay valor';
  }

  static String get supabaseAnonKey {
    const value = 'SUPABASE_ANON_KEY';
    if (isGithubPages) {
      // En GitHub Pages, la variable se inyecta en tiempo de build
      return const String.fromEnvironment(value);
    }
    // En desarrollo local, usa .env
    return dotenv.env[value] ?? 'No hay valor';
  }

  static String get databasePassword {
    const value = 'DATA_BASE_PASSWORD';
    if (isGithubPages) {
      // En GitHub Pages, la variable se inyecta en tiempo de build
      return const String.fromEnvironment(value);
    }
    // En desarrollo local, usa .env
    return dotenv.env[value] ?? 'No hay valor';
  }

  static Future<void> initialize() async {
    if (!isGithubPages) {
      await dotenv.load();
    }
  }
}
