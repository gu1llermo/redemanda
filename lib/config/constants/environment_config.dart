import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvironmentConfig {
  static final EnvironmentConfig _instance = EnvironmentConfig._internal();
  factory EnvironmentConfig() => _instance;
  EnvironmentConfig._internal();

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

  // Mapa constante para valores en GitHub Pages
  static const _githubPagesValues = {
    'SUPABASE_URL': String.fromEnvironment('SUPABASE_URL'),
    'SUPABASE_ANON_KEY': String.fromEnvironment('SUPABASE_ANON_KEY'),
    'DATA_BASE_PASSWORD': String.fromEnvironment('DATA_BASE_PASSWORD'),
  };

  static String _getValue(String key) {
    if (isGithubPages) {
      return _githubPagesValues[key] ?? '';
    }
    return dotenv.env[key] ?? '';
  }

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
}
