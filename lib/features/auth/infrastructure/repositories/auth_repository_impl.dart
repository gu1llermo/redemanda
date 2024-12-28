import '../../domain/domain.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDatasource datasource;

  AuthRepositoryImpl(this.datasource);
  // AuthRepositoryImpl([AuthDatasource? datasource])
  //     : datasource = datasource ?? SupabaseAuthDatasourceImpl();

  @override
  Future<UserEntity> login(String email, String password) {
    return datasource.login(email, password);
  }

  @override
  Future<UserEntity> checkAuthStatus(String token) {
    return datasource.checkAuthStatus(token);
  }

  @override
  Future<void> logout() {
    return datasource.logout();
  }
}
