class Lecturer {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final int departmentId;

  Lecturer({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.departmentId,
  });

  // Placeholder factory until we have the GET spec
  factory Lecturer.fromJson(Map<String, dynamic> json) {
    return Lecturer(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      departmentId: json['department_id'] is int
          ? json['department_id']
          : int.tryParse(json['department_id'].toString()) ?? 0,
    );
  }

  String get fullName => "$firstName $lastName";
}