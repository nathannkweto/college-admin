class DashboardMetrics {
  final int students;
  final int lecturers;
  final int levels;
  final int programs;

  DashboardMetrics({
    required this.students,
    required this.lecturers,
    required this.levels,
    required this.programs,
  });

  factory DashboardMetrics.fromJson(Map<String, dynamic> json) {
    return DashboardMetrics(
      students: json['students'] ?? 0,
      lecturers: json['lecturers'] ?? 0,
      levels: json['levels'] ?? 0,
      programs: json['programs'] ?? 0,
    );
  }
}

class FinanceSummary {
  final double income;
  final double expenses;
  final double netBalance;

  FinanceSummary({
    required this.income,
    required this.expenses,
    required this.netBalance,
  });

  factory FinanceSummary.fromJson(Map<String, dynamic> json) {
    return FinanceSummary(
      income: (json['income'] ?? 0).toDouble(),
      expenses: (json['expenses'] ?? 0).toDouble(),
      netBalance: (json['net_balance'] ?? 0).toDouble(),
    );
  }
}