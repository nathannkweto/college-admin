import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../services/api_service.dart';
import '../../../models/dashboard_models.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool _isLoading = true;

  // Data State
  DashboardMetrics? _metrics;
  FinanceSummary? _finance;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    setState(() { _isLoading = true; _error = null; });
    try {
      // Fetch Metrics
      final metricsRes = await ApiService.get('/dashboard/metrics');
      if (metricsRes is Map && metricsRes['data'] != null) {
        _metrics = DashboardMetrics.fromJson(metricsRes['data']);
      }

      // Fetch Finance
      final financeRes = await ApiService.get('/dashboard/finance');
      if (financeRes is Map && financeRes['data'] != null) {
        _finance = FinanceSummary.fromJson(financeRes['data']);
      }

    } catch (e) {
      _error = e.toString().replaceAll("Exception:", "").trim();
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text("Error loading dashboard: $_error"),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _loadDashboardData, child: const Text("Retry")),
          ],
        ),
      );
    }

    // Default to 0 if null
    final m = _metrics ?? DashboardMetrics(students: 0, lecturers: 0, levels: 0, programs: 0);
    final f = _finance ?? FinanceSummary(income: 0, expenses: 0, netBalance: 0);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          const Text("Dashboard Overview", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text("Welcome back, Admin", style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 32),

          // --- ROW 1: KEY METRICS ---
          Row(
            children: [
              _DashboardCard(
                title: "Total Students",
                value: m.students.toString(),
                icon: Icons.people_alt,
                color: Colors.blue,
              ),
              const SizedBox(width: 24),
              _DashboardCard(
                title: "Lecturers",
                value: m.lecturers.toString(),
                icon: Icons.co_present,
                color: Colors.orange,
              ),
              const SizedBox(width: 24),
              _DashboardCard(
                title: "Active Programs",
                value: m.programs.toString(),
                icon: Icons.school,
                color: Colors.purple,
              ),
              const SizedBox(width: 24),
              _DashboardCard(
                title: "Academic Levels",
                value: m.levels.toString(),
                icon: Icons.layers,
                color: Colors.teal,
              ),
            ],
          ),
          const SizedBox(height: 32),

          // --- ROW 2: FINANCIAL HEALTH ---
          const Text("Financial Health", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _FinanceOverviewCard(finance: f),
        ],
      ),
    );
  }
}

// ----------------------------------------------------------------------
// WIDGET: Standard KPI Card
// ----------------------------------------------------------------------
class _DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _DashboardCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))
          ],
          border: Border.all(color: Colors.grey.shade100),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                  child: Icon(icon, color: color, size: 24),
                ),
                // Optional: trend indicator could go here
              ],
            ),
            const SizedBox(height: 24),
            Text(value, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(title, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
          ],
        ),
      ),
    );
  }
}

// ----------------------------------------------------------------------
// WIDGET: Financial Summary Card
// ----------------------------------------------------------------------
class _FinanceOverviewCard extends StatelessWidget {
  final FinanceSummary finance;
  const _FinanceOverviewCard({required this.finance});

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.simpleCurrency(name: 'ZMW');

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          // Net Balance (Left Side)
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Net Balance", style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 8),
                Text(
                  currency.format(finance.netBalance),
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: finance.netBalance >= 0 ? Colors.black : Colors.red,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text("Active Semester", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12)),
                )
              ],
            ),
          ),
          Container(width: 1, height: 80, color: Colors.grey.shade200),

          // Income vs Expenses (Right Side)
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(left: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _statItem("Total Income", finance.income, Colors.green, Icons.arrow_upward),
                  _statItem("Total Expenses", finance.expenses, Colors.red, Icons.arrow_downward),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statItem(String label, double amount, Color color, IconData icon) {
    final currency = NumberFormat.simpleCurrency(name: 'ZMW');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 4),
            Text(label, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500)),
          ],
        ),
        const SizedBox(height: 8),
        Text(currency.format(amount), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
      ],
    );
  }
}