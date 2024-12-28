class UserEntity {
  final String id;
  final String email;
  final String fullName;
  final String role;
  final String token;
  final String? refreshToken;
  final DateTime? tokenExpiresAt; // Nuevo campo para manejar la expiración

  UserEntity({
    required this.id,
    required this.email,
    required this.fullName,
    required this.role,
    required this.token,
    required this.refreshToken,
    this.tokenExpiresAt,
  });

  bool get isAdmin {
    return role.contains('admin');
  }

  // Método para verificar si el token está próximo a expirar
  bool get isTokenExpiringSoon {
    if (tokenExpiresAt == null) return false;
    final now = DateTime.now().toUtc();
    final timeUntilExpiry = tokenExpiresAt!.difference(now);
    return timeUntilExpiry.inMinutes <= 5; // 5 minutos antes de expirar
  }

  // Método para crear una copia con nuevos valores
  UserEntity copyWith({
    String? id,
    String? email,
    String? fullName,
    String? role,
    String? token,
    String? refreshToken,
    DateTime? tokenExpiresAt,
  }) {
    return UserEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      role: role ?? this.role,
      token: token ?? this.token,
      refreshToken: refreshToken ?? this.refreshToken,
      tokenExpiresAt: tokenExpiresAt ?? this.tokenExpiresAt,
    );
  }
}
