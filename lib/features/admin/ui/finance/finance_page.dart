import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_api/api.dart'; // <--- ADDED THIS IMPORT
import '../../providers/finance_providers.dart';
import 'finance_dialogs.dart';

class FinancePage extends ConsumerWidget {
  const FinancePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Specify the type here for safety
    final AsyncValue<List<FinanceTransaction>> transactionsAsync = ref.watch(
      transactionsProvider,
    );
    final bool isMobile = MediaQuery.of(context).size.width < 900;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 16 : 32,
          vertical: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- HEADER ---
            _buildHeader(context, isMobile),
            const SizedBox(height: 32),

            // --- DATA AREA ---
            Expanded(
              child: transactionsAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => _buildErrorState(ref, e.toString()),
                data: (data) {
                  if (data.isEmpty) return _buildEmptyState();

                  return isMobile
                      ? _buildMobileList(data)
                      : _buildDataTable(data);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Finance",
                    style: TextStyle(
                      fontSize: isMobile ? 24 : 32,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.8,
                    ),
                  ),
                  Text(
                    "Real-time transaction history and payment logs",
                    style: TextStyle(
                      color: Colors.blueGrey.shade400,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            if (!isMobile) _buildActionButtons(context),
          ],
        ),
        if (isMobile) ...[
          const SizedBox(height: 20),
          _buildActionButtons(context),
        ],
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        TextButton.icon(
          onPressed: () => showDialog(
            context: context,
            builder: (_) => const ApplyFeeDialog(),
          ),
          icon: const Icon(Icons.receipt_long_rounded, size: 20),
          label: const Text(
            "Apply Fee",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          style: TextButton.styleFrom(
            foregroundColor: Colors.blueGrey.shade600,
          ),
        ),
        ElevatedButton.icon(
          onPressed: () => showDialog(
            context: context,
            builder: (_) => const RecordTransactionDialog(),
          ),
          icon: const Icon(Icons.add_rounded),
          label: const Text("Record Payment"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue.shade700,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          ),
        ),
      ],
    );
  }

  // DESKTOP: Borderless Data Table
  // Changed List<dynamic> -> List<FinanceTransaction>
  Widget _buildDataTable(List<FinanceTransaction> data) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: DataTable(
          horizontalMargin: 0,
          columnSpacing: 24,
          dividerThickness: 0.2,
          headingTextStyle: TextStyle(
            color: Colors.blueGrey.shade900,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          columns: const [
            DataColumn(label: Text("Reference")),
            DataColumn(label: Text("Title / Student")),
            DataColumn(label: Text("Type")),
            DataColumn(label: Text("Amount")),
            DataColumn(label: Text("Date")),
          ],
          rows: data.map((t) {
            // FIX: Use dot notation and enum handling
            final typeStr = t.type?.value ?? t.type.toString();
            final isExpense =
                typeStr.toLowerCase() ==
                'expense'; // 'debit' usually means expense here

            return DataRow(
              cells: [
                DataCell(
                  Text(
                    t.transactionId ?? '-',
                    style: TextStyle(
                      color: Colors.blueGrey.shade700,
                      fontSize: 13,
                    ),
                  ),
                ),
                DataCell(
                  Text(t.title ?? '-'),
                ), // 'student_public_id' is rarely in the transaction list, title usually holds the name
                DataCell(_buildStatusChip(typeStr.toUpperCase(), isExpense)),
                DataCell(
                  Text(
                    "\K${t.amount?.toStringAsFixed(2) ?? '0.00'}",
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
                DataCell(Text(t.date?.toString().split(' ')[0] ?? '-')),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  // MOBILE: Clean List
  // Changed List<dynamic> -> List<FinanceTransaction>
  Widget _buildMobileList(List<FinanceTransaction> data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final t = data[index];
        // FIX: Use dot notation and enum handling
        final typeStr = t.type?.value ?? t.type.toString();
        final isExpense = typeStr.toLowerCase() == 'expense';

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey.shade100, width: 1),
            ),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              "\K${t.amount?.toStringAsFixed(2)}",
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
            subtitle: Text(
              "${t.title ?? '-'} • ${t.date?.toString().split(' ')[0]}",
              style: const TextStyle(fontSize: 12),
            ),
            trailing: _buildStatusChip(typeStr.toUpperCase(), isExpense),
          ),
        );
      },
    );
  }

  // Helper logic changed to match 'income' vs 'expense' which is standard in your API
  Widget _buildStatusChip(String label, bool isExpense) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        // Expense = Red, Income = Green
        color: isExpense
            ? Colors.red.shade50.withOpacity(0.5)
            : Colors.green.shade50.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isExpense ? Colors.red.shade800 : Colors.green.shade800,
          fontSize: 10,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.receipt_outlined, size: 48, color: Colors.grey.shade200),
          const SizedBox(height: 16),
          Text(
            "No records found",
            style: TextStyle(color: Colors.grey.shade400),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(WidgetRef ref, String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.cloud_off_rounded,
            color: Colors.redAccent,
            size: 32,
          ),
          const SizedBox(height: 12),
          Text(
            "Failed to sync finance data: $error",
            style: TextStyle(color: Colors.grey.shade700),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () => ref.invalidate(transactionsProvider),
            child: const Text("Try Again"),
          ),
        ],
      ),
    );
  }
}
