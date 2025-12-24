import 'package:college_admin/ui/student/student_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'models/enums.dart';
import 'ui/auth/login_page.dart';
import 'ui/admin/admin_layout.dart';
import 'ui/lecturer/lecturer_layout.dart';

class CollegeApp extends StatelessWidget {
  // FIX: Ensure this constructor is 'const'
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
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, child) {
        // 1. Show Loading Indicator while checking token
        if (auth.isAppLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // 2. If not logged in, show Login Page
        if (!auth.isAuthenticated) {
          return const LoginPage();
        }

        // 3. If logged in, check role
        final user = auth.user;

        if (user?.role == UserRole.admin) {
          return const AdminLayout();
        } else if (user?.role == UserRole.lecturer) {
          return const LecturerLayout();
        } else {
          return const StudentLayout();
        }
      },
    );
  }
}