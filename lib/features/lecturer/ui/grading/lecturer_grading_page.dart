import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:college_admin/features/lecturer/providers/api_providers.dart';
import 'package:lecturer_api/api.dart';

class LecturerGradingPage extends ConsumerStatefulWidget {
  const LecturerGradingPage({super.key});

  @override
  ConsumerState<LecturerGradingPage> createState() => _LecturerGradingPageState();
}

class _LecturerGradingPageState extends ConsumerState<LecturerGradingPage> {
  final Map<String, double> _localScores = {};

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    final coursesAsync = ref.watch(lecturerCoursesProvider);
    final selectedCourseId = ref.watch(selectedCourseIdProvider);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Padding(
        padding: EdgeInsets.all(isMobile ? 16 : 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Grading & Results",
              style: TextStyle(
                  fontSize: isMobile ? 24 : 28,
                  fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 24),

            // 1. Course Selector
            coursesAsync.when(
              data: (courses) {
                if (selectedCourseId == null && courses.isNotEmpty) {
                  Future.microtask(() =>
                  ref.read(selectedCourseIdProvider.notifier).state = courses.first.courseCode);
                }

                return DropdownButtonFormField<String>(
                  isExpanded: true, // Prevents text overflow in dropdown
                  decoration: const InputDecoration(
                    labelText: "Select Course",
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  value: selectedCourseId,
                  items: courses.map((c) => DropdownMenuItem(
                    value: c.courseCode,
                    child: Text(
                      "${c.courseCode} - ${c.courseName}",
                      overflow: TextOverflow.ellipsis,
                    ),
                  )).toList(),
                  onChanged: (val) {
                    _localScores.clear();
                    ref.read(selectedCourseIdProvider.notifier).state = val;
                  },
                );
              },
              loading: () => const LinearProgressIndicator(),
              error: (e, _) => Text("Error: $e"),
            ),

            const SizedBox(height: 24),

            // 2. Student List
            Expanded(
              child: selectedCourseId == null
                  ? const Center(child: Text("Please select a course"))
                  : ref.watch(lecturerCourseStudentsProvider(selectedCourseId)).when(
                data: (students) => _buildStudentList(students, isMobile),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text("Error: $e")),
              ),
            ),

            const SizedBox(height: 16),

            // 3. Action Buttons (Responsive)
            _buildActionButtons(selectedCourseId, isMobile),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentList(List<StudentGradeRecord> students, bool isMobile) {
    if (students.isEmpty) return const Center(child: Text("No students enrolled."));

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: ListView.separated(
        itemCount: students.length,
        separatorBuilder: (ctx, i) => const Divider(height: 1),
        itemBuilder: (ctx, i) {
          final student = students[i];
          final studentId = student.studentPublicId!;

          return ListTile(
            contentPadding: EdgeInsets.symmetric(
                horizontal: isMobile ? 12 : 16,
                vertical: 8
            ),
            // Hide avatar on very small screens to save space
            leading: isMobile ? null : CircleAvatar(
              backgroundColor: Colors.blue.shade50,
              child: Text("${i + 1}", style: TextStyle(color: Colors.blue.shade800, fontSize: 12)),
            ),
            title: Text(
              "${student.firstName} ${student.lastName}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: isMobile ? 14 : 16
              ),
            ),
            subtitle: Text("ID: ${student.studentId}", style: const TextStyle(fontSize: 12)),
            trailing: SizedBox(
              width: isMobile ? 70 : 100,
              child: TextFormField(
                initialValue: student.currentScore?.toString() ?? "",
                textAlign: TextAlign.center,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                style: TextStyle(fontSize: isMobile ? 14 : 16),
                decoration: const InputDecoration(
                  hintText: "--",
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.zero,
                ),
                onChanged: (val) {
                  final score = double.tryParse(val);
                  if (score != null) _localScores[studentId] = score;
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildActionButtons(String? courseId, bool isMobile) {
    final buttons = [
      Expanded(
        flex: isMobile ? 1 : 0,
        child: OutlinedButton.icon(
          onPressed: courseId == null ? null : () => _handleSubmission(courseId, 'draft'),
          icon: const Icon(Icons.save_outlined, size: 18),
          label: const Text("Save Draft"),
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: isMobile ? 12 : 20),
          ),
        ),
      ),
      SizedBox(width: isMobile ? 12 : 16, height: isMobile ? 12 : 0),
      Expanded(
        flex: isMobile ? 1 : 0,
        child: ElevatedButton.icon(
          onPressed: courseId == null ? null : () => _showPublishConfirmation(context, courseId),
          icon: const Icon(Icons.cloud_upload, size: 18),
          label: const Text("Publish"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange.shade600,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: isMobile ? 12 : 20),
          ),
        ),
      ),
    ];

    return isMobile
        ? Row(children: buttons) // On mobile, buttons take 50/50 width
        : Row(mainAxisAlignment: MainAxisAlignment.end, children: buttons);
  }

// --- SUBMISSION LOGIC ---

  Future<void> _handleSubmission(String courseId, String status) async {
    // If no local changes, just notify the user
    if (_localScores.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No changes to save"))
      );
      return;
    }

    // Map local state to the generated API model
    final submission = GradeSubmission(
      status: status == 'draft'
          ? GradeSubmissionStatusEnum.draft
          : GradeSubmissionStatusEnum.published,
      grades: _localScores.entries.map((e) => GradeSubmissionGradesInner(
        studentPublicId: e.key,
        score: e.value,
      )).toList(),
    );

    try {
      // Execute the call via the provider
      await ref.read(gradingServiceProvider)(courseId, submission);

      // Clear local buffer on success
      setState(() => _localScores.clear());

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Grades ${status == 'draft' ? 'saved as draft' : 'published'}!"),
              backgroundColor: status == 'draft' ? Colors.blue : Colors.green,
            )
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red)
        );
      }
    }
  }

  // --- DIALOGS ---

  void _showPublishConfirmation(BuildContext context, String courseId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Publish Results?"),
        content: Text(
            "This will make grades visible to all students enrolled in $courseId. This action is usually final. Are you sure?"
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              _handleSubmission(courseId, 'published');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
            ),
            child: const Text("Confirm Publish"),
          ),
        ],
      ),
    );
  }}