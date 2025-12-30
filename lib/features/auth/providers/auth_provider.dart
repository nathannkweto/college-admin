import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:college_admin/core/services/api_service.dart';
import 'package:college_admin/models/enums.dart';

// STRICTLY IMPORT CORE_API
import 'package:core_api/api.dart' as core;

// 1. State Object
class AuthState {
  final bool isLoading;
  final core.User? user;

  const AuthState({this.isLoading = true, this.user});

  bool get isAuthenticated => user != null;

  UserRole get role {
    final r = user?.role?.toString().toUpperCase();
    if (r == 'ADMIN') return UserRole.admin;
    if (r == 'LECTURER') return UserRole.lecturer;
    return UserRole.student;
  }

  AuthState copyWith({bool? isLoading, core.User? user}) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
    );
  }
}

// 2. Provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

// 3. Notifier
class AuthNotifier extends StateNotifier<AuthState> {
  final _storage = const FlutterSecureStorage();

  AuthNotifier() : super(const AuthState(isLoading: true)) {
    checkLoginStatus();
  }

  /// RESTORE SESSION
  Future<void> checkLoginStatus() async {
    print("DEBUG: Checking Login Status...");
    try {
      final token = await _storage.read(key: 'auth_token');
      final userJson = await _storage.read(key: 'auth_user');

      print("DEBUG: Token found? ${token != null}");
      print("DEBUG: User JSON found? ${userJson != null}");

      if (token != null && userJson != null) {
        // 1. Set Token
        ApiService().setToken(token);

        // 2. Try to restore User
        try {
          final userMap = jsonDecode(userJson);
          print("DEBUG: JSON Decoded successfully: $userMap");

          final userObj = core.User.fromJson(userMap);

          if (userObj == null) throw Exception("User object resulted in null");

          print("DEBUG: User Object restored: ${userObj.email}");

          state = AuthState(isLoading: false, user: userObj);
        } catch (parseError) {
          print("CRITICAL ERROR restoring user from JSON: $parseError");
          // If the JSON is bad, we must log them out to clear the bad data
          await logout();
        }
      } else {
        print("DEBUG: No session found. Setting unauthenticated.");
        state = const AuthState(isLoading: false, user: null);
      }
    } catch (e) {
      print("DEBUG: General error in checkLoginStatus: $e");
      state = const AuthState(isLoading: false, user: null);
    }
  }

  /// LOGIN
  Future<String?> login(String email, String password) async {
    print("DEBUG: Starting Login...");
    state = state.copyWith(isLoading: true);

    try {
      final request = core.LoginRequest(email: email, password: password);

      // 1. Get the Raw Response so we can read the fields manually
      final rawResponse = await ApiService().auth.loginWithHttpInfo(
        loginRequest: request,
      );

      if (rawResponse.statusCode == 200) {
        // 2. Decode the JSON string manually
        final Map<String, dynamic> data = jsonDecode(rawResponse.body);
        print("DEBUG: Manual Decode: $data");

        final token = data['token'] as String?;

        if (token != null) {
          // 3. Save Token
          await _storage.write(key: 'auth_token', value: token);
          ApiService().setToken(token);

          // 4. Manually Construct the User Object
          // The backend didn't give us the email back, so we use the one the user typed.
          // The role comes as a simple string, we need to map it to the Enum.

          final roleString =
              data['role']?.toString().toUpperCase() ?? 'STUDENT';

          // Map string to Enum manually to avoid parser errors
          core.UserRoleEnum roleEnum;
          if (roleString == 'ADMIN')
            roleEnum = core.UserRoleEnum.ADMIN;
          else if (roleString == 'LECTURER')
            roleEnum = core.UserRoleEnum.LECTURER;
          else
            roleEnum = core.UserRoleEnum.STUDENT;

          final userObj = core.User(
            email: email, // Use the input email
            profilePublicId: data['profile_public_id'],
            role: roleEnum,
          );

          print("DEBUG: User Constructed: ${userObj.email} - ${userObj.role}");

          // 5. Save User & Update State
          await _storage.write(
            key: 'auth_user',
            value: jsonEncode(userObj.toJson()),
          );
          state = AuthState(isLoading: false, user: userObj);

          return null; // Success! Navigation will happen now.
        } else {
          state = state.copyWith(isLoading: false);
          return "Login successful, but Token is missing.";
        }
      } else {
        // Handle 401, 500, etc.
        state = state.copyWith(isLoading: false);
        final Map<String, dynamic> errorData = jsonDecode(rawResponse.body);
        return errorData['message'] ??
            "Server Error: ${rawResponse.statusCode}";
      }
    } catch (e) {
      print("CRITICAL ERROR: $e");
      state = state.copyWith(isLoading: false);
      return "Error: $e";
    }
  }

  /// LOGOUT
  Future<void> logout() async {
    print("DEBUG: Logging out...");
    await _storage.delete(key: 'auth_token');
    await _storage.delete(key: 'auth_user');
    ApiService().setToken("");
    state = const AuthState(isLoading: false, user: null);
  }
}
