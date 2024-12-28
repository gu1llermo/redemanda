import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redemanda/features/auth/infrastructure/mappers/user_entity_mapper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/domain.dart';
import '../../infrastructure/infrastructure.dart';

part 'auth_provider.g.dart';

@Riverpod(keepAlive: true, dependencies: [authRepository, supabaseClient])
class Auth extends _$Auth {
  Timer? _refreshTimer;
  // Definir constantes para el manejo del tiempo
  static const tokenRefreshThreshold =
      Duration(minutes: 5); // Renovar 5 minutos antes
  static const sessionDuration = Duration(hours: 1); // Duración total del token

  @override
  AuthState build() {
    ref.onDispose(() {
      _refreshTimer?.cancel();
    });

    Future.microtask(() {
      _checkAuthStatus();
      _initializeAuthListener();
    });

    return AuthState();
  }

  void _initializeAuthListener() {
    final supabase = ref.read(supabaseClientProvider);
    supabase.auth.onAuthStateChange.listen((data) {
      final AuthChangeEvent event = data.event;
      final Session? session = data.session;

      switch (event) {
        case AuthChangeEvent.signedIn:
          if (session != null) _startRefreshTimer(session);
          break;
        case AuthChangeEvent.signedOut:
          _refreshTimer?.cancel();
          break;
        case AuthChangeEvent.tokenRefreshed:
          if (session != null) {
            _setLoggedUser(UserEntityMapper.fromSupabaseSession(session));
            _startRefreshTimer(session);
          }
          break;
        default:
          break;
      }
    });
  }

  void _startRefreshTimer(Session session) {
    _refreshTimer?.cancel();

    final now = DateTime.now().toUtc();
    final expiresAt =
        DateTime.fromMillisecondsSinceEpoch(session.expiresAt! * 1000).toUtc();
    final timeUntilRefresh = expiresAt.difference(now) - tokenRefreshThreshold;

    if (timeUntilRefresh.isNegative) {
      // Si ya está próximo a expirar, renovar inmediatamente
      _refreshSession();
    } else {
      _refreshTimer = Timer(timeUntilRefresh, _refreshSession);
    }
  }

  Future<void> _refreshSession() async {
    try {
      final supabase = ref.read(supabaseClientProvider);
      final response = await supabase.auth.refreshSession();

      if (response.session != null) {
        _setLoggedUser(UserEntityMapper.fromSupabaseSession(response.session!));
        // Reiniciar el timer para la siguiente renovación
        _startRefreshTimer(response.session!);
      }
    } catch (e) {
      // Si falla la renovación, intentar hacer logout
      logout('Error al renovar la sesión');
    }
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
