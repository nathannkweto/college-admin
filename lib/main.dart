import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'app.dart';
import 'package:college_admin/core/services/api_service.dart';
import 'config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load .env file
  await dotenv.load(fileName: ".env");

  // Initialize API Service Global (Singleton)
  ApiService().init(baseUrl: Config.baseUrl);

  runApp(
    // Wrap the entire app in ProviderScope
    const ProviderScope(
      child: CollegeApp(),
    ),
  );
}
