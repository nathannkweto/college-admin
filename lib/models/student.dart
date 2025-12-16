class Student {
  final int dbId;
  final String name;      // The API now returns a combined 'name'
  final String studentId; // This is the "2023UG..." ID
  final String program;   // The API returns the program name string

  Student({
    required this.dbId,
    required this.name,
    required this.studentId,
    required this.program,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      dbId: json['db_id'] is int ? json['db_id'] : int.tryParse(json['db_id'].toString()) ?? 0,
      name: json['name'] ?? 'Unknown',
      studentId: json['student_id'] ?? 'N/A',
      program: json['program'] ?? 'N/A',
    );
  }
}