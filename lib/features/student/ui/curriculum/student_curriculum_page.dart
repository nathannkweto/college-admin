import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:college_admin/features/student/providers/api_providers.dart';
import 'package:student_api/api.dart';

class StudentCurriculumPage extends ConsumerWidget {
  const StudentCurriculumPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Watch Providers
    final profileAsync = ref.watch(studentProfileProvider);
    final curriculumAsync = ref.watch(curriculumProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeaderSection(context, profileAsync, curriculumAsync),
          const SizedBox(height: 32),

          curriculumAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Text("Error loading curriculum: $e"),
            data: (curriculum) {
              final semesters = curriculum.semesters ?? [];

              if (semesters.isEmpty) {
                return const Text("No curriculum data found.");
              }

              return Column(
                children: semesters.map((semesterData) {
                  // Direct mapping from API model
                  final semName = semesterData.title ?? "Unknown Semester";
                  final isCurrent = semesterData.isCurrent ?? false;
                  final isCleared = semesterData.isCleared ?? false;
                  final courses = semesterData.courses ?? [];

                  return _buildSemesterCard(
                    semName,
                    isCleared,
                    courses.map((course) {
                      return _buildCourseItem(
                        course.code ?? "---",
                        course.name ?? "Unknown Course",
                        course.isCleared ?? false, // API provides this flag directly
                      );
                    }).toList(),
                    isCurrent: isCurrent,
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  // --- HEADER & PROGRESS ---
  Widget _buildHeaderSection(
      BuildContext context,
      AsyncValue<StudentProfile> profileAsync,
      AsyncValue<CurriculumProgress> curriculumAsync,
      ) {
    String programName = "Loading Program...";
    String duration = "";
    double progressValue = 0.0;
    String progressText = "0%";

    // Get Program Name from Profile
    if (profileAsync.hasValue) {
      programName = profileAsync.value?.programName ?? "General Studies";
    }

    // Get Progress Data directly from Curriculum API
    if (curriculumAsync.hasValue) {
      final data = curriculumAsync.value!;
      duration = "• ${data.totalSemesters ?? 8} Semesters Total";

      // API gives a float (e.g. 0.375), we convert to UI values
      progressValue = data.completionPercentage?.toDouble() ?? 0.0;
      progressText = "${(progressValue * 100).toInt()}% Completed";
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "My Curriculum",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          "$programName $duration",
          style: const TextStyle(color: Colors.grey, fontSize: 16),
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progressValue,
            backgroundColor: Colors.grey.shade200,
            color: Colors.green,
            minHeight: 8,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          progressText,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: Colors.green,
          ),
        ),
      ],
    );
  }

  // --- SEMESTER CARD WIDGET ---
  Widget _buildSemesterCard(
      String title,
      bool isSemesterCleared,
      List<Widget> courses, {
        bool isCurrent = false,
      }) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isCurrent ? Colors.green.shade200 : Colors.grey.shade200,
          width: isCurrent ? 2 : 1,
        ),
      ),
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: isCurrent || !isSemesterCleared,
          tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSemesterCleared
                      ? Colors.green
                      : Colors.grey.shade100,
                  border: Border.all(
                    color: isSemesterCleared
                        ? Colors.green
                        : Colors.grey.shade300,
                  ),
                ),
                child: Icon(
                  Icons.check,
                  size: 14,
                  color: isSemesterCleared
                      ? Colors.white
                      : Colors.grey.shade300,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: isSemesterCleared || isCurrent
                        ? Colors.black87
                        : Colors.grey,
                  ),
                ),
              ),
              if (isCurrent) ...[
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    "Current",
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ],
          ),
          children: [
            const Divider(),
            if (courses.isEmpty)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "No courses listed.",
                  style: TextStyle(
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              )
            else
              ...courses,
          ],
        ),
      ),
    );
  }

  // --- COURSE ITEM WIDGET ---
  Widget _buildCourseItem(String code, String name, bool isCleared) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            isCleared ? Icons.check_circle : Icons.radio_button_unchecked,
            color: isCleared ? Colors.green : Colors.grey.shade300,
            size: 20,
          ),
          const SizedBox(width: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Text(
              code,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                color: isCleared ? Colors.black87 : Colors.grey.shade600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}