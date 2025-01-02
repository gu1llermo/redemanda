import '../entities/user_entity.dart';

abstract class AuthDatasource {
  Future<UserEntity> login(String email, String password);
  Future<void> logout();
  Future<UserEntity> checkAuthStatus(String token);
  // void dispose();
}
