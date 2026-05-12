import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:college_admin/core/services/api_service.dart';
import 'package:college_admin/models/enums.dart';
import 'package:core_api/api.dart' as core;

class AuthException implements Exception {}
class InvalidCredentialsException extends AuthException {}
class NetworkException extends AuthException {}
class ServerException extends AuthException {}
class SessionRestoreException extends AuthException {}

class AuthState {
  final bool isLoading;
  final core.User? user;

  const AuthState({
    this.isLoading = true,
    this.user,
  });

  bool get isAuthenticated => user != null;

  UserRole get role {
    final r = user?.role?.toString().toUpperCase();
    if (r == 'ADMIN') return UserRole.admin;
    if (r == 'LECTURER') return UserRole.lecturer;
    return UserRole.student;
  }

  AuthState copyWith({
    bool? isLoading,
    core.User? user,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
    );
  }
}

final authProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<AuthState> {
  final _storage = const FlutterSecureStorage();
  final _api = ApiService();

  AuthNotifier() : super(const AuthState(isLoading: true)) {
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    try {
      final token = await _storage.read(key: 'auth_token');
      final userJson = await _storage.read(key: 'auth_user');

      if (token == null || userJson == null) {
        state = const AuthState(isLoading: false, user: null);
        return;
      }

      _api.setToken(token);

      final userMap = jsonDecode(userJson);
      final user = core.User.fromJson(userMap);

      state = AuthState(isLoading: false, user: user);
    } catch (_) {
      await logout();
      throw SessionRestoreException();
    }
  }

  //
  // 🔥 STRONGLY-TYPED LOGIN
  //
  Future<void> login(String email, String password) async {
    // 🔥 FIX: Removed state mutation here so AuthWrapper doesn't unmount the UI
    try {
      final request = core.LoginRequest(
        email: email,
        password: password,
      );

      final response = await _api.auth.login(
        loginRequest: request,
      );

      if (response == null || response.token == null || response.user == null) {
        throw ServerException();
      }

      final token = response.token!;
      final user = response.user!;

      await _storage.write(key: 'auth_token', value: token);
      _api.setToken(token);

      await _storage.write(
        key: 'auth_user',
        value: jsonEncode(user.toJson()),
      );

      // On success, update the state with the user
      state = AuthState(isLoading: false, user: user);

    } on core.ApiException catch (e) {
      // 🔥 FIX: Removed state mutation here. We just throw the error back to the UI.
      if (e.code == 401) {
        throw InvalidCredentialsException();
      } else if (e.code >= 500) {
        throw ServerException();
      } else {
        throw AuthException();
      }
    } catch (_) {
      // 🔥 FIX: Removed state mutation here as well.
      throw NetworkException();
    }
  }

  Future<void> logout() async {
    await _storage.delete(key: 'auth_token');
    await _storage.delete(key: 'auth_user');
    _api.setToken("");
    state = const AuthState(isLoading: false, user: null);
  }
}