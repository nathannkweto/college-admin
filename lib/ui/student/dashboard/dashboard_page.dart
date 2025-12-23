import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Responsive check
    final isWide = MediaQuery.of(context).size.width > 900;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Welcome back, Nathan!", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text("Computer Science • Year 2 • Semester 1", style: TextStyle(color: Colors.grey, fontSize: 16)),
          const SizedBox(height: 24),

          if (isWide)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 2, child: _buildTimetable()),
                const SizedBox(width: 24),
                Expanded(flex: 1, child: _buildCurrentCourses()),
              ],
            )
          else ...[
            _buildTimetable(),
            const SizedBox(height: 24),
            _buildCurrentCourses(),
          ],
        ],
      ),
    );
  }

  Widget _buildTimetable() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Colors.grey.shade200)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.calendar_today, color: Colors.blue),
                SizedBox(width: 10),
                Text("Today's Classes", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            const Divider(height: 30),
            _buildClassItem("08:00 AM", "Data Structures", "Lab 3"),
            _buildClassItem("10:00 AM", "Web Development", "Room 404"),
            _buildClassItem("02:00 PM", "Database Systems", "Hall B"),
          ],
        ),
      ),
    );
  }

  Widget _buildClassItem(String time, String subject, String venue) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
            child: Text(time, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(subject, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(venue, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCurrentCourses() {
    return Card(
      elevation: 0,
      color: Colors.grey.shade50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Colors.grey.shade200)),
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
          ],
        ),
      ),
    );
  }

  Widget _buildCourseChip(String code, String name) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade200)),
      child: Row(
        children: [
          CircleAvatar(radius: 12, backgroundColor: Colors.orange.shade100, child: Text(code[0], style: const TextStyle(fontSize: 10, color: Colors.deepOrange))),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                Text(code, style: const TextStyle(color: Colors.grey, fontSize: 11)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}