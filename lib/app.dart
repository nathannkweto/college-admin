import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:college_admin/features/auth/providers/auth_provider.dart';
import 'models/enums.dart';
import 'package:college_admin/features/auth/login_page.dart';
import 'package:college_admin/features/admin/ui/admin_layout.dart';
import 'package:college_admin/features/student/ui/student_layout.dart';

class CollegeApp extends StatelessWidget {
  const CollegeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MATEM',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      // REMOVE the builder from here. It causes the "No Overlay" error.

      // AuthWrapper now handles the logic AND the SelectionArea
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    // WRAP EVERYTHING HERE IN SELECTIONAREA
    // Now it is inside the Navigator, so it can find the Overlay!
    return SelectionArea(
      child: _buildContent(authState),
    );
  }

  // Helper method to keep the build method clean
  Widget _buildContent(AuthState authState) {
    // 1. Check Loading
    if (authState.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // 2. Check Authentication
    if (!authState.isAuthenticated) {
      return const LoginPage();
    }

    // 3. Check Role
    switch (authState.role) {
      case UserRole.admin:
        return const AdminLayout();
      case UserRole.lecturer:
        return const AdminLayout();
      case UserRole.student:
        return const StudentLayout();
      default:
        return const StudentLayout();
    }
  }
}