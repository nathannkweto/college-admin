import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';
import 'package:college_admin/core/services/api_service.dart';
import 'package:college_admin/core/services/navigator_service.dart'; // Ensure navigatorKey is here
import 'package:college_admin/features/auth/providers/auth_provider.dart'; // Path to your auth provider
import 'config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Create the Riverpod Container
  final container = ProviderContainer();

  // 2. Initialize API Service with the logout callback
  ApiService().init(
    baseUrl: Config.baseUrl,
    onUnauthorized: () async {
      // Clear Riverpod state & Secure Storage
      await container.read(authProvider.notifier).logout();
      
      // Navigate to Login and clear route history
      navigatorKey.currentState?.pushNamedAndRemoveUntil('/login', (route) => false);
    },
  );

  runApp(
    // 3. Wrap app in UncontrolledProviderScope using our container
    UncontrolledProviderScope(
      container: container,
      child: const CollegeApp(),
    ),
  );
}