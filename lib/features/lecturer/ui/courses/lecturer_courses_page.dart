import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:college_admin/features/lecturer/providers/api_providers.dart';
import 'package:lecturer_api/api.dart';

class LecturerCoursesPage extends ConsumerWidget {
  const LecturerCoursesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coursesAsync = ref.watch(lecturerCoursesProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isMobile ? 16 : 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Assigned Courses",
              style: TextStyle(
                  fontSize: isMobile ? 24 : 28,
                  fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Detailed overview of your teaching load for the current academic year.",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: isMobile ? 14 : 16
              ),
            ),
            const SizedBox(height: 32),

            coursesAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(child: Text("Error loading courses: $err")),
              data: (courses) {
                if (courses.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Text("No assigned courses found for this semester."),
                    ),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: courses.length,
                  itemBuilder: (context, index) => _buildCourseDetailCard(
                      context,
                      courses[index],
                      isMobile
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseDetailCard(BuildContext context, CourseDetail course, bool isMobile) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(
            horizontal: isMobile ? 12 : 20,
            vertical: 8
        ),
        childrenPadding: EdgeInsets.fromLTRB(
            isMobile ? 12 : 20,
            0,
            isMobile ? 12 : 20,
            20
        ),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.menu_book_rounded,
            color: Colors.orange,
            size: isMobile ? 20 : 24,
          ),
        ),
        title: Text(
          course.courseName ?? "Unknown Course",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: isMobile ? 16 : 18
          ),
        ),
        subtitle: Text(
          "${course.courseCode} • ${course.semester}",
          style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: isMobile ? 12 : 14
          ),
        ),
        children: [
          const Divider(),
          const SizedBox(height: 12),

          // Course Stats (Responsive Wrap)
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildInfoChip(Icons.people_outline, "${course.studentCount} Students"),
              _buildInfoChip(Icons.timer_outlined, "${course.creditHours} Credit Hours"),
            ],
          ),

          const SizedBox(height: 20),

          const Text(
            "Course Description",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87),
          ),
          const SizedBox(height: 8),
          Text(
            course.description ?? "No description provided for this course.",
            style: TextStyle(
                color: Colors.grey.shade700,
                height: 1.5,
                fontSize: isMobile ? 13 : 14
            ),
          ),

          const SizedBox(height: 24),

          // Action Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                // Future logic
              },
              icon: const Icon(Icons.grading_rounded, size: 18),
              label: const Text("Manage Grades"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange.shade600,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.grey.shade700),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade800,
                fontWeight: FontWeight.w500
            ),
          ),
        ],
      ),
    );
  }
}