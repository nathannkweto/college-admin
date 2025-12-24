import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../services/api_service.dart';
import '../../../models/finance_models.dart';
import 'finance_dialogs.dart';

class FinancePage extends StatefulWidget {
  const FinancePage({super.key});

  @override
  State<FinancePage> createState() => _FinancePageState();
}

class _FinancePageState extends State<FinancePage> {
  bool _isLoading = true;
  List<TransactionItem> _transactions = [];
  String? _filterType; // null = all, 'income', 'expense'

  // Formatters
  final currencyFmt = NumberFormat.simpleCurrency(name: 'ZMW');
  final dateFmt = DateFormat('MMM dd, yyyy • hh:mm a');

  @override
  void initState() {
    super.initState();
    _fetchTransactions();
  }

  Future<void> _fetchTransactions() async {
    setState(() => _isLoading = true);
    try {
      // Build query: /fees/transactions OR /fees/transactions?type=income
      String endpoint = '/fees/transactions';
      if (_filterType != null) endpoint += '?type=$_filterType';

      final res = await ApiService.get(endpoint);

      List<TransactionItem> list = [];
      if (res is Map && res['data'] is List) {
        list = (res['data'] as List).map((x) => TransactionItem.fromJson(x)).toList();
      }

      // Sort by date descending (newest first)
      list.sort((a, b) => b.date.compareTo(a.date));

      if (mounted) setState(() => _transactions = list);
    } catch (e) {
      debugPrint("Finance error: $e");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _openDialog(Widget dialog) async {
    final res = await showDialog(context: context, builder: (_) => dialog);
    if (res == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Success!"), backgroundColor: Colors.green, duration: Duration(seconds: 2)),
      );
      _fetchTransactions();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- FIXED HEADER (Responsive Wrap) ---
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 16, // Horizontal gap
              runSpacing: 16, // Vertical gap (when wrapped)
              children: [
                // Title Section
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Finance & Accounting", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text("Track revenue and expenses", style: TextStyle(color: Colors.grey)),
                  ],
                ),

                // Buttons Section (Also Wrapped)
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => _openDialog(const PayFeesDialog()),
                      icon: const Icon(Icons.payments),
                      label: const Text("Receive Fees"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => _openDialog(const RecordTransactionDialog()),
                      icon: const Icon(Icons.receipt_long),
                      label: const Text("Record Transaction"),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32),

            // --- FILTERS ---
            Wrap( // Used Wrap here just in case filters overflow too
              spacing: 8,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const Text("Filter: ", style: TextStyle(fontWeight: FontWeight.bold)),
                ChoiceChip(
                  label: const Text("All"),
                  selected: _filterType == null,
                  onSelected: (b) { if(b) setState(() { _filterType = null; _fetchTransactions(); }); },
                ),
                ChoiceChip(
                  label: const Text("Income", style: TextStyle(color: Colors.green)),
                  selected: _filterType == 'income',
                  onSelected: (b) { if(b) setState(() { _filterType = 'income'; _fetchTransactions(); }); },
                ),
                ChoiceChip(
                  label: const Text("Expenses", style: TextStyle(color: Colors.red)),
                  selected: _filterType == 'expense',
                  onSelected: (b) { if(b) setState(() { _filterType = 'expense'; _fetchTransactions(); }); },
                ),
              ],
            ),
            const SizedBox(height: 16),

            // --- DATA TABLE (With Horizontal Scroll) ---
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _transactions.isEmpty
                    ? const Center(child: Text("No transactions found.", style: TextStyle(color: Colors.grey)))
                    : SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal, // ADDED: Prevents horizontal overflow
                    child: DataTable(
                      headingRowColor: MaterialStateProperty.all(Colors.grey.shade50),
                      columns: const [
                        DataColumn(label: Text("Date")),
                        DataColumn(label: Text("Description")),
                        DataColumn(label: Text("Type")),
                        DataColumn(label: Text("Amount", textAlign: TextAlign.right)),
                      ],
                      rows: _transactions.map((t) {
                        return DataRow(cells: [
                          DataCell(Text(dateFmt.format(t.date))),
                          DataCell(Text(t.title, style: const TextStyle(fontWeight: FontWeight.w500))),
                          DataCell(Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: t.isIncome ? Colors.green.shade50 : Colors.red.shade50,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              t.type.toUpperCase(),
                              style: TextStyle(
                                color: t.isIncome ? Colors.green.shade800 : Colors.red.shade800,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )),
                          DataCell(Text(
                            "${t.isIncome ? '+' : '-'} ${currencyFmt.format(t.amount)}",
                            style: TextStyle(
                              color: t.isIncome ? Colors.green : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                        ]);
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}