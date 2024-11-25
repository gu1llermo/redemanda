import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/shared.dart';
import '../../domain/domain.dart';
import '../../infrastructure/infrastructure.dart';

final authProvider =
    NotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);

class AuthNotifier extends Notifier<AuthState> {
  late final AuthRepository authRepository;
  late final KeyValueStorageService keyValueStorageService;
  static const String _token = 'token';

  @override
  AuthState build() {
    authRepository = AuthRepositoryImpl();
    keyValueStorageService = KeyValueStorageServiceImpl();

    // ahora sí tiene sentido, porque posterga la ejecución de éste chequeo
    // inmediatamente después que creé el estado inicial
    // como el token aún no se ha guardado
    // ésta función hará un logout
    Future.microtask(checkAuthStatus);
    return AuthState();
  }

  Future<void> loginUser(String email, String password) async {
    try {
      final user = await authRepository.login(email, password);
      _setLoggedUser(user);
    } on CustomError catch (e) {
      logout(e.errorMessage);
    } catch (e) {
      logout('Error no controlado');
    }
  }

  // Future<void> registerUser(
  //     String email, String password, String fullName) async {
  //   await Future.delayed(const Duration(milliseconds: 500));
  //   try {
  //     final user = await authRepository.register(email, password, fullName);
  //     _setLoggedUser(user);
  //   } on CustomError catch (e) {
  //     logout(e.errorMessage);
  //   } catch (e) {
  //     logout('Error no controlado');
  //   }
  // }

  Future<void> checkAuthStatus() async {
    // verificamos si tenemos un token
    final token = await keyValueStorageService.getValue<String>(_token);
    if (token == null) return logout();
    try {
      final user = await authRepository.checkAuthStatus(token);
      _setLoggedUser(user);
    }
    // on CustomError catch (e) {
    //   logout(e.errorMessage);
    // }
    catch (e) {
      logout();
    }
  }

  Future<void> _setLoggedUser(UserEntity user) async {
    // Guardamos el token físicamente
    await keyValueStorageService.setKeyValue<String>(_token, user.token);
    state = state.copyWith(
      user: user,
      authStatus: AuthStatus.authenticated,
      errorMessage: '',
    );
  }

  Future<void> logout([String? errorMessage]) async {
    // limpiar token
    keyValueStorageService.removeKey(_token);
    state = state.copyWith(
        user: null,
        authStatus: AuthStatus.notAuthenticated,
        errorMessage: errorMessage);
  }
}

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
