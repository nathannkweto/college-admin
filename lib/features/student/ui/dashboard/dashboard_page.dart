import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:college_admin/features/student/providers/api_providers.dart';
import 'package:student_api/api.dart';

class StudentDashboard extends ConsumerWidget {
  const StudentDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(studentProfileProvider);
    final coursesAsync = ref.watch(currentCoursesProvider);
    final timetableAsync = ref.watch(scheduleProvider('today'));

    final double width = MediaQuery.of(context).size.width;
    final bool isWide = width > 900;
    final bool isMobile = width < 600;

    return SingleChildScrollView(
      padding: EdgeInsets.all(isMobile ? 16 : 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. TOP SECTION: Student Details
          _buildProfileSection(context, profileAsync, isMobile),

          const SizedBox(height: 24),

          // 2. BOTTOM SECTION: Schedule & Courses
          if (isWide)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 2, child: _buildTimetable(timetableAsync, isMobile)),
                const SizedBox(width: 24),
                Expanded(flex: 1, child: _buildCurrentCourses(coursesAsync)),
              ],
            )
          else ...[
            _buildTimetable(timetableAsync, isMobile),
            const SizedBox(height: 24),
            _buildCurrentCourses(coursesAsync),
          ],
        ],
      ),
    );
  }

  // --- SECTION 1: Student Profile (Adaptive) ---
  Widget _buildProfileSection(
      BuildContext context,
      AsyncValue<StudentProfile> profileAsync,
      bool isMobile,
      ) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 20 : 24),
        child: profileAsync.when(
          loading: () => const SizedBox(height: 100, child: Center(child: CircularProgressIndicator())),
          error: (err, _) => Center(child: Text("Error: $err")),
          data: (profile) {
            final String initial = (profile.firstName?.isNotEmpty == true)
                ? profile.firstName![0].toUpperCase()
                : "S";

            return Flex(
              direction: isMobile ? Axis.vertical : Axis.horizontal,
              crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: isMobile ? 35 : 40,
                  backgroundColor: Colors.green.shade50,
                  child: Text(
                    initial,
                    style: TextStyle(
                      fontSize: isMobile ? 28 : 32,
                      color: Colors.green.shade800,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: isMobile ? 0 : 24, height: isMobile ? 16 : 0),
                Expanded(
                  flex: isMobile ? 0 : 1,
                  child: Column(
                    crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${profile.firstName ?? ''} ${profile.lastName ?? ''}".trim(),
                        textAlign: isMobile ? TextAlign.center : TextAlign.start,
                        style: TextStyle(
                          fontSize: isMobile ? 20 : 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
                        spacing: 12,
                        runSpacing: 8,
                        children: [
                          _buildProfileDetail(Icons.badge_outlined, profile.studentId ?? "N/A", isMobile),
                          _buildProfileDetail(Icons.email_outlined, profile.email ?? "No Email", isMobile),
                          _buildProfileDetail(Icons.school_outlined, profile.programName ?? "Not Set", isMobile),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildProfileDetail(IconData icon, String value, bool isMobile) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.blueGrey.shade400),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: Colors.blueGrey.shade700,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
  // --- SECTION 2: Class Schedule (Adaptive) ---
  Widget _buildTimetable(AsyncValue<List<ClassSession>> timetableAsync, bool isMobile) {
    final dateStr = "Today, ${DateFormat('MMM d').format(DateTime.now())}";

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.access_time_filled, color: Colors.green.shade600, size: 20),
                    const SizedBox(width: 10),
                    const Text("Schedule", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                Text(dateStr, style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.bold, fontSize: 13)),
              ],
            ),
            const Divider(height: 32),
            timetableAsync.when(
              loading: () => const Center(child: Padding(padding: EdgeInsets.all(20), child: CircularProgressIndicator())),
              error: (e, _) => Text("Failed to load schedule: $e"),
              data: (entries) {
                if (entries.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: Center(child: Text("No classes scheduled for today.", style: TextStyle(color: Colors.grey))),
                  );
                }

                final sortedEntries = [...entries];
                sortedEntries.sort((a, b) => (a.startTime ?? "").compareTo(b.startTime ?? ""));
                final colors = [Colors.blue, Colors.orange, Colors.purple, Colors.green];

                return Column(
                  children: sortedEntries.asMap().entries.map((entry) {
                    return _buildClassItem(
                      "${entry.value.startTime ?? '--:--'} - ${entry.value.endTime ?? '--:--'}",
                      entry.value.courseName ?? "Unknown Course",
                      entry.value.location ?? "No Location",
                      entry.value.lecturerName ?? "Staff",
                      colors[entry.key % colors.length],
                      isMobile,
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClassItem(String time, String subject, String venue, String lecturer, Color color, bool isMobile) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.05),
          border: Border(left: BorderSide(color: color, width: 4)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Time and Venue Column
            SizedBox(
              width: isMobile ? 85 : 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(time, style: TextStyle(fontWeight: FontWeight.w800, color: color, fontSize: 12)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 12, color: Colors.grey.shade600),
                      const SizedBox(width: 4),
                      Expanded(child: Text(venue, style: TextStyle(color: Colors.grey.shade600, fontSize: 11), overflow: TextOverflow.ellipsis)),
                    ],
                  ),
                ],
              ),
            ),
            // Vertical Divider
            Container(
              height: 35,
              width: 1,
              color: Colors.grey.shade300,
              margin: const EdgeInsets.symmetric(horizontal: 16),
            ),
            // Subject and Lecturer Column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(subject, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 4),
                  Text(lecturer, style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- SECTION 3: Enrolled Courses ---
  Widget _buildCurrentCourses(AsyncValue<List<CourseCompact>> coursesAsync) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("My Courses", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            coursesAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => const Text("Could not load courses."),
              data: (courses) {
                if (courses.isEmpty) return const Text("No active enrollments.", style: TextStyle(color: Colors.grey));
                return Column(
                  children: courses.map((c) => _buildCourseChip(c.code ?? "---", c.name ?? "Unknown Course")).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseChip(String code, String name) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(6)
            ),
            child: Text(code, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }
}