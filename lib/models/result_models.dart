class TranscriptEntry {
  final String course;
  final String code;
  final double score;
  final String grade;

  TranscriptEntry({
    required this.course,
    required this.code,
    required this.score,
    required this.grade,
  });

  factory TranscriptEntry.fromJson(Map<String, dynamic> json) {
    return TranscriptEntry(
      course: json['course'] ?? '',
      code: json['code'] ?? '',
      score: (json['score'] ?? 0).toDouble(),
      grade: json['grade'] ?? '-',
    );
  }
}

class Transcript {
  final String studentName;
  final String studentId;
  final String program;
  // Map Key: "Year 1 - Semester 1", Value: List of courses
  final Map<String, List<TranscriptEntry>> records;

  Transcript({
    required this.studentName,
    required this.studentId,
    required this.program,
    required this.records,
  });

  factory Transcript.fromJson(Map<String, dynamic> json) {
    final student = json['student'] ?? {};
    final transcriptData = json['transcript'] as Map<String, dynamic>? ?? {};

    Map<String, List<TranscriptEntry>> parsedRecords = {};

    transcriptData.forEach((key, value) {
      if (value is List) {
        parsedRecords[key] = value.map((x) => TranscriptEntry.fromJson(x)).toList();
      }
    });

    return Transcript(
      studentName: student['name'] ?? 'Unknown',
      studentId: student['id'] ?? 'N/A',
      program: student['program'] ?? 'N/A',
      records: parsedRecords,
    );
  }
}