import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Import your providers
import 'package:college_admin/features/lecturer/providers/api_providers.dart';
// Import the generated API models
import 'package:lecturer_api/api.dart';
// Import the Grading Page for navigation
import '../grading/grading_page.dart';

class LecturerDashboard extends ConsumerWidget {
  const LecturerDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isDesktop = screenWidth > 1000;

    final profileAsync = ref.watch(lecturerProfileProvider);
    final scheduleAsync = ref.watch(lecturerScheduleProvider);
    final coursesAsync = ref.watch(lecturerCoursesProvider);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isMobile ? 16 : 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. TOP PROFILE SECTION
            profileAsync.when(
              data: (profile) => _buildLecturerProfile(profile, isMobile),
              loading: () => const Center(child: LinearProgressIndicator()),
              error: (e, _) => Center(child: Text("Profile Error: $e")),
            ),

            const SizedBox(height: 24),

            // 2. MAIN CONTENT
            if (isDesktop)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 3, child: _buildScheduleSection(scheduleAsync)),
                  const SizedBox(width: 24),
                  Expanded(flex: 2, child: _buildCoursesSection(context, coursesAsync)),
                ],
              )
            else ...[
              _buildScheduleSection(scheduleAsync),
              const SizedBox(height: 24),
              _buildCoursesSection(context, coursesAsync),
            ],
          ],
        ),
      ),
    );
  }

  // --- PROFILE SECTION ---
  Widget _buildLecturerProfile(LecturerProfile profile, bool isMobile) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey.shade200)),
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 16 : 24),
        child: Flex(
          direction: isMobile ? Axis.vertical : Axis.horizontal,
          crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: isMobile ? 35 : 40,
              backgroundColor: Colors.orange.shade50,
              backgroundImage: profile.avatarUrl != null ? NetworkImage(profile.avatarUrl!) : null,
              child: profile.avatarUrl == null
                  ? Icon(Icons.person, size: isMobile ? 30 : 40, color: Colors.orange)
                  : null,
            ),
            SizedBox(width: isMobile ? 0 : 24, height: isMobile ? 16 : 0),
            Expanded(
              flex: isMobile ? 0 : 1,
              child: Column(
                crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                children: [
                  Text(
                    "${profile.title ?? ''} ${profile.firstName} ${profile.lastName}",
                    textAlign: isMobile ? TextAlign.center : TextAlign.start,
                    style: TextStyle(
                        fontSize: isMobile ? 20 : 24,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  const Text("Lecturer", style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 12),
                  Wrap(
                    alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
                    spacing: 12,
                    runSpacing: 8,
                    children: [
                      _buildBadge(Icons.business, profile.department ?? "N/A"),
                      _buildBadge(Icons.badge, "ID: ${profile.lecturerId}"),
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

  // --- SCHEDULE SECTION ---
  Widget _buildScheduleSection(AsyncValue<List<DailySchedule>> scheduleAsync) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey.shade200)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Weekly Timetable",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Icon(Icons.calendar_view_week, size: 20, color: Colors.grey),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              "Full schedule for the current semester",
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            const Divider(height: 32),
            scheduleAsync.when(
              data: (days) {
                // Filter out research days if you want a compact view,
                // or keep them to show the full week.
                final activeDays = days.where((d) => (d.classes ?? []).isNotEmpty).toList();

                if (activeDays.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Center(child: Text("No classes scheduled this week.")),
                  );
                }

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: activeDays.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final day = activeDays[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDayHeader(day.dayName.toString() ?? "Unknown"),
                        const SizedBox(height: 8),
                        // Using Column here ensures each class is on a new line within the day
                        ...day.classes!.map((c) => _buildClassTile(
                          "${c.startTime} - ${c.endTime}",
                          "${c.courseCode}: ${c.courseName}",
                          c.location ?? "TBA",
                          _parseColor(c.colorHex),
                        )),
                      ],
                    );
                  },
                );
              },
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: CircularProgressIndicator(),
                ),
              ),
              error: (e, _) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Schedule Error: $e", style: const TextStyle(color: Colors.red)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- UPDATED DAY HEADER ---
  Widget _buildDayHeader(String day) {
    // Handling potential Enum strings from the generator (e.g., "DayName.monday")
    final cleanDayName = day.contains('.') ? day.split('.').last : day;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.blue.shade900,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        cleanDayName.toUpperCase(),
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 11,
            letterSpacing: 1.2
        ),
      ),
    );
  }
  // --- COURSES SECTION ---
  Widget _buildCoursesSection(BuildContext context, AsyncValue<List<CourseAssignment>> coursesAsync) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey.shade200)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("My Courses (Active)", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            coursesAsync.when(
              data: (courses) {
                if (courses.isEmpty) return const Text("No courses assigned.");

                final Map<String, List<CourseAssignment>> grouped = {};
                for (var c in courses) {
                  final progName = c.programName ?? "Other Programs";
                  if (!grouped.containsKey(progName)) grouped[progName] = [];
                  grouped[progName]!.add(c);
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: grouped.length,
                  itemBuilder: (context, index) {
                    final programName = grouped.keys.elementAt(index);
                    final programCourses = grouped[programName]!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
                          child: Text(
                            programName.toUpperCase(),
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey.shade600,
                                letterSpacing: 0.5
                            ),
                          ),
                        ),
                        ...programCourses.map((c) => _buildCourseCard(context, c)),
                      ],
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Text("Error loading courses: $e"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClassTile(String time, String course, String venue, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        border: Border(left: BorderSide(color: color, width: 4)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: Text(time, style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 13)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(course, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 2),
                Text(venue, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseCard(BuildContext context, CourseAssignment course) {
    return InkWell(
      onTap: () {
        if (course.publicId != null) {
          Navigator.push(context, MaterialPageRoute(builder: (_) =>
              GradingPage(coursePublicId: course.publicId!)
          ));
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
              child: Icon(Icons.class_outlined, color: Colors.blue.shade700, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(course.courseName ?? "Unknown", style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text("${course.courseCode} • Sem ${course.semesterSequence}", style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildBadge(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(6)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.grey[700]),
          const SizedBox(width: 6),
          Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[800])),
        ],
      ),
    );
  }

  Color _parseColor(String? hex) {
    if (hex == null || hex.isEmpty) return Colors.blue;
    try {
      return Color(int.parse(hex.replaceFirst('#', '0xFF')));
    } catch (_) {
      return Colors.blue;
    }
  }
}