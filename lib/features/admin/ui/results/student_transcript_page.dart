import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_api/api.dart' as admin;
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
    final transcriptAsync = ref.watch(studentTranscriptProvider(
        (studentId: studentPublicId, semesterId: semesterPublicId)
    ));

    return Scaffold(
      appBar: AppBar(title: const Text("Student Transcript")),
      body: transcriptAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                Text('Error loading transcript:\n$err', textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
        data: (transcript) {
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
                              const SizedBox(height: 4),
                              Text(
                                "Email: ${student?.email ?? 'N/A'}",
                                style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                              ),
                            ],
                          ),
                        ),
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
                                    width: 120,
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
                          // Score
                          DataCell(Text(res.score?.toStringAsFixed(1) ?? "-")),
                          // Grade Letter
                          DataCell(Text(res.grade ?? "-", style: const TextStyle(fontWeight: FontWeight.w600))),
                          // Pass/Fail Badge (UPDATED LOGIC)
                          DataCell(_buildResultStatusBadge(res.grade)),
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

  /// Helper to calculate status since backend only returns Grade/Score now
  Widget _buildResultStatusBadge(String? grade) {
    if (grade == null) return const SizedBox();

    final gradeUpper = grade.toUpperCase();

    // FIX: If pending, return nothing (empty widget)
    if (gradeUpper == 'PENDING') {
      return const SizedBox();
    }

    // Logic: 'F' is fail, everything else is Pass
    final isFail = gradeUpper == 'F';
    // If it's not pending and not F, it's a pass
    final isPass = !isFail;

    Color bgColor = isPass ? Colors.green.shade50 : Colors.red.shade50;
    Color textColor = isPass ? Colors.green.shade800 : Colors.red.shade800;
    Color borderColor = isPass ? Colors.green.shade200 : Colors.red.shade200;
    String text = isPass ? "PASS" : "FAIL";

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: borderColor),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 11,
        ),
      ),
    );
  }
}