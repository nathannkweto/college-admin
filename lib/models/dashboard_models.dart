class DashboardMetrics {
  final int students;
  final int lecturers;
  final int programs;
  final int levels;

  DashboardMetrics({
    required this.students,
    required this.lecturers,
    required this.programs,
    required this.levels,
  });

  factory DashboardMetrics.fromJson(Map<String, dynamic> json) {
    return DashboardMetrics(
      students: json['students'] ?? 0,
      lecturers: json['lecturers'] ?? 0,
      programs: json['programs'] ?? 0,
      levels: json['levels'] ?? 0,
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
    // Handle potential integers coming from API by converting to double
    return FinanceSummary(
      income: (json['income'] ?? 0).toDouble(),
      expenses: (json['expenses'] ?? 0).toDouble(),
      netBalance: (json['net_balance'] ?? 0).toDouble(),
    );
  }
}