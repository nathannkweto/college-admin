import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;

  const ErrorView({super.key, required this.error, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 40),
          const SizedBox(height: 8),
          const Text("Error loading data", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(error.replaceAll("Exception:", "").trim(), textAlign: TextAlign.center),
          const SizedBox(height: 16),
          ElevatedButton.icon( // Material 3 uses ElevatedButton heavily
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text("Retry"),
          ),
        ],
      ),
    );
  }
}