import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/domain.dart';

class UserEntityMapper {
  static UserEntity userJsonToEntity(Map<String, dynamic> json) => UserEntity(
        id: json['id'],
        email: json['email'],
        fullName: json['fullName'],
        role: json['role'],
        token: json['token'] ?? '',
        refreshToken: json['refreshToken'],
        tokenExpiresAt: json['tokenExpiresAt'] != null
            ? DateTime.parse(json['tokenExpiresAt'])
            : null,
        // si no viene el token le colocamos un String vacío
      );
  static UserEntity authResponseToEntity(AuthResponse authResponse) {
    final session = authResponse.session!;
    final user = session.user;
    return UserEntity(
      id: user.id,
      email: user.email!, // siempre tiene que tener un email
      fullName: user.userMetadata?['fullName'] ?? 'no-name',
      role: user.userMetadata?['role'] ?? 'user',
      token: session.accessToken,
      refreshToken: session.refreshToken,
      tokenExpiresAt: session.expiresAt != null
          ? DateTime.fromMillisecondsSinceEpoch(session.expiresAt! * 1000)
          : null,
      // si no viene el token le colocamos un String vacío
    );
  }

  // Método factory para crear desde una sesión de Supabase
  static UserEntity fromSupabaseSession(Session session) {
    final user = session.user;
    return UserEntity(
      id: user.id,
      email: user.email ?? '',
      fullName: user.userMetadata?['full_name'] ?? '',
      role: user.userMetadata?['role'] ?? 'user',
      token: session.accessToken,
      refreshToken: session.refreshToken,
      tokenExpiresAt: session.expiresAt != null
          ? DateTime.fromMillisecondsSinceEpoch(session.expiresAt! * 1000)
          : null,
    );
  }
}
