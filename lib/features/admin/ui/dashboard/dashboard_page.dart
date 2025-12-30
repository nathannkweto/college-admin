import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:admin_api/api.dart' as admin; // Use generated types
import '../../providers/dashboard_provider.dart'; // Import your new providers

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the two separate providers
    final metricsAsync = ref.watch(dashboardMetricsProvider);
    final financeAsync = ref.watch(dashboardFinanceProvider);

    // 1. LOADING STATE
    // If either is loading, show the spinner
    if (metricsAsync.isLoading || financeAsync.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // 2. ERROR STATE
    // If either failed, show the error screen
    if (metricsAsync.hasError || financeAsync.hasError) {
      final errorMsg =
          metricsAsync.error?.toString() ??
          financeAsync.error?.toString() ??
          'Unknown Error';

      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text("Error: ${errorMsg.replaceAll("Exception:", "").trim()}"),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Retry both providers
                ref.refresh(dashboardMetricsProvider);
                ref.refresh(dashboardFinanceProvider);
              },
              child: const Text("Retry"),
            ),
          ],
        ),
      );
    }

    // 3. SUCCESS STATE
    // We can safely unwrap value! here because we checked loading/error above
    final m =
        metricsAsync.value ??
        admin.DashboardMetrics(
          students: 0,
          lecturers: 0,
          levels: 0,
          programs: 0,
        );
    final f =
        financeAsync.value ??
        admin.DashboardFinance(
          income: 0,
          expenses: 0,
          netBalance: 0,
          activeSemester: "N/A",
        );

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Dashboard Overview",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "Welcome back, Admin",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 32),

              // --- RESPONSIVE METRIC CARDS ---
              _buildResponsiveGrid(constraints.maxWidth, m),

              const SizedBox(height: 32),

              // --- RESPONSIVE FINANCE CARD ---
              const Text(
                "Financial Health",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _FinanceOverviewCard(finance: f),
            ],
          ),
        );
      },
    );
  }

  // Helper to arrange cards based on screen width
  // Updated to accept 'admin.DashboardMetrics'
  Widget _buildResponsiveGrid(double width, admin.DashboardMetrics m) {
    // Define cards data
    final cards = [
      _DashboardCard(
        title: "Total Students",
        value: m.students.toString(),
        icon: Icons.people_alt,
        color: Colors.blue,
      ),
      _DashboardCard(
        title: "Lecturers",
        value: m.lecturers.toString(),
        icon: Icons.co_present,
        color: Colors.orange,
      ),
      _DashboardCard(
        title: "Active Programs",
        value: m.programs.toString(),
        icon: Icons.school,
        color: Colors.purple,
      ),
      _DashboardCard(
        title: "Academic Levels",
        value: m.levels.toString(),
        icon: Icons.layers,
        color: Colors.teal,
      ),
    ];

    // 1. Desktop (Wide): 4 cards in a Row
    if (width > 1100) {
      return Row(
        children: cards
            .map(
              (c) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: c,
                ),
              ),
            )
            .toList(),
      );
    }

    // 2. Tablet (Medium): 2 cards per row
    if (width > 700) {
      return Wrap(
        spacing: 16,
        runSpacing: 16,
        children: cards
            .map(
              (c) => SizedBox(
                width:
                    (width - 48 - 16) /
                    2, // (TotalWidth - Padding - Spacing) / 2
                child: c,
              ),
            )
            .toList(),
      );
    }

    // 3. Mobile (Narrow): 1 card per row
    return Column(
      children: cards
          .map(
            (c) =>
                Padding(padding: const EdgeInsets.only(bottom: 16), child: c),
          )
          .toList(),
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
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
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
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            value,
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(title, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
        ],
      ),
    );
  }
}

// ----------------------------------------------------------------------
// WIDGET: Financial Summary Card
// ----------------------------------------------------------------------
class _FinanceOverviewCard extends StatelessWidget {
  // Updated to accept 'admin.DashboardFinance'
  final admin.DashboardFinance finance;
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
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Breakpoint: If width < 600, stack them vertically
          bool isNarrow = constraints.maxWidth < 600;

          if (isNarrow) {
            // --- MOBILE LAYOUT (Column) ---
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildNetBalance(currency),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Divider(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: _statItem(
                        "Total Income",
                        finance.income,
                        Colors.green,
                        Icons.arrow_upward,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _statItem(
                        "Total Expenses",
                        finance.expenses,
                        Colors.red,
                        Icons.arrow_downward,
                      ),
                    ),
                  ],
                ),
              ],
            );
          } else {
            // --- DESKTOP/TABLET LAYOUT (Row) ---
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Net Balance
                SizedBox(width: 200, child: _buildNetBalance(currency)),

                // Vertical Divider
                Container(
                  width: 1,
                  height: 80,
                  color: Colors.grey.shade200,
                  margin: const EdgeInsets.symmetric(horizontal: 32),
                ),

                // 2. Income vs Expenses
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: _statItem(
                          "Total Income",
                          finance.income,
                          Colors.green,
                          Icons.arrow_upward,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _statItem(
                          "Total Expenses",
                          finance.expenses,
                          Colors.red,
                          Icons.arrow_downward,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildNetBalance(NumberFormat currency) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Net Balance", style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 8),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(
            currency.format(finance.netBalance),
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: finance.netBalance >= 0 ? Colors.black : Colors.red,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            finance.activeSemester ?? "No Semester", // Handle nullable string
            style: const TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ],
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
            Expanded(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(
            currency.format(amount),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
