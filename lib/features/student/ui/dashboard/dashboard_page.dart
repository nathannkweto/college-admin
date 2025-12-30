import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:college_admin/features/student/providers/api_providers.dart';
import 'package:student_api/api.dart';

class StudentDashboard extends ConsumerWidget {
  const StudentDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Watch Providers
    final profileAsync = ref.watch(studentProfileProvider);
    final coursesAsync = ref.watch(currentCoursesProvider);

    // We request 'today' directly from the API, so we don't need to filter locally
    final timetableAsync = ref.watch(scheduleProvider('today'));

    final isWide = MediaQuery.of(context).size.width > 900;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. TOP SECTION: Student Details
          _buildProfileSection(context, profileAsync),

          const SizedBox(height: 24),

          // 2. BOTTOM SECTION: Schedule (Left) + Courses (Right)
          if (isWide)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 2, child: _buildTimetable(timetableAsync)),
                const SizedBox(width: 24),
                Expanded(flex: 1, child: _buildCurrentCourses(coursesAsync)),
              ],
            )
          else ...[
            _buildTimetable(timetableAsync),
            const SizedBox(height: 24),
            _buildCurrentCourses(coursesAsync),
          ],
        ],
      ),
    );
  }

  // --- SECTION 1: Student Profile ---
  Widget _buildProfileSection(
      BuildContext context,
      AsyncValue<StudentProfile> profileAsync,
      ) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: profileAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, _) => Text(
            "Error loading profile: $err",
            style: const TextStyle(color: Colors.red),
          ),
          data: (profile) {
            // Note: 'profile' is never null here because the provider handles nulls

            final initial = (profile.firstName != null && profile.firstName!.isNotEmpty)
                ? profile.firstName![0]
                : "S";

            return Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.green.shade100,
                  child: Text(
                    initial,
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.green.shade800,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${profile.firstName} ${profile.lastName}",
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 24,
                        runSpacing: 8,
                        children: [
                          _buildProfileDetail(
                            Icons.badge_outlined,
                            profile.studentId ?? "N/A",
                          ),
                          _buildProfileDetail(
                            Icons.email_outlined,
                            profile.email ?? "No Email",
                          ),
                          _buildProfileDetail(
                            Icons.school_outlined,
                            profile.programName ?? "Unknown Program",
                          ),
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

  Widget _buildProfileDetail(IconData icon, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: Colors.grey),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
            ),
          ],
        ),
      ],
    );
  }

  // --- SECTION 2: Class Schedule ---
  Widget _buildTimetable(
      AsyncValue<List<ClassSession>> timetableAsync,
      ) {
    final now = DateTime.now();
    final dateStr = "Today, ${DateFormat('MMM d').format(now)}";

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
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
                const Row(
                  children: [
                    Icon(Icons.access_time_filled, color: Colors.green),
                    SizedBox(width: 10),
                    Text(
                      "Class Schedule",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  dateStr,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(height: 30),

            timetableAsync.when(
              loading: () => const Padding(
                padding: EdgeInsets.all(20),
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (e, _) => Text("Failed to load schedule: $e"),
              data: (entries) {
                if (entries.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Center(
                      child: Text(
                        "No classes scheduled for today.",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  );
                }

                // Sort by time
                final sortedEntries = [...entries];
                sortedEntries.sort(
                      (a, b) => (a.startTime ?? "").compareTo(b.startTime ?? ""),
                );

                // Colors to cycle through
                final colors = [
                  Colors.orange,
                  Colors.blue,
                  Colors.green,
                  Colors.purple,
                ];

                return Column(
                  children: sortedEntries.asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value;
                    final color = colors[index % colors.length];

                    return _buildClassItem(
                      "${item.startTime} - ${item.endTime}",
                      item.courseName ?? "Unknown Course", // Using courseName from YAML
                      item.location ?? "TBA",
                      item.lecturerName ?? "TBA",
                      color,
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

  Widget _buildClassItem(
      String time,
      String subject,
      String venue,
      String lecturer,
      Color color,
      ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.05),
          border: Border(left: BorderSide(color: color, width: 4)),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  time,
                  style: TextStyle(fontWeight: FontWeight.bold, color: color),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 14, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(
                      venue,
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subject,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Lecturer: $lecturer",
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- SECTION 3: Enrolled Courses ---
  Widget _buildCurrentCourses(
      AsyncValue<List<CourseCompact>> coursesAsync,
      ) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Enrolled Courses",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            coursesAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => const Text("Could not load courses."),
              data: (courses) {
                if (courses.isEmpty) {
                  return const Text("No active enrollments.");
                }

                return Column(
                  children: courses.map((course) {
                    return _buildCourseChip(
                      course.code ?? "---",
                      course.name ?? "Unknown Course",
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

  Widget _buildCourseChip(String code, String name) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              code,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}