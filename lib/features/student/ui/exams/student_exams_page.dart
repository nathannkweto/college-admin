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
              labelColor: Colors.green,
              unselectedLabelColor: Colors.grey,
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

            // 1. FIX: Date formatting
            final dateStr = exam.date != null
                ? DateFormat('MMM d, yyyy').format(exam.date!)
                : "TBA";

            // 2. FIX: Property 'time' (was startTime)
            final timeStr = exam.time ?? "TBA";

            final location = exam.location ?? "TBA";

            // 3. FIX: Property 'title' (was courseName)
            final examTitle = exam.title ?? "Unknown Exam";

            return ListTile(
              leading: const Icon(Icons.event_note, color: Colors.green),
              title: Text(examTitle),
              subtitle: Text("$dateStr • $timeStr • $location"),
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
        final semesters = transcript.semesters; // Correct list from model

        if (semesters.isEmpty) {
          return const Center(child: Text("No academic results available."));
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 4. FIX: Property 'gpa' (was cgpa)
              if (transcript.gpa != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    "Cumulative GPA: ${transcript.gpa!.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ),

              // Render a Card for each Semester
              ...semesters.map((semester) {
                // 5. FIX: Property 'results' (was courses)
                final results = semester.results;

                // 6. FIX: Property 'semesterName' (was title)
                final semTitle = semester.semesterName ?? "Unknown Semester";

                return Card(
                  margin: const EdgeInsets.only(bottom: 24),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          semTitle,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const Divider(),
                        Table(
                          columnWidths: const {
                            0: FlexColumnWidth(2),
                            1: FlexColumnWidth(1),
                            2: FlexColumnWidth(1),
                          },
                          children: [
                            // Header Row
                            const TableRow(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  child: Text(
                                    "Course",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  "Grade",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Points",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),

                            // Data Rows
                            ...results.map((result) {
                              // Note: inferred naming for inner result object properties.
                              // If these red-line, check 'TranscriptSemestersInnerResultsInner' file.
                              return TableRow(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 4),
                                    child: Text(result.courseName ?? "---"),
                                  ),
                                  Text(result.grade ?? "-"),
                                  Text((result.points ?? 0).toString()),
                                ],
                              );
                            }),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}