import 'package:flutter/material.dart';

class LecturerDashboard extends StatelessWidget {
  const LecturerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 1000;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. TOP PROFILE SECTION
          _buildLecturerProfile(),
          const SizedBox(height: 24),

          // 2. MAIN CONTENT (Schedule + Courses)
          if (isWide)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 3, child: _buildWeeklySchedule()),
                const SizedBox(width: 24),
                Expanded(flex: 2, child: _buildAssignedCourses()),
              ],
            )
          else ...[
            _buildWeeklySchedule(),
            const SizedBox(height: 24),
            _buildAssignedCourses(),
          ],
        ],
      ),
    );
  }

  Widget _buildLecturerProfile() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Colors.grey.shade200)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.orange.shade50,
              child: const Icon(Icons.person, size: 40, color: Colors.orange),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Dr. Sarah Mumba", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const Text("PhD, Computer Science", style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 12, // Horizontal gap
                    runSpacing: 8, // Vertical gap if it wraps to next line
                    children: [
                      _buildBadge(Icons.business, "Dept of Computing"),
                      _buildBadge(Icons.badge, "Staff ID: LEC-088"),
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

  Widget _buildBadge(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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

  Widget _buildWeeklySchedule() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Colors.grey.shade200)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Teaching Schedule (This Week)", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Icon(Icons.calendar_month, color: Colors.grey),
              ],
            ),
            const Divider(height: 30),

            // Monday
            _buildDayHeader("Monday"),
            _buildClassTile("08:00 - 10:00", "CS201: Data Structures", "Lab 3", Colors.blue),
            _buildClassTile("14:00 - 16:00", "CS400: Final Projects", "Conference Room", Colors.purple),

            // Tuesday
            _buildDayHeader("Tuesday"),
            _buildClassTile("10:00 - 12:00", "CS101: Intro to Programming", "Lecture Hall A", Colors.orange),

            // Wednesday
            _buildDayHeader("Wednesday"),
            const Padding(
              padding: EdgeInsets.only(bottom: 16.0, left: 16),
              child: Text("No classes scheduled (Research Day)", style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDayHeader(String day) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(day, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black54)),
    );
  }

  Widget _buildClassTile(String time, String course, String venue, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        border: Border(left: BorderSide(color: color, width: 4)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Text(time, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(course, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(venue, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAssignedCourses() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Colors.grey.shade200)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("My Courses", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildCourseCard("CS201", "Data Structures", 45),
            _buildCourseCard("CS101", "Intro to Programming", 120),
            _buildCourseCard("CS400", "Final Year Projects", 12),
          ],
        ),
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
            decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(8)),
            child: const Icon(Icons.book, color: Colors.orange, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text("$code • $students Students", style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }
}