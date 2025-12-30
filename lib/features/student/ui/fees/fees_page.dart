import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:college_admin/features/student/providers/api_providers.dart';
import 'package:student_api/api.dart';

class FeesPage extends ConsumerWidget {
  const FeesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final financeAsync = ref.watch(financeProvider);
    final double width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 600;

    return Padding(
        padding: EdgeInsets.all(isMobile ? 16 : 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(
          "My Finances",
          style: TextStyle(
            fontSize: isMobile ? 24 : 28,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 24),

        financeAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text("Error: $err")),
            data: (finance) {
              final balance = finance.balance?.toDouble() ?? 0.0;
              final currency = finance.currency ?? "ZMW";
              final transactions = finance.transactions ?? [];

              return Expanded(
                child: Column(
                    children: [
                    // 1. RESPONSIVE BALANCE CARD
                    _buildBalanceCard(balance, currency, isMobile),
                const SizedBox(height: 32),

                // 2. HISTORY HEADER
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "History",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.file_download_outlined, size: 18),
                      label: Text(isMobile ? "Statement" : "Download Statement"),
                      style: TextButton.styleFrom(
                        visualDensity: isMobile ? VisualDensity.compact : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

// 3. TRANSACTION LIST
                      Expanded(
                        child: Card(
                          elevation: 0,
                          margin: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(color: Colors.grey.shade200),
                          ),
                          child: transactions.isEmpty
                              ? _buildEmptyState()
                              : ListView.separated(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            itemCount: transactions.length,
                            separatorBuilder: (ctx, i) => Divider(
                              height: 1,
                              indent: 70, // Align divider with text, not icon
                              color: Colors.grey.shade100,
                            ),
                            itemBuilder: (ctx, index) {
                              final trans = transactions[index];
                              final isPayment = trans.type == FinanceTransactionTypeEnum.payment;

                              final dateStr = trans.date != null
                                  ? DateFormat('MMM d, yyyy').format(trans.date!)
                                  : "---";

                              final typeStr = trans.type?.value ?? "Transaction";

                              return _buildTransactionItem(
                                title: trans.title ?? "Unknown Transaction",
                                date: dateStr,
                                amount: NumberFormat.currency(
                                  symbol: "$currency ",
                                ).format(trans.amount ?? 0),
                                isCredit: isPayment,
                                category: _capitalize(typeStr),
                                isMobile: isMobile,
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

  Widget _buildTransactionItem({
    required String title,
    required String date,
    required String amount,
    required bool isCredit,
    required String category,
    required bool isMobile,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isCredit ? Colors.green.shade50 : Colors.orange.shade50,
          shape: BoxShape.circle,
        ),
        child: Icon(
          isCredit ? Icons.add_rounded : Icons.remove_rounded,
          color: isCredit ? Colors.green.shade700 : Colors.orange.shade700,
          size: 20,
        ),
      ),
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
      subtitle: Text(
        "$date • $category",
        style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
      ),
      trailing: Text(
        isCredit ? "- $amount" : "+ $amount",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: isMobile ? 13 : 15,
          color: isCredit ? Colors.green.shade700 : Colors.black87,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.receipt_long_outlined, size: 48, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text(
            "No transactions found",
            style: TextStyle(color: Colors.grey.shade500, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  String _capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1).toLowerCase();
  }
}

Widget _buildBalanceCard(double balance, String currency, bool isMobile) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.green.shade900, Colors.green.shade700],
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.green.withOpacity(0.3),
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Flex(
      direction: isMobile ? Axis.vertical : Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.account_balance_wallet_rounded,
            color: Colors.white,
            size: 32,
          ),
        ),
        SizedBox(width: isMobile ? 0 : 24, height: isMobile ? 16 : 0),
        Column(
          crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            const Text(
              "Outstanding Balance",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              NumberFormat.currency(symbol: "$currency ").format(balance),
              style: TextStyle(
                color: Colors.white,
                fontSize: isMobile ? 28 : 34,
                fontWeight: FontWeight.w800,
                letterSpacing: -1,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}