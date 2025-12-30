import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:college_admin/features/lecturer/providers/api_providers.dart';
import 'package:lecturer_api/api.dart';

class LecturerDashboard extends ConsumerWidget {
  const LecturerDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isDesktop = screenWidth > 1000;

    final profileAsync = ref.watch(lecturerProfileProvider);
    final scheduleAsync = ref.watch(lecturerScheduleProvider);
    final coursesAsync = ref.watch(lecturerCoursesSummaryProvider);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        // Reduce padding on mobile to save horizontal space
        padding: EdgeInsets.all(isMobile ? 16 : 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. TOP PROFILE SECTION (Responsive)
            profileAsync.when(
              data: (profile) => _buildLecturerProfile(profile, isMobile),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text("Error: $e")),
            ),

            const SizedBox(height: 24),

            // 2. MAIN CONTENT (Responsive Grid/Column)
            if (isDesktop)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 3, child: _buildScheduleSection(scheduleAsync)),
                  const SizedBox(width: 24),
                  Expanded(flex: 2, child: _buildCoursesSection(coursesAsync)),
                ],
              )
            else ...[
              _buildScheduleSection(scheduleAsync),
              const SizedBox(height: 24),
              _buildCoursesSection(coursesAsync),
            ],
          ],
        ),
      ),
    );
  }

  // --- RESPONSIVE PROFILE ---
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
                Text("Schedule", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Icon(Icons.calendar_today_outlined, size: 20, color: Colors.grey),
              ],
            ),
            const Divider(height: 32),
            scheduleAsync.when(
              data: (days) => ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: days.length,
                itemBuilder: (context, index) {
                  final day = days[index];
                  if (day.isResearchDay || (day.classes ?? []).isEmpty) return const SizedBox.shrink();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDayHeader(day.dayName?.value ?? ""),
                      ...day.classes!.map((c) => _buildClassTile(
                        "${c.startTime}-${c.endTime}",
                        "${c.courseCode}",
                        c.location ?? "TBA",
                        _parseColor(c.colorHex),
                      )),
                    ],
                  );
                },
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Text("Error: $e"),
            ),
          ],
        ),
      ),
    );
  }

  // --- COURSES SECTION ---
  Widget _buildCoursesSection(AsyncValue<List<CourseSummary>> coursesAsync) {
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
            const Text("My Courses", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            coursesAsync.when(
              data: (courses) => ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  final c = courses[index];
                  return _buildCourseCard(c.courseCode ?? "---", c.courseName ?? "", c.studentCount ?? 0);
                },
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Text("Error: $e"),
            ),
          ],
        ),
      ),
    );
  }

// --- HELPERS ---

  Widget _buildDayHeader(String day) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 12.0),
      child: Text(
          day.toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black54,
            fontSize: 12,
            letterSpacing: 1.1,
          )
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
            child: Text(
                time,
                style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 13)
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(course, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 12, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(venue, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseCard(String code, String name, int students) {
    return Container(
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
            decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(8)
            ),
            child: const Icon(Icons.book_outlined, color: Colors.orange, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text("$code • $students Students",
                    style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
        ],
      ),
    );
  }

  Widget _buildBadge(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(6)
      ),
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