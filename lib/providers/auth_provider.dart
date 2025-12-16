import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // For debugPrint
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/user.dart';
import '../models/enums.dart';
import '../services/api_service.dart';

class AuthProvider extends ChangeNotifier {
  // Storage for persisting user details (Role, Email, ID)
  final _storage = const FlutterSecureStorage();

  AppUser? _user;

  // 'isAppLoading' controls the initial Splash Screen
  bool _isAppLoading = true;
  // 'isLoading' controls the Login Button spinner
  bool _isLoading = false;

  AppUser? get user => _user;
  bool get isAppLoading => _isAppLoading;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _user != null;

  /// 1. Initialize App (Auto-Login)
  Future<void> init() async {
    try {
      final token = await ApiService.loadToken();

      if (token != null) {
        // Token exists, let's try to restore the user session
        final email = await _storage.read(key: 'user_email');
        final roleString = await _storage.read(key: 'user_role');
        final idString = await _storage.read(key: 'user_id');

        if (email != null && roleString != null) {
          // Reconstruct user from local storage
          _user = AppUser(
            dbId: int.tryParse(idString ?? '0') ?? 0,
            email: email,
            role: _parseRole(roleString),
          );
        } else {
          // If we have a token but no user details, force logout to be safe
          await logout();
        }
      }
    } catch (e) {
      debugPrint("Auto-login failed: $e");
      await logout();
    } finally {
      _isAppLoading = false;
      notifyListeners();
    }
  }

  /// 2. Login Logic
  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      // A. Call API
      final response = await ApiService.post('/auth/login', {
        'email': email,
        'password': password,
      });

      // --- DEBUGGING: Print what the server actually sent ---
      debugPrint("LOGIN RESPONSE: $response");

      // B. Extract Data
      final token = response['access_token'];
      final userData = response['user'] ?? {};

      // C. Smart Role Detection
      // Check root 'role', then 'user.role', then default to 'student'
      String roleString = response['role']?.toString()
          ?? userData['role']?.toString()
          ?? "student";

      debugPrint("PARSED ROLE: $roleString");

      // D. Parse User ID safely
      final userId = userData['id'] is int
          ? userData['id']
          : int.tryParse(userData['id'].toString()) ?? 0;

      // E. Save Everything to Storage (so auto-login works)
      await ApiService.setToken(token);
      await _storage.write(key: 'user_email', value: userData['email'] ?? email);
      await _storage.write(key: 'user_role', value: roleString);
      await _storage.write(key: 'user_id', value: userId.toString());

      // F. Update State
      _user = AppUser(
        dbId: userId,
        email: userData['email'] ?? email,
        role: _parseRole(roleString),
      );

      debugPrint("LOGGED IN AS: ${_user?.role}");

      notifyListeners();
    } catch (e) {
      debugPrint("Login Exception: $e");
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// 3. Logout
  Future<void> logout() async {
    _user = null;
    // Clear everything
    await ApiService.setToken(null);
    await _storage.deleteAll();
    notifyListeners();
  }

  /// Helper: Convert String to Enum safely
  UserRole _parseRole(String roleString) {
    switch (roleString.toLowerCase().trim()) {
      case 'admin':
      case 'administrator': // Handle variations
        return UserRole.admin;
      case 'lecturer':
      case 'teacher':
      case 'faculty':
        return UserRole.lecturer;
      default:
        return UserRole.student;
    }
  }
}