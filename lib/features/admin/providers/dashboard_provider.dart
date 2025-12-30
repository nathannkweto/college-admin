import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_api/api.dart' as admin;
import '../../../core/services/api_service.dart';

// ==========================================
// 1. METRICS PROVIDER (Students, Lecturers, etc.)
// ==========================================
final dashboardMetricsProvider =
    FutureProvider.autoDispose<admin.DashboardMetrics>((ref) async {
      // Calls the new endpoint: GET /dashboard/metrics
      final response = await ApiService().dashboard.dashboardMetricsGet();

      // The generated client usually wraps the response in a 'data' key
      // depending on how you set up the response in YAML.
      // Based on the YAML I gave you: { "data": { ... } }
      return response!.data!;
    });

// ==========================================
// 2. FINANCE PROVIDER (Income, Expense, Net)
// ==========================================
final dashboardFinanceProvider =
    FutureProvider.autoDispose<admin.DashboardFinance>((ref) async {
      // Calls the new endpoint: GET /dashboard/finance
      final response = await ApiService().dashboard.dashboardFinanceGet();

      return response!.data!;
    });
