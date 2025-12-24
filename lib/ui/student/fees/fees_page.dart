import 'package:flutter/material.dart';

class FeesPage extends StatelessWidget {
  const FeesPage({super.key});

  @override
  Widget build(BuildContext context) {
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

          // 1. OUTSTANDING BALANCE CARD
          Container(
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
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Outstanding Balance",
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    Text(
                      "ZMW 4,500.00",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // 2. TRANSACTION HISTORY TITLE
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Flexible(
                child: Text(
                  "Transaction History",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              TextButton.icon(
                onPressed: () {}, // Future: Download Statement
                icon: const Icon(Icons.download, size: 16),
                label: const Text("Download Statement"),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // 3. MIXED LIST (FEES + PAYMENTS)
          Expanded(
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.grey.shade200),
              ),
              child: ListView(
                padding: const EdgeInsets.all(8),
                children: [
                  // NEW FEE (Charge)
                  _buildTransactionItem(
                    title: "Library Fine (Overdue Books)",
                    date: "Dec 20, 2024",
                    amount: "ZMW 150.00",
                    isCredit: false, // This adds to debt
                    category: "Fine",
                  ),
                  const Divider(height: 1),

                  // PAYMENT (Credit)
                  _buildTransactionItem(
                    title: "Tuition Fee Payment",
                    date: "Oct 24, 2024",
                    amount: "ZMW 2,000.00",
                    isCredit: true, // This reduces debt
                    category: "Payment",
                  ),
                  const Divider(height: 1),

                  // NEW FEE (Charge)
                  _buildTransactionItem(
                    title: "Semester 2 Tuition",
                    date: "Sep 05, 2024",
                    amount: "ZMW 5,000.00",
                    isCredit: false,
                    category: "Tuition",
                  ),
                  const Divider(height: 1),

                  // NEW FEE (Charge)
                  _buildTransactionItem(
                    title: "Student Union Fee",
                    date: "Sep 01, 2024",
                    amount: "ZMW 200.00",
                    isCredit: false,
                    category: "Fee",
                  ),
                  const Divider(height: 1),

                  // PAYMENT
                  _buildTransactionItem(
                    title: "Registration Fee Payment",
                    date: "Aug 28, 2024",
                    amount: "ZMW 500.00",
                    isCredit: true,
                    category: "Payment",
                  ),
                ],
              ),
            ),
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
        backgroundColor: isCredit ? Colors.green.shade50 : Colors.orange.shade50,
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

        // --- FIX IS HERE: Swapped Row for Wrap ---
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8, // Horizontal space
          runSpacing: 4, // Vertical space if wrapped
          children: [
            Text(
              date,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            // The separator dot
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
}