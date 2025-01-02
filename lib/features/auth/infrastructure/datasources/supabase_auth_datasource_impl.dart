import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../config/config.dart';
import '../../domain/domain.dart';
import '../../presentation/providers/providers.dart';
import '../errors/auth_errors.dart';
import '../mappers/user_entity_mapper.dart';

class SupabaseAuthDatasourceImpl extends AuthDatasource {
  final SupabaseClient supabase;
  Timer? _refreshTimer;
  final _authStateController = StreamController<AuthState>.broadcast();

  SupabaseAuthDatasourceImpl(this.supabase) {
    _initializeAuthListener();
  }

  Stream<AuthState> get onAuthStateChange => _authStateController.stream;

  void _initializeAuthListener() {
    supabase.auth.onAuthStateChange.listen(
      (event) {
        _authStateController.add(event);
        _handleAuthStateChange(event);
      },
    );
  }

  void _handleAuthStateChange(AuthState authState) {
    final authEvent = authState.event;
    final session = authState.session;

    switch (authEvent) {
      case AuthChangeEvent.signedIn:
        if (session != null) _startRefreshTimer(session);
        break;
      case AuthChangeEvent.signedOut:
        _cleanupResources();
        break;
      case AuthChangeEvent.tokenRefreshed:
        if (session != null) {
          _startRefreshTimer(session);
        }
        break;
      default:
        break;
    }
  }

  void _startRefreshTimer(Session session) {
    _refreshTimer?.cancel();

    final timeUntilRefresh = _calculateRefreshTime(session);

    if (timeUntilRefresh.isNegative) {
      _refreshSession();
    } else {
      _refreshTimer = Timer(timeUntilRefresh, _refreshSession);
    }
  }

  Duration _calculateRefreshTime(Session session) {
    final now = DateTime.now().toUtc();
    final expiresAt =
        DateTime.fromMillisecondsSinceEpoch(session.expiresAt! * 1000).toUtc();
    return expiresAt.difference(now) - const Duration(minutes: 5);
  }

  Future<void> _refreshSession() async {
    try {
      await supabase.auth.refreshSession();
    } catch (e) {
      // Handle refresh error
      throw CustomError(AuthConstants.errorMessages.sessionRefreshError);
    }
  }

  void _cleanupResources() {
    _refreshTimer?.cancel();
  }

  @override
  Future<UserEntity> login(String email, String password) async {
    try {
      final authResponse = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      return UserEntityMapper.authResponseToEntity(authResponse);
    } on AuthApiException catch (e) {
      throw CustomError(e.message);
    } on AuthRetryableFetchException {
      throw CustomError(AuthConstants.errorMessages.networkError);
    } catch (e) {
      throw CustomError(AuthConstants.errorMessages.defaultError);
    }
  }

  @override
  Future<UserEntity> checkAuthStatus(String token) async {
    try {
      final authResponse = await supabase.auth.refreshSession();
      return UserEntityMapper.authResponseToEntity(authResponse);
    } on AuthException catch (e) {
      throw CustomError(e.message);
    } catch (e) {
      throw CustomError(AuthConstants.errorMessages.defaultError);
    }
  }

  @override
  Future<void> logout() async {
    try {
      await supabase.auth.signOut();
      _cleanupResources();
    } catch (e) {
      throw CustomError(e.toString());
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await supabase.auth.resetPasswordForEmail(
        email,
        redirectTo: '${BaseUrlApp.baseUrl}/reset-password',
      );
    } on AuthException catch (e) {
      throw CustomError(e.message);
    } catch (e) {
      throw CustomError(AuthConstants.errorMessages.defaultError);
    }
  }

  @override
  Future<void> resetPassword(String newPassword) async {
    try {
      await supabase.auth.updateUser(
        UserAttributes(
          password: newPassword,
        ),
      );
    } on AuthException catch (e) {
      throw CustomError(e.message);
    } catch (e) {
      throw CustomError(AuthConstants.errorMessages.defaultError);
    }
  }
}
