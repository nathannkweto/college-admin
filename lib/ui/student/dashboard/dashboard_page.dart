import 'package:flutter/material.dart';

class StudentDashboard extends StatelessWidget {
  const StudentDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    // Check if screen is wide enough for side-by-side layout
    final isWide = MediaQuery.of(context).size.width > 900;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. TOP SECTION: Student Details
          _buildProfileSection(context),

          const SizedBox(height: 24),

          // 2. BOTTOM SECTION: Schedule (Left) + Courses (Right)
          if (isWide)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Main content: Class Schedule
                Expanded(flex: 2, child: _buildTimetable()),
                const SizedBox(width: 24),
                // Side content: Enrolled Courses
                Expanded(flex: 1, child: _buildCurrentCourses()),
              ],
            )
          else ...[
            // Mobile Stacked Layout
            _buildTimetable(),
            const SizedBox(height: 24),
            _buildCurrentCourses(),
          ],
        ],
      ),
    );
  }

  // --- NEW TOP SECTION: Student Profile ---
  Widget _buildProfileSection(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          children: [
            // Avatar / Profile Pic Placeholder
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.green.shade100,
              child: Text(
                "N", // Initial
                style: TextStyle(fontSize: 32, color: Colors.green.shade800, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 24),

            // Student Details Column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Nathan Banda",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 24, // Space between items if they wrap
                    runSpacing: 8,
                    children: [
                      _buildProfileDetail(Icons.badge_outlined, "STD-2024-045"),
                      _buildProfileDetail(Icons.email_outlined, "nathan@college.edu"),
                      _buildProfileDetail(Icons.school_outlined, "BSc Computer Science"),
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

  // Helper for small details in the profile card
  Widget _buildProfileDetail(IconData icon, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: Colors.grey),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(value, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
          ],
        ),
      ],
    );
  }

  // --- CLASS SCHEDULE SECTION ---
  Widget _buildTimetable() {
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.access_time_filled, color: Colors.green),
                    SizedBox(width: 10),
                    Text("Class Schedule", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                Text("Today, Dec 23", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
              ],
            ),
            const Divider(height: 30),
            _buildClassItem("08:00 - 10:00", "Data Structures & Algorithms", "Lab 3", "Mr. Phiri", Colors.orange),
            _buildClassItem("10:30 - 12:30", "Web Development", "Room 404", "Mrs. Tembo", Colors.blue),
            _buildClassItem("14:00 - 16:00", "Database Systems", "Hall B", "Dr. Zimba", Colors.green),
          ],
        ),
      ),
    );
  }

  Widget _buildClassItem(String time, String subject, String venue, String lecturer, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.05),
          border: Border(left: BorderSide(color: color, width: 4)),
          borderRadius: const BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(time, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 14, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(venue, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                  ],
                ),
              ],
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(subject, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 4),
                  Text("Lecturer: $lecturer", style: const TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // --- ENROLLED COURSES SECTION (Unchanged layout-wise, just refined) ---
  Widget _buildCurrentCourses() {
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
            const Text("Enrolled Courses", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildCourseChip("CS201", "Data Structures"),
            _buildCourseChip("CS205", "Web Development"),
            _buildCourseChip("CS208", "Database Systems"),
            _buildCourseChip("MA201", "Linear Algebra"),
            _buildCourseChip("CS210", "Computer Networks"),
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
                borderRadius: BorderRadius.circular(4)
            ),
            child: Text(code, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black87)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}