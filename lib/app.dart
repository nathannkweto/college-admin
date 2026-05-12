import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:college_admin/features/auth/providers/auth_provider.dart';
import 'models/enums.dart';
import 'package:college_admin/features/auth/login_page.dart';
import 'package:college_admin/features/admin/ui/admin_layout.dart';
import 'package:college_admin/features/student/ui/student_layout.dart';
import 'package:college_admin/features/lecturer/ui/lecturer_layout.dart';
import 'core/services/navigator_service.dart';

class CollegeApp extends StatelessWidget {
  const CollegeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'MATEM',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 2, 52, 108)),
        useMaterial3: true,
      ),
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return _buildContent(authState);
  }

  Widget _buildContent(AuthState authState) {
    // 1. Initial Boot / Loading State
    if (authState.isLoading) {
      return const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // A little UX polish: showing the app name during boot is 
              // much better than a random spinner on a blank screen.
              Text(
                "MATEM College",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey),
              ),
              SizedBox(height: 24),
              CircularProgressIndicator(),
            ],
          ),
        ),
      );
    }

    // 2. Not Authenticated -> Show Login
    if (!authState.isAuthenticated) {
      return const LoginPage();
    }

    // 3. Authenticated -> Route by Role
    switch (authState.role) {
      case UserRole.admin:
        return const AdminLayout();
      case UserRole.lecturer:
        return const LecturerLayout();
      case UserRole.student:
        return const StudentLayout();
    }
  }
}