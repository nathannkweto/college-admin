class TransactionItem {
  final String studentId;
  final String title;
  final double amount;
  final String type; // 'income' or 'expense'
  final DateTime date;

  TransactionItem({
    required this.studentId,
    required this.title,
    required this.amount,
    required this.type,
    required this.date,
  });

  factory TransactionItem.fromJson(Map<String, dynamic> json) {
    return TransactionItem(
      studentId: json['student_id'] ?? '',
      title: json['title'] ?? 'Untitled',
      amount: (json['amount'] ?? 0).toDouble(),
      type: json['type'] ?? 'expense',
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
    );
  }

  bool get isIncome => type.toLowerCase() == 'income';
}