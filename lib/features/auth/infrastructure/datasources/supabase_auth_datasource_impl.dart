import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:redemanda/features/auth/infrastructure/errors/auth_errors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../config/config.dart';
import '../../domain/domain.dart';

class SupabaseAuthDatasourceImpl extends AuthDatasource {
  static late SupabaseClient supabase;

  final dio = Dio(BaseOptions(
    baseUrl: EnvironmentConfig.supabaseUrl,
  ));

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: EnvironmentConfig.supabaseUrl,
      anonKey: EnvironmentConfig.supabaseAnonKey,
    );
    supabase = Supabase.instance.client;
  }

  @override
  Future<UserEntity> login(String email, String password) async {
    try {
      final authResponse = await supabase.auth
          .signInWithPassword(password: password, email: email);
      if (authResponse.user == null) {
        throw CustomError('Credenciales incorrectas!');
      }
      debugPrint('acces token: ${authResponse.session?.accessToken}');
      debugPrint('refresh token: ${authResponse.session?.refreshToken}');
      debugPrint('id: ${authResponse.user?.id}');
      //final appMetadata = authResponse.user!.appMetadata;

      // claro tengo que crear un user deacuerdo a la respuesta recibida
      // para luego regtornarlo
      throw Exception();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserEntity> checkAuthStatus(String token) async {
    try {
      // es cuestión de probar sin colocarle el token ó refresh token allí,
      // ya que lo gestiona localmente la misma librería de supabase
      final authResponse = await supabase.auth.refreshSession(token);

      if (authResponse.user == null) {
        throw CustomError('Credenciales incorrectas!');
      }
      final appMetadata = authResponse.user!.appMetadata;

      // claro tengo que crear un user deacuerdo a la respuesta recibida
      // para luego regtornarlo
      throw Exception();
    } catch (e) {
      rethrow;
    }
  }
}
