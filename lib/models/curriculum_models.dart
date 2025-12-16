class Department {
  final int id;
  final String name;
  final String code;

  Department({required this.id, required this.name, required this.code});

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      code: json['code'] ?? '',
    );
  }
}

class Semester {
  final int id;
  final int number;
  final String academicYear;

  Semester({required this.id, required this.number, required this.academicYear});

  factory Semester.fromJson(Map<String, dynamic> json) {
    return Semester(
      id: json['id'] ?? 0,
      number: json['number'] ?? 0,
      academicYear: json['academic_year'] ?? 'Unknown',
    );
  }
}

class Program {
  final int id;
  final String name;
  final String code;

  Program({required this.id, required this.name, required this.code});

  factory Program.fromJson(Map<String, dynamic> json) {
    return Program(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      code: json['code'] ?? '',
    );
  }
}

class AcademicLevel {
  final int id;
  final String name;
  final List<Program> programs;

  AcademicLevel({required this.id, required this.name, required this.programs});

  factory AcademicLevel.fromJson(Map<String, dynamic> json) {
    var list = json['programs'] as List? ?? [];
    List<Program> programList = list.map((i) => Program.fromJson(i)).toList();
    return AcademicLevel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      programs: programList,
    );
  }
}