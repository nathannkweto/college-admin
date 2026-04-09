import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:college_admin/features/student/providers/api_providers.dart';
import 'package:student_api/api.dart';

class StudentExamsPage extends ConsumerWidget {
  const StudentExamsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 2,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Academics",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const TabBar(
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.blue,
              isScrollable: true,
              tabs: [
                Tab(text: "Upcoming Exams"),
                Tab(text: "Results & Transcripts"),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: TabBarView(
                children: [
                  _buildUpcomingExams(ref),
                  _buildResultsTable(ref),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingExams(WidgetRef ref) {
    final examsAsync = ref.watch(upcomingExamsProvider);

    return examsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text("Error loading exams: $e")),
      data: (exams) {
        if (exams.isEmpty) {
          return const Center(child: Text("No upcoming exams scheduled."));
        }

        return ListView.separated(
          itemCount: exams.length,
          separatorBuilder: (ctx, i) => const Divider(),
          itemBuilder: (ctx, index) {
            final exam = exams[index];

            // Safely parse date
            final dateStr = exam.date != null
                ? DateFormat('MMM d, yyyy').format(exam.date!)
                : "Date TBA";

            // Fallbacks for optional fields
            final code = exam.code ?? "";
            final title = exam.title ?? "Unknown Exam";
            final timeStr = exam.time ?? "Time TBA";
            final durationStr = exam.duration ?? ""; // e.g., "120 mins"
            final location = exam.location ?? "Room TBA";

            // Construct display title
            final displayTitle = code.isNotEmpty ? "$code: $title" : title;

            // Construct subtitle
            final subtitleParts = [dateStr, timeStr];
            if (durationStr.isNotEmpty) subtitleParts.add(durationStr);
            subtitleParts.add(location);

            return ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.event_note, color: Colors.blue.shade700),
              ),
              title: Text(displayTitle, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(subtitleParts.join(" • "), style: TextStyle(color: Colors.grey.shade600)),
            );
          },
        );
      },
    );
  }

  Widget _buildResultsTable(WidgetRef ref) {
    final transcriptAsync = ref.watch(transcriptProvider);

    return transcriptAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text("Error loading transcript: $e")),
      data: (transcript) {
        final semesters = transcript.semesters ?? [];

        if (semesters.isEmpty) {
          return const Center(child: Text("No academic results available."));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: semesters.map((semester) {
              final results = semester.results ?? [];
              final semTitle = semester.semesterName ?? "Unknown Semester";

              return Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.grey.shade200),
                ),
                margin: const EdgeInsets.only(bottom: 24),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        semTitle,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Table(
                        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                        columnWidths: const {
                          0: FlexColumnWidth(3), // Course Name takes more space
                          1: FlexColumnWidth(1), // Grade column
                        },
                        border: TableBorder(
                          horizontalInside: BorderSide(color: Colors.grey.shade100),
                        ),
                        children: [
                          // HEADER ROW
                          const TableRow(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 12),
                                child: Text("Course", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 12),
                                child: Text("Grade", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey), textAlign: TextAlign.right),
                              ),
                            ],
                          ),
                          // DATA ROWS
                          ...results.map((result) {
                            final grade = result.grade ?? "-";
                            return TableRow(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  child: Text(result.courseName ?? "---", style: const TextStyle(fontWeight: FontWeight.w500)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  child: Text(
                                    grade,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: _getGradeColor(grade),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Color _getGradeColor(String grade) {
    if (grade == 'F' || grade == 'Repeat') return Colors.red;
    if (grade == 'N/A') return Colors.grey;
    return Colors.green.shade700;
  }
}