import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';
import 'package:college_admin/core/services/api_service.dart';
import 'config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Initialize API Service Global (Singleton)
  ApiService().init(baseUrl: Config.baseUrl);

  runApp(
    // 2. Wrap the entire app in ProviderScope
    const ProviderScope(
      child: CollegeApp(),
    ),
  );
}