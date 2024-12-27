import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/domain.dart';
import '../../infrastructure/infrastructure.dart';

part 'auth_provider.g.dart';

@Riverpod(keepAlive: true, dependencies: [authRepository])
class Auth extends _$Auth {
  // Creamos métodos privados para manejar los repositorios
  // AuthRepository get _authRepository => AuthRepositoryImpl();
  // KeyValueStorageService get _keyValueStorageService =>
  //     KeyValueStorageServiceImpl();
  // final String _token = 'token';

  @override
  AuthState build() {
    //ref.watch(authRepositoryProvider);

    // Posterga la ejecución del chequeo de estado de autenticación
    Future.microtask(_checkAuthStatus);
    return AuthState();
  }

  Future<void> loginUser(String email, String password) async {
    try {
      final authRepository = ref.read(authRepositoryProvider);
      final user = await authRepository.login(email, password);
      // final user = await _authRepository.login(email, password);
      _setLoggedUser(user);
    } on CustomError catch (e) {
      logout(e.errorMessage);
    } catch (e) {
      logout('Error no controlado');
    }
  }

  Future<void> _checkAuthStatus() async {
    try {
      // final keyValueStorageService = ref.read(keyValueStorageServiceProvider);
      // final String token = await _loadTokenFromPrefs(keyValueStorageService);

      // Pasando 'token' para mantener la interfaz
      // (la implementación de supabase maneja esto internamente)
      final authRepository = ref.read(authRepositoryProvider);
      final user = await authRepository.checkAuthStatus('fake_token');

      _setLoggedUser(user);
    } on AuthSessionMissingException catch (_) {
      //no consiguió sesión válida
      state = state.copyWith(
        user: null,
        authStatus: AuthStatus.notAuthenticated,
        //errorMessage: '',
      );
    } catch (e) {
      logout();
    }
  }

  // Future<void> _saveTokenToPrefs(
  //     KeyValueStorageService keyValueStorageService, String? token) async {
  //   if (token == null) return;
  //   await keyValueStorageService.setKeyValue<String>(_token, token);
  // }

  // Future<String> _loadTokenFromPrefs(
  //     KeyValueStorageService keyValueStorageService) async {
  //   // final themeMode = ref.read(themeNotifierProvider);

  //   // final isDarkMode = themeMode == ThemeMode.dark;

  //   var token = await keyValueStorageService.getValue<String>(_token);
  //   token = token ?? '';
  //   debugPrint('Hola');
  //   return token;
  // }

  Future<void> _setLoggedUser(UserEntity user) async {
    // final keyValueStorageService = ref.read(keyValueStorageServiceProvider);
    // final token = user.refreshToken;
    // await _saveTokenToPrefs(keyValueStorageService, token);

    state = state.copyWith(
      user: user,
      authStatus: AuthStatus.authenticated,
      errorMessage: '',
    );
  }

  // Future<void> removeRefreshToken() async {
  //   final keyValueStorageService = ref.read(keyValueStorageServiceProvider);
  //   await keyValueStorageService.removeKey(_token);
  // }

  Future<void> logout([String? errorMessage]) async {
    final authRepository = ref.read(authRepositoryProvider);
    await authRepository.logout();

    state = state.copyWith(
      user: null,
      authStatus: AuthStatus.notAuthenticated,
      errorMessage: errorMessage,
    );
  }
}

// Enum y clase de estado se mantienen igual
enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthState {
  final AuthStatus authStatus;
  final UserEntity? user;
  final String errorMessage;

  AuthState({
    this.authStatus = AuthStatus.checking,
    this.user,
    this.errorMessage = '',
  });

  AuthState copyWith({
    AuthStatus? authStatus,
    UserEntity? user,
    String? errorMessage,
  }) =>
      AuthState(
        authStatus: authStatus ?? this.authStatus,
        user: user ?? this.user,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}

@Riverpod(dependencies: [])
SupabaseClient supabaseClient(Ref ref) {
  return Supabase.instance.client;
}

@Riverpod(keepAlive: true, dependencies: [supabaseClient])
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(
      SupabaseAuthDatasourceImpl(ref.read(supabaseClientProvider)));
}
