import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lecturer_api/api.dart'; // Generated API package
import 'package:college_admin/features/lecturer/providers/api_providers.dart';

// --- Local State for Editing Grades ---
// Stores the edited score for each student: Map<StudentPublicId, Score>
final gradingStateProvider = StateProvider.autoDispose<Map<String, double>>((ref) => {});

class GradingPage extends ConsumerWidget {
  final String coursePublicId;

  const GradingPage({super.key, required this.coursePublicId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Fetch Data
    final detailsAsync = ref.watch(lecturerCourseDetailsProvider(coursePublicId));

    // 2. Watch local changes
    final editedGrades = ref.watch(gradingStateProvider);
    final hasUnsavedChanges = editedGrades.isNotEmpty;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Grading Sheet"),
        // Removed the top action button in favor of the bottom bar
      ),
      // --- ADDED: Bottom Submit Bar ---
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: ElevatedButton.icon(
            onPressed: hasUnsavedChanges
                ? () => _submitGrades(context, ref, editedGrades)
                : null,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Colors.blueAccent,
              disabledBackgroundColor: Colors.grey.shade300,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            icon: Icon(Icons.check_circle, color: hasUnsavedChanges ? Colors.white : Colors.grey),
            label: Text(
              hasUnsavedChanges
                  ? "Submit Changes (${editedGrades.length})"
                  : "No Changes to Submit",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: hasUnsavedChanges ? Colors.white : Colors.grey.shade600
              ),
            ),
          ),
        ),
      ),
      body: detailsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text("Error: $err")),
        data: (details) {
          final students = details.students ?? [];
          final course = details.course;
          final program = details.program;

          return Column(
            children: [
              // --- Header Info ---
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: Colors.blue.shade50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${course?.code} - ${course?.name}",
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${program?.name} • Sem ${details.context?.semesterSequence}",
                      style: TextStyle(color: Colors.blue.shade800),
                    ),
                  ],
                ),
              ),

              // --- Student List ---
              Expanded(
                child: students.isEmpty
                    ? const Center(child: Text("No students enrolled in this course."))
                    : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: students.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, index) {
                    final student = students[index];
                    return _StudentGradingTile(
                      student: student,
                      // Use edited value if present, else fallback to existing grade from API
                      initialScore: editedGrades[student.publicId] ?? student.currentGrade,
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _submitGrades(BuildContext context, WidgetRef ref, Map<String, double> grades) async {
    // Construct payload
    final submissions = grades.entries.map((entry) {
      return GradeSubmission(
        studentPublicId: entry.key,
        totalScore: entry.value,
      );
    }).toList();

    final batch = GradeSubmissionBatch(students: submissions);

    try {
      // Show loading dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(child: CircularProgressIndicator()),
      );

      // Call API
      await ref.read(gradingActionProvider)(coursePublicId, batch);

      // Clear local state on success
      ref.read(gradingStateProvider.notifier).state = {};

      if (context.mounted) {
        Navigator.pop(context); // Close loading
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Grades submitted successfully!"), backgroundColor: Colors.green),
        );
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.pop(context); // Close loading
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Submission Failed: $e"), backgroundColor: Colors.red),
        );
      }
    }
  }
}

// --- Individual Student Row Widget ---
class _StudentGradingTile extends ConsumerStatefulWidget {
  final StudentGradeRecord student;
  final double? initialScore;

  const _StudentGradingTile({required this.student, this.initialScore});

  @override
  ConsumerState<_StudentGradingTile> createState() => _StudentGradingTileState();
}

class _StudentGradingTileState extends ConsumerState<_StudentGradingTile> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.initialScore != null ? widget.initialScore.toString() : "",
    );
  }

  @override
  void didUpdateWidget(covariant _StudentGradingTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If the provider refreshes (after save), update the text field
    if (widget.initialScore != oldWidget.initialScore) {
      // Avoid overwriting if the user is currently typing (cursor check could be added for perfection)
      // For now, only update if the parsed value is different to avoid glitches
      if (double.tryParse(_controller.text) != widget.initialScore) {
        _controller.text = widget.initialScore?.toString() ?? "";
      }
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _calculateGrade(double score) {
    if (score >= 80) return 'A';
    if (score >= 70) return 'B';
    if (score >= 60) return 'C';
    if (score >= 50) return 'D';
    if (score >= 45) return 'E';
    return 'F';
  }

  Color _getGradeColor(String grade) {
    if (grade == 'F') return Colors.red;
    if (grade == 'A') return Colors.green;
    return Colors.blueGrey;
  }

  @override
  Widget build(BuildContext context) {
    // Current valid score parsed from text field for preview
    final double? currentScore = double.tryParse(_controller.text);
    final String gradePreview = currentScore != null ? _calculateGrade(currentScore) : "-";

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          // 1. Student Avatar & Name
          CircleAvatar(
            backgroundColor: Colors.grey.shade200,
            child: Text(
              widget.student.firstName?[0] ?? "S",
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.student.firstName} ${widget.student.lastName}",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                Text(
                  widget.student.studentId ?? "",
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),

          // 2. Grade Preview (Visual Feedback)
          Container(
            width: 40,
            alignment: Alignment.center,
            child: Text(
              gradePreview,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: _getGradeColor(gradePreview)
              ),
            ),
          ),
          const SizedBox(width: 16),

          // 3. Score Input Field
          SizedBox(
            width: 80,
            child: TextField(
              controller: _controller,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')), // Allow decimals
              ],
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: "-",
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                isDense: true,
              ),
              onChanged: (val) {
                final score = double.tryParse(val);
                if (score != null && score <= 100) {
                  // Update global state map
                  final currentMap = ref.read(gradingStateProvider);
                  ref.read(gradingStateProvider.notifier).state = {
                    ...currentMap,
                    widget.student.publicId!: score
                  };
                  // Trigger local rebuild for Grade Preview color/text
                  setState(() {});
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}