import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/domain.dart';
import '../../infrastructure/infrastructure.dart';

part 'auth_provider.g.dart';

@Riverpod(keepAlive: true)
class Auth extends _$Auth {
  // Creamos métodos privados para manejar los repositorios
  // AuthRepository get _authRepository => AuthRepositoryImpl();
  // KeyValueStorageService get _keyValueStorageService =>
  //     KeyValueStorageServiceImpl();

  @override
  AuthState build() {
    ref.watch(authRepositoryProvider);
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
      // Pasando 'token' para mantener la interfaz
      // (la implementación de supabase maneja esto internamente)
      final authRepository = ref.read(authRepositoryProvider);
      final user = await authRepository.checkAuthStatus('token');
      // final user = await _authRepository.checkAuthStatus('token');
      _setLoggedUser(user);
    } catch (e) {
      logout();
    }
  }

  void _setLoggedUser(UserEntity user) {
    state = state.copyWith(
      user: user,
      authStatus: AuthStatus.authenticated,
      errorMessage: '',
    );
  }

  Future<void> logout([String? errorMessage]) async {
    final authRepository = ref.read(authRepositoryProvider);
    await authRepository.logout();
    // await _authRepository.logout();

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

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl();
}
