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
    // Updated to use the new weekly studentScheduleProvider
    final timetableAsync = ref.watch(studentScheduleProvider);

    final double width = MediaQuery.of(context).size.width;
    final bool isWide = width > 900;
    final bool isMobile = width < 600;

    return SingleChildScrollView(
      padding: EdgeInsets.all(isMobile ? 16 : 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildProfileSection(context, profileAsync, isMobile),
          const SizedBox(height: 24),
          if (isWide)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 2, child: _buildWeeklyTimetable(timetableAsync, isMobile)),
                const SizedBox(width: 24),
                Expanded(flex: 1, child: _buildCurrentCourses(coursesAsync)),
              ],
            )
          else ...[
            _buildWeeklyTimetable(timetableAsync, isMobile),
            const SizedBox(height: 24),
            _buildCurrentCourses(coursesAsync),
          ],
        ],
      ),
    );
  }

  // --- SECTION: Student Profile (Adaptive) ---
  Widget _buildProfileSection(BuildContext context, AsyncValue<StudentProfile> profileAsync, bool isMobile) {
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
            final String initial = (profile.firstName?.isNotEmpty == true) ? profile.firstName![0].toUpperCase() : "S";
            return Flex(
              direction: isMobile ? Axis.vertical : Axis.horizontal,
              crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: isMobile ? 35 : 40,
                  backgroundColor: Colors.blue.shade50,
                  child: Text(initial, style: TextStyle(fontSize: isMobile ? 28 : 32, color: Colors.blue.shade800, fontWeight: FontWeight.bold)),
                ),
                SizedBox(width: isMobile ? 0 : 24, height: isMobile ? 16 : 0),
                Expanded(
                  flex: isMobile ? 0 : 1,
                  child: Column(
                    crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                    children: [
                      Text("${profile.firstName ?? ''} ${profile.lastName ?? ''}".trim(),
                          style: TextStyle(fontSize: isMobile ? 20 : 24, fontWeight: FontWeight.bold, letterSpacing: -0.5)),
                      const SizedBox(height: 12),
                      Wrap(
                        alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
                        spacing: 12,
                        runSpacing: 8,
                        children: [
                          _buildProfileDetail(Icons.badge_outlined, profile.studentId ?? "N/A"),
                          _buildProfileDetail(Icons.school_outlined, profile.programName ?? "Not Set"),
                          _buildProfileDetail(Icons.calendar_month, "Sem ${profile.currentSemester}"),
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

  // --- SECTION: Weekly Timetable ---
  Widget _buildWeeklyTimetable(AsyncValue<List<DailySchedule>> timetableAsync, bool isMobile) {
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
            const Row(
              children: [
                Icon(Icons.calendar_view_week, color: Colors.blue, size: 20),
                SizedBox(width: 10),
                Text("Weekly Timetable", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            const Divider(height: 32),
            timetableAsync.when(
              loading: () => const Center(child: Padding(padding: EdgeInsets.all(20), child: CircularProgressIndicator())),
              error: (e, _) => Text("Failed to load schedule: $e"),
              data: (days) {
                if (days.isEmpty) return const Center(child: Text("No schedule data available."));

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: days.length,
                  itemBuilder: (context, index) {
                    final day = days[index];
                    if (day.isFreeDay == true) return const SizedBox.shrink();

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(day.dayName?.toUpperCase() ?? "",
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Colors.blue.shade900, letterSpacing: 1.1)),
                        ),
                        ...day.classes!.map((session) => _buildClassItem(session, isMobile)),
                        const SizedBox(height: 16),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClassItem(ClassSession session, bool isMobile) {
    final Color color = _parseHexColor(session.colorHex);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: color.withOpacity(0.05),
          border: Border(left: BorderSide(color: color, width: 4)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            SizedBox(
              width: isMobile ? 80 : 90,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${session.startTime}", style: TextStyle(fontWeight: FontWeight.w800, color: color, fontSize: 12)),
                  Text("${session.endTime}", style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${session.courseCode}: ${session.courseName}",
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13), overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.person_outline, size: 12, color: Colors.grey.shade500),
                      const SizedBox(width: 4),
                      Text(session.lecturerName ?? "TBA", style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
                      const SizedBox(width: 12),
                      Icon(Icons.location_on_outlined, size: 12, color: Colors.grey.shade500),
                      const SizedBox(width: 4),
                      Text(session.location ?? "TBA", style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- SECTION: Enrolled Courses (Helper same as before) ---
  Widget _buildCurrentCourses(AsyncValue<List<CourseCompact>> coursesAsync) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: BorderSide(color: Colors.grey.shade200)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Enrolled Courses", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            coursesAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => const Text("Error loading courses."),
              data: (courses) => Column(children: courses.map((c) => _buildCourseChip(c.code ?? "", c.name ?? "")).toList()),
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
      decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Text(code, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
          const SizedBox(width: 12),
          Expanded(child: Text(name, style: const TextStyle(fontSize: 13), overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }

  Widget _buildProfileDetail(IconData icon, String value) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, size: 14, color: Colors.grey),
      const SizedBox(width: 4),
      Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
    ]);
  }

  Color _parseHexColor(String? hex) {
    if (hex == null || !hex.startsWith('#')) return Colors.blueGrey;
    return Color(int.parse(hex.replaceFirst('#', '0xFF')));
  }
}