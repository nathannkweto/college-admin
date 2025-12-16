class TransactionItem {
  final int id;
  final String title;
  final double amount;
  final String type; // 'income' or 'expense'
  final DateTime date;

  TransactionItem({
    required this.id,
    required this.title,
    required this.amount,
    required this.type,
    required this.date,
  });

  factory TransactionItem.fromJson(Map<String, dynamic> json) {
    return TransactionItem(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0,
      title: json['title'] ?? 'Untitled',
      amount: (json['amount'] ?? 0).toDouble(),
      type: json['type'] ?? 'expense',
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
    );
  }

  bool get isIncome => type.toLowerCase() == 'income';
}