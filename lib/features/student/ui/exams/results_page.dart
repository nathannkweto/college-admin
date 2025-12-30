import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:college_admin/features/student/providers/api_providers.dart'; // Correct provider path
import 'package:student_api/api.dart';

class StudentPortalResultsPage extends ConsumerWidget {
  const StudentPortalResultsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Reuse the transcript provider since it contains the result data
    final transcriptAsync = ref.watch(transcriptProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("My Results")),
      body: transcriptAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text("Error: $err")),
        data: (transcript) {
          final semesters = transcript.semesters;

          if (semesters.isEmpty) {
            return const Center(child: Text("No results available."));
          }

          // 2. Render Data from Generated Models
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: semesters.length,
            itemBuilder: (context, index) {
              final semesterGroup = semesters[index];
              final results = semesterGroup.results;

              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: ExpansionTile(
                  title: Text(semesterGroup.semesterName ?? "Unknown Semester"),
                  // Note: Inner semester model does not have a specific 'gpa' field.
                  // We show the course count instead, or you could calculate the GPA here.
                  subtitle: Text("${results.length} Courses Completed"),
                  children: results.map((result) {
                    final grade = result.grade ?? '-';
                    final isFail = grade == 'F';

                    return ListTile(
                      // Model only has courseName (no separate code)
                      title: Text(result.courseName ?? '-'),
                      // Using points as subtitle since 'code' is missing in model
                      subtitle: Text("Points: ${result.points ?? 0}"),
                      trailing: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: isFail ? Colors.red[50] : Colors.green[50],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          grade,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isFail ? Colors.red : Colors.green,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}