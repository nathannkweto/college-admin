import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:college_admin/features/student/providers/api_providers.dart';
import 'package:student_api/api.dart';

class StudentPortalResultsPage extends ConsumerWidget {
  const StudentPortalResultsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transcriptAsync = ref.watch(transcriptProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text("Academic History"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: transcriptAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text("Error: $err")),
        data: (transcript) {
          final semesters = transcript.semesters;

          if (semesters == null || semesters.isEmpty) {
            return const Center(child: Text("No academic history found."));
          }

          // Build a list of widgets to include Year Headers
          final List<Widget> listItems = [];
          String lastYear = "";

          for (var semesterGroup in semesters) {
            final name = semesterGroup.semesterName ?? "";

            // Extract "Year X" from "Year X - Semester Y"
            String currentYear = "";
            if (name.startsWith("Year")) {
              final parts = name.split('-');
              if (parts.isNotEmpty) currentYear = parts.first.trim();
            }

            // If Year changed, add a Header
            if (currentYear.isNotEmpty && currentYear != lastYear) {
              listItems.add(
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
                  child: Text(
                    currentYear,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              );
              lastYear = currentYear;
            }

            // FIXED: Passing 'context' here
            listItems.add(_buildSemesterCard(context, semesterGroup));
          }

          return ListView(
            padding: const EdgeInsets.only(bottom: 32),
            children: listItems,
          );
        },
      ),
    );
  }

  // FIXED: Added 'BuildContext context' parameter
  Widget _buildSemesterCard(BuildContext context, SemesterGroup semesterGroup) {
    final results = semesterGroup.results ?? [];

    // Clean the title: Get "Semester Y" from "Year X - Semester Y"
    String title = semesterGroup.semesterName ?? "Unknown Semester";
    if (title.contains("-")) {
      title = title.split("-").last.trim();
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Theme(
        // Remove the divider line when expanded
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: true,
          textColor: Colors.black,
          iconColor: Colors.grey,
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
          ),
          subtitle: Text(
            "${results.length} Courses",
            style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
          ),
          children: results.map((result) => _buildResultRow(result)).toList(),
        ),
      ),
    );
  }

  Widget _buildResultRow(CourseResult result) {
    final grade = result.grade ?? 'N/A';
    // Logic: F is fail, N/A is pending/unpublished
    final isFail = grade == 'F' || grade == 'Repeat';
    final isPending = grade == 'N/A';

    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade100)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        title: Text(
          result.courseName ?? 'Unknown Course',
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        // Score display removed as requested
        trailing: Container(
          width: 50,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
              color: isPending
                  ? Colors.grey.shade100
                  : (isFail ? Colors.red.shade50 : Colors.green.shade50),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isPending
                    ? Colors.grey.shade300
                    : (isFail ? Colors.red.shade100 : Colors.green.shade100),
              )
          ),
          child: Text(
            grade,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: isPending
                  ? Colors.grey.shade500
                  : (isFail ? Colors.red.shade700 : Colors.green.shade700),
            ),
          ),
        ),
      ),
    );
  }
}