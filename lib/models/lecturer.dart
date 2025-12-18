class Lecturer {
  final String staffId;
  final String name;
  final String email;
  final String department;

  Lecturer({
    required this.staffId,
    required this.name,
    required this.email,
    required this.department,
  });

  // Placeholder factory until we have the GET spec
  factory Lecturer.fromJson(Map<String, dynamic> json) {
    return Lecturer(
      staffId: json['staff_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      department: json['department'] ?? '',
    );
  }
}