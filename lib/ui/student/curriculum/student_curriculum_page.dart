import 'package:flutter/material.dart';

class StudentCurriculumPage extends StatelessWidget {
  const StudentCurriculumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          const Text(
              "My Curriculum",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)
          ),
          const SizedBox(height: 8),
          const Text(
              "BSc Computer Science • 8 Semesters Total",
              style: TextStyle(color: Colors.grey, fontSize: 16)
          ),
          const SizedBox(height: 8),
          // Simple Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: 0.375, // e.g., 3 out of 8 semesters done
              backgroundColor: Colors.grey.shade200,
              color: Colors.green,
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 8),
          const Text("37% Completed", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.green)),

          const SizedBox(height: 32),

          // --- SEMESTER LIST ---
          // Year 1 (Fully Cleared)
          _buildSemesterCard("Year 1 - Semester 1", true, [
            _buildCourseItem("CS101", "Intro to Programming", true),
            _buildCourseItem("MA110", "Discrete Mathematics", true),
            _buildCourseItem("CS105", "Computer Essentials", true),
            _buildCourseItem("CM101", "Communication Skills", true),
          ]),

          _buildSemesterCard("Year 1 - Semester 2", true, [
            _buildCourseItem("CS102", "Object Oriented Programming", true),
            _buildCourseItem("MA120", "Calculus I", true),
            _buildCourseItem("PH101", "Physics for Computing", true),
            _buildCourseItem("CS120", "Digital Logic Design", true),
          ]),

          // Year 2 (Current - Partial/Mixed)
          _buildSemesterCard("Year 2 - Semester 1", false, [
            _buildCourseItem("CS201", "Data Structures & Algorithms", true), // Cleared (maybe early?)
            _buildCourseItem("CS205", "Web Development", false), // Currently taking
            _buildCourseItem("CS208", "Database Systems", false),
            _buildCourseItem("MA201", "Linear Algebra", false),
          ], isCurrent: true),

          // Year 2 (Future)
          _buildSemesterCard("Year 2 - Semester 2", false, [
            _buildCourseItem("CS220", "Operating Systems", false),
            _buildCourseItem("CS230", "Software Engineering I", false),
            _buildCourseItem("MA202", "Statistics & Probability", false),
          ]),

          // Year 3 (Future - Collapsed by default usually, but we show all for now)
          _buildSemesterCard("Year 3 - Semester 1", false, [
            _buildCourseItem("CS301", "Computer Networks", false),
            _buildCourseItem("CS310", "Artificial Intelligence", false),
          ]),
        ],
      ),
    );
  }

  Widget _buildSemesterCard(String title, bool isSemesterCleared, List<Widget> courses, {bool isCurrent = false}) {
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
        // Removing the default divider line of ExpansionTile
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: isCurrent || isSemesterCleared, // Expand current or past items
          tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),

          // TITLE ROW
          title: Row(
            children: [
              // The Semester Status Tick
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSemesterCleared ? Colors.green : Colors.grey.shade100,
                  border: Border.all(color: isSemesterCleared ? Colors.green : Colors.grey.shade300),
                ),
                child: Icon(
                    Icons.check,
                    size: 14,
                    color: isSemesterCleared ? Colors.white : Colors.grey.shade300
                ),
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: isSemesterCleared || isCurrent ? Colors.black87 : Colors.grey,
                ),
              ),
              if (isCurrent) ...[
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(4)),
                  child: const Text("Current", style: TextStyle(fontSize: 10, color: Colors.green, fontWeight: FontWeight.bold)),
                )
              ]
            ],
          ),

          // COURSES LIST
          children: [
            const Divider(),
            ...courses,
          ],
        ),
      ),
    );
  }

  Widget _buildCourseItem(String code, String name, bool isCleared) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          // Course Status Tick
          Icon(
            isCleared ? Icons.check_circle : Icons.radio_button_unchecked,
            color: isCleared ? Colors.green : Colors.grey.shade300,
            size: 20,
          ),
          const SizedBox(width: 16),

          // Course Code Box
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
                    color: Colors.grey.shade700
                )
            ),
          ),
          const SizedBox(width: 12),

          // Course Name
          Expanded(
            child: Text(
                name,
                style: TextStyle(
                  color: isCleared ? Colors.black87 : Colors.grey.shade600,
                  decoration: isCleared ? null : null, // Optional: lineThrough if desired
                )
            ),
          ),
        ],
      ),
    );
  }
}