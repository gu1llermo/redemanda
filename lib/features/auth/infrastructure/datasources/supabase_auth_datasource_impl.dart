import 'package:dio/dio.dart';
import 'package:redemanda/features/auth/infrastructure/errors/auth_errors.dart';
import 'package:redemanda/features/auth/infrastructure/mappers/user_entity_mapper.dart';
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
      // authOptions: FlutterAuthClientOptions(),
    );
    supabase = Supabase.instance.client;
  }

  @override
  Future<UserEntity> login(String email, String password) async {
    try {
      final authResponse = await supabase.auth
          .signInWithPassword(password: password, email: email);

      final userEntity = UserEntityMapper.authResponseToEntity(authResponse);
      return userEntity;
    } on AuthApiException catch (e) {
      throw CustomError(e.message);
    } on AuthRetryableFetchException catch (_) {
      throw CustomError('Revise su conexión a internet');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserEntity> checkAuthStatus(String token) async {
    try {
      // es cuestión de probar sin colocarle el token ó refresh token allí,
      // ya que lo gestiona localmente la misma librería de supabase
      // tiene que ser el refreshtoken
      final authResponse =
          await supabase.auth.refreshSession(); // vamos a quitarlo nuevamente
      // auqnue también puedo manejar la persistencia
      // final authResponse =
      //     await supabase.auth.refreshSession(token.isNotEmpty ? token : null);
      // cuando no existe una sesión en el equipo, la respuesta es un error
      // final authResponse = await supabase.auth.refreshSession(token);

      final userEntity = UserEntityMapper.authResponseToEntity(authResponse);

      return userEntity;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    await supabase.auth.signOut().onError(
      (error, stackTrace) {
        throw CustomError(error.toString());
      },
    );
  }
}
