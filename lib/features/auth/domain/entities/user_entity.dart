class UserEntity {
  final String id;
  final String email;
  final String fullName;
  final String role;
  final String token;
  final String? refreshToken;

  UserEntity({
    required this.id,
    required this.email,
    required this.fullName,
    required this.role,
    required this.token,
    required this.refreshToken,
  });
  bool get isAdmin {
    return role.contains('admin');
  }
}
