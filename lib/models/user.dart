import 'enums.dart';

class AppUser {
  final int dbId;
  final String email;
  final UserRole role;
  // Password is mostly for backend, but if needed locally:
  final String? passwordHash;

  AppUser({
    required this.dbId,
    required this.email,
    required this.role,
    this.passwordHash,
  });
}