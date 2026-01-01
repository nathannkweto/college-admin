import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Import the generated API models
import 'package:admin_api/api.dart' as admin;

// Import the results providers we created
import '../../providers/results_provider.dart';

class StudentTranscriptPage extends ConsumerWidget {
  final String studentPublicId;
  final String semesterPublicId;

  const StudentTranscriptPage({
    super.key,
    required this.studentPublicId,
    required this.semesterPublicId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Watch the real API provider
    final transcriptAsync = ref.watch(studentTranscriptProvider(
        (studentId: studentPublicId, semesterId: semesterPublicId)
    ));

    return Scaffold(
      appBar: AppBar(title: const Text("Student Transcript")),
      body: transcriptAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('Error loading transcript:\n$err', textAlign: TextAlign.center),
            ],
          ),
        ),
        data: (transcript) {
          // The API response (StudentTranscript) usually contains the student object embedded
          final student = transcript.student;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- Header Card (Student Info) ---
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.blue.shade100,
                          child: Text(
                            student?.firstName != null && student!.firstName!.isNotEmpty
                                ? student.firstName![0].toUpperCase()
                                : "S",
                            style: TextStyle(fontSize: 24, color: Colors.blue.shade800, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${student?.firstName ?? 'Unknown'} ${student?.lastName ?? ''}",
                                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "ID: ${student?.studentId ?? 'N/A'}",
                                style: TextStyle(color: Colors.grey.shade700, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "Standing: ${transcript.academicStanding ?? 'N/A'}",
                                style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text("Semester GPA", style: TextStyle(fontSize: 12, color: Colors.grey)),
                            Text(
                              (transcript.semesterGpa ?? 0.0).toStringAsFixed(2),
                              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),
                const Text("Course Results", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),

                // --- Results Table ---
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: DataTable(
                      headingRowColor: WidgetStateProperty.all(Colors.grey.shade100),
                      columnSpacing: 20,
                      columns: const [
                        DataColumn(label: Text("Course")),
                        DataColumn(label: Text("Score")),
                        DataColumn(label: Text("Grade")),
                        DataColumn(label: Text("Status")),
                      ],
                      rows: (transcript.results ?? []).map((res) {
                        return DataRow(cells: [
                          // Course Code & Name
                          DataCell(
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(res.courseCode ?? "-", style: const TextStyle(fontWeight: FontWeight.bold)),
                                  SizedBox(
                                    width: 120, // Limit width for long names
                                    child: Text(
                                      res.courseName ?? "",
                                      style: const TextStyle(fontSize: 11, color: Colors.grey),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Total Score
                          DataCell(Text(res.totalScore?.toString() ?? "-")),
                          // Grade Letter
                          DataCell(Text(res.grade ?? "-", style: const TextStyle(fontWeight: FontWeight.w600))),
                          // Pass/Fail Badge
                          DataCell(_buildResultStatusBadge(res.status)),
                        ]);
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Helper to build the Pass/Fail badge safely from the API enum/object
  Widget _buildResultStatusBadge(dynamic status) {
    if (status == null) return const SizedBox();

    // Safely convert API enum/string to uppercase string for checking
    final statusStr = status.toString().toUpperCase();
    final isPass = statusStr.contains('PASS');
    final isFail = statusStr.contains('FAIL');

    Color bgColor = Colors.grey.shade100;
    Color textColor = Colors.grey.shade800;
    Color borderColor = Colors.grey.shade300;

    if (isPass) {
      bgColor = Colors.green.shade50;
      textColor = Colors.green.shade800;
      borderColor = Colors.green.shade200;
    } else if (isFail) {
      bgColor = Colors.red.shade50;
      textColor = Colors.red.shade800;
      borderColor = Colors.red.shade200;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: borderColor),
      ),
      child: Text(
        isPass ? "PASS" : (isFail ? "FAIL" : statusStr.split('.').last),
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 11,
        ),
      ),
    );
  }
}