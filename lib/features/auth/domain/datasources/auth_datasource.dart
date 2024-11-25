import '../entities/user_entity.dart';

abstract class AuthDatasource {
  Future<UserEntity> login(String email, String password);
  Future<UserEntity> checkAuthStatus(String token);
}
