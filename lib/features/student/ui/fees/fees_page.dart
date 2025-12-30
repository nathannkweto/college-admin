import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

// Update to your actual path
import 'package:college_admin/features/student/providers/api_providers.dart';
import 'package:student_api/api.dart';

class FeesPage extends ConsumerWidget {
  const FeesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Watch the generated finance provider
    final financeAsync = ref.watch(financeProvider);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "My Finances",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),

          financeAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) =>
                Center(child: Text("Error loading finances: $err")),
            data: (finance) {
              // 2. Get Balance directly from API (No manual calculation needed)
              final balance = finance.balance?.toDouble() ?? 0.0;
              final currency = finance.currency ?? "ZMW";
              final transactions = finance.transactions ?? [];

              return Expanded(
                child: Column(
                  children: [
                    _buildBalanceCard(balance, currency),
                    const SizedBox(height: 32),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Flexible(
                          child: Text(
                            "Transaction History",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.download, size: 16),
                          label: const Text("Download Statement"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    Expanded(
                      child: Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(color: Colors.grey.shade200),
                        ),
                        child: transactions.isEmpty
                            ? const Center(
                          child: Text("No transactions found."),
                        )
                            : ListView.separated(
                          padding: const EdgeInsets.all(8),
                          itemCount: transactions.length,
                          separatorBuilder: (ctx, i) =>
                          const Divider(height: 1),
                          itemBuilder: (ctx, index) {
                            final trans = transactions[index];

                            // 3. Map YAML Enums: 'payment' is Credit, 'invoice' is Debit
                            final isPayment = trans.type ==
                                FinanceTransactionTypeEnum.payment;

                            final dateStr = trans.date != null
                                ? DateFormat('MMM d, yyyy')
                                .format(trans.date!)
                                : "---";

                            // Safe access to enum string value
                            final typeStr =
                                trans.type?.value ?? "Transaction";

                            return _buildTransactionItem(
                              title: trans.title ?? "Unknown Transaction",
                              date: dateStr,
                              amount: NumberFormat.currency(
                                symbol: "$currency ",
                              ).format(trans.amount ?? 0),
                              isCredit: isPayment,
                              category: _capitalize(typeStr),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // Updated to accept Currency symbol
  Widget _buildBalanceCard(double balance, String currency) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.shade800, Colors.green.shade600],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.account_balance_wallet,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(width: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Outstanding Balance",
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              Text(
                NumberFormat.currency(symbol: "$currency ").format(balance),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem({
    required String title,
    required String date,
    required String amount,
    required bool isCredit,
    required String category,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: CircleAvatar(
        backgroundColor:
        isCredit ? Colors.green.shade50 : Colors.orange.shade50,
        radius: 20,
        child: Icon(
          isCredit ? Icons.check : Icons.priority_high,
          color: isCredit ? Colors.green : Colors.orange,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8,
          runSpacing: 4,
          children: [
            Text(
              date,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            Container(
              width: 4,
              height: 4,
              decoration: const BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
              ),
            ),
            Text(
              category,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
      trailing: Text(
        isCredit ? "- $amount" : "+ $amount",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          color: isCredit ? Colors.green : Colors.black87,
        ),
      ),
    );
  }

  String _capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1).toLowerCase();
  }
}