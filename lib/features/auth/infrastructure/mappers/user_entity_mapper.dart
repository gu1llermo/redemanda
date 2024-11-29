import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/domain.dart';

class UserEntityMapper {
  static UserEntity userJsonToEntity(Map<String, dynamic> json) => UserEntity(
        id: json['id'],
        email: json['email'],
        fullName: json['fullName'],
        role: json['role'],
        token: json['token'] ?? '',
        // si no viene el token le colocamos un String vacío
      );
  static UserEntity authResponseToEntity(AuthResponse authResponse) {
    final session = authResponse.session!;
    final user = session.user;
    return UserEntity(
      id: user.id,
      email: user.email!, // siempre tiene que tener un email
      fullName: user.userMetadata?['fullname'] ?? 'no-name',
      role: user.userMetadata?['role'] ?? 'user',
      token: session.accessToken,
      // si no viene el token le colocamos un String vacío
    );
  }
}
