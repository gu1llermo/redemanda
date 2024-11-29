class UserEntity {
  final String id;
  final String email;
  final String fullName;
  final String role;
  final String token;

  UserEntity({
    required this.id,
    required this.email,
    required this.fullName,
    required this.role,
    required this.token,
  });
  bool get isAdmin {
    return role.contains('admin');
  }
}
