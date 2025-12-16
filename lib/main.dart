import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'providers/auth_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        // Initialize AuthProvider and call init() to check for stored token
        ChangeNotifierProvider(
          create: (_) => AuthProvider()..init(),
        ),
      ],
      child: const CollegeApp(),
    ),
  );
}