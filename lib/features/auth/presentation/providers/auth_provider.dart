import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/domain.dart';
import '../../infrastructure/infrastructure.dart';

part 'auth_provider.g.dart';

class AuthConstants {
  static const tokenRefreshThreshold = Duration(minutes: 5);
  static const sessionDuration = Duration(hours: 1);
  static final errorMessages = _AuthErrorMessages();
}

class _AuthErrorMessages {
  final String defaultError = 'Error no controlado';
  final String sessionRefreshError = 'Error al renovar la sesión';
  final String networkError = 'Revise su conexión a internet';
}

@Riverpod(keepAlive: true, dependencies: [authRepository])
class Auth extends _$Auth {
  late final AuthRepository _authRepository;

  @override
  AuthStateApp build() {
    _authRepository = ref.read(authRepositoryProvider);

    // ref.onDispose(() {
    //   _authRepository.dispose();
    // });// no hace falta

    _initializeAuth();
    return AuthStateApp();
  }

  void _initializeAuth() {
    Future.microtask(() {
      _checkAuthStatus();
    });
  }

  Future<void> loginUser(String email, String password) async {
    try {
      final user = await _authRepository.login(email, password);
      _setLoggedUser(user);
    } on CustomError catch (e) {
      logout(e.errorMessage);
    } catch (e) {
      logout(AuthConstants.errorMessages.defaultError);
    }
  }

  Future<void> _checkAuthStatus() async {
    try {
      final user = await _authRepository.checkAuthStatus('fake_token');
      _setLoggedUser(user);
    } on AuthSessionMissingException {
      _updateAuthState(authStatus: AuthStatus.notAuthenticated);
    } on CustomError catch (e) {
      logout(e.errorMessage);
    } catch (e) {
      logout(e.toString());
    }
  }

  Future<void> _setLoggedUser(UserEntity user) async {
    _updateAuthState(
      user: user,
      authStatus: AuthStatus.authenticated,
    );
  }

  void _updateAuthState({
    AuthStatus? authStatus,
    UserEntity? user,
    String errorMessage = '',
  }) {
    state = state.copyWith(
      user: user,
      authStatus: authStatus,
      errorMessage: errorMessage,
    );
  }

  Future<void> logout([String? errorMessage]) async {
    try {
      await _authRepository.logout();
    } catch (e) {
      // no hace nada
    } finally {
      _updateAuthState(
        authStatus: AuthStatus.notAuthenticated,
        errorMessage: errorMessage ?? '',
      );
    }
  }
}

class AuthStateApp {
  final AuthStatus authStatus;
  final UserEntity? user;
  final String errorMessage;

  AuthStateApp({
    this.authStatus = AuthStatus.checking,
    this.user,
    this.errorMessage = '',
  });

  AuthStateApp copyWith({
    AuthStatus? authStatus,
    UserEntity? user,
    String? errorMessage,
  }) =>
      AuthStateApp(
        authStatus: authStatus ?? this.authStatus,
        user: user ?? this.user,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}

enum AuthStatus { checking, authenticated, notAuthenticated }

@Riverpod(dependencies: [])
SupabaseClient supabaseClient(Ref ref) => Supabase.instance.client;

@Riverpod(keepAlive: true, dependencies: [supabaseClient])
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(
      SupabaseAuthDatasourceImpl(ref.read(supabaseClientProvider)));
}
