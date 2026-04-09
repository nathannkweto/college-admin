import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lecturer_api/api.dart';
import 'package:college_admin/features/lecturer/providers/api_providers.dart';

// Stores the edited score for each student: Map<StudentPublicId, Score>
final gradingStateProvider = StateProvider.autoDispose<Map<String, double>>((ref) => {});

class GradingPage extends ConsumerWidget {
  final String coursePublicId;

  const GradingPage({super.key, required this.coursePublicId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailsAsync = ref.watch(lecturerCourseDetailsProvider(coursePublicId));

    // Watch local changes
    final editedGrades = ref.watch(gradingStateProvider);
    final hasChanges = editedGrades.isNotEmpty;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Grading Sheet"),
        elevation: 0,
      ),
      // --- BOTTOM ACTION BAR ---
      bottomNavigationBar: detailsAsync.when(
        loading: () => const SizedBox.shrink(),
        error: (_, __) => const SizedBox.shrink(),
        data: (details) {
          final students = details.students ?? [];
          final totalStudents = students.length;

          // Calculate how many students have a score (either from API or local edit)
          int filledCount = 0;
          for (var s in students) {
            // Check local edit first, then API data
            final score = editedGrades[s.publicId] ?? s.currentGrade;
            if (score != null) filledCount++;
          }

          final isComplete = filledCount == totalStudents && totalStudents > 0;

          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5)),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  // 1. SAVE DRAFT BUTTON
                  Expanded(
                    child: OutlinedButton(
                      onPressed: hasChanges
                          ? () => _saveGrades(context, ref, editedGrades, isFinal: false)
                          : null,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text("Save Draft"),
                    ),
                  ),
                  const SizedBox(width: 16),

                  // 2. SUBMIT FINAL BUTTON
                  Expanded(
                    child: ElevatedButton(
                      onPressed: isComplete
                          ? () => _saveGrades(context, ref, editedGrades, isFinal: true)
                          : null,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.green.shade600,
                        disabledBackgroundColor: Colors.grey.shade300,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text(
                        "Submit Final",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isComplete ? Colors.white : Colors.grey.shade600
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
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
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                color: Colors.blue.shade50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${course?.code} - ${course?.name}",
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.school, size: 16, color: Colors.blue.shade800),
                        const SizedBox(width: 8),
                        Text(
                          "${program?.name}",
                          style: TextStyle(color: Colors.blue.shade900, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // --- Student List ---
              Expanded(
                child: students.isEmpty
                    ? const Center(child: Text("No students enrolled."))
                    : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: students.length,
                  separatorBuilder: (_, __) => const Divider(height: 32),
                  itemBuilder: (context, index) {
                    final student = students[index];
                    // Determine the score to show: Local Edit > API Data > Null
                    final currentScore = editedGrades[student.publicId] ?? student.currentGrade;

                    return _StudentGradingTile(
                      student: student,
                      score: currentScore,
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

  Future<void> _saveGrades(
      BuildContext context,
      WidgetRef ref,
      Map<String, double> grades,
      {required bool isFinal}
      ) async {

    // 1. Access Provider State
    final detailsValue = ref.read(lecturerCourseDetailsProvider(coursePublicId)).value;

    if (detailsValue == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error: Course details not loaded."))
      );
      return;
    }

    // 2. Extract Data from the GET response
    // We need the Internal Integer ID for the database, not the UUID
    final int? internalId = detailsValue.programCourseId;
    final String semester = detailsValue.context?.semester ?? "2024-2025 Semester 1";

    if (internalId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error: Missing internal Course ID."))
      );
      return;
    }

    // 3. Prepare Submissions
    final submissionsList = grades.entries.map((entry) {
      return GradeSubmission(
        studentPublicId: entry.key,
        totalScore: entry.value,
      );
    }).toList();

    if (submissionsList.isEmpty && !isFinal) return;

    // 4. Create Batch using the INTEGER ID
    final batch = GradeSubmissionBatch(
      programCourseId: internalId, // Pass the int here
      semester: semester,
      submissions: submissionsList,
    );

    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(child: CircularProgressIndicator()),
      );

      // 5. Call API
      // Note: We pass coursePublicId (UUID) for the URL, and batch (with Int ID) for the body
      if (submissionsList.isNotEmpty) {
        await ref.read(gradingActionProvider)(coursePublicId, batch);
      }

      // 6. Cleanup
      ref.read(gradingStateProvider.notifier).state = {};
      ref.invalidate(lecturerCourseDetailsProvider(coursePublicId));

      if (context.mounted) {
        Navigator.pop(context); // Close loading

        final msg = isFinal
            ? "Grades Submitted Successfully!"
            : "Draft Saved.";

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(msg),
              backgroundColor: isFinal ? Colors.green : Colors.blueGrey
          ),
        );

        if (isFinal) {
          Navigator.pop(context);
        }
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
        );
      }
    }
  }
}

// --- Individual Student Row Widget ---
class _StudentGradingTile extends ConsumerStatefulWidget {
  final StudentGradeRecord student;
  final double? score;

  const _StudentGradingTile({required this.student, this.score});

  @override
  ConsumerState<_StudentGradingTile> createState() => _StudentGradingTileState();
}

class _StudentGradingTileState extends ConsumerState<_StudentGradingTile> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.score != null ? widget.score.toString() : "",
    );
  }

  @override
  void didUpdateWidget(covariant _StudentGradingTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.score != oldWidget.score) {
      final val = double.tryParse(_controller.text);
      if (val != widget.score) {
        _controller.text = widget.score?.toString() ?? "";
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Avatar
        CircleAvatar(
          radius: 22,
          backgroundColor: Colors.blue.shade100,
          child: Text(
            widget.student.firstName?[0] ?? "S",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue.shade800),
          ),
        ),
        const SizedBox(width: 16),

        // Name & ID
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${widget.student.firstName} ${widget.student.lastName}",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                widget.student.studentId ?? "No ID",
                style: const TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ],
          ),
        ),

        // Score Input
        Container(
          width: 90,
          decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300)
          ),
          child: TextField(
            controller: _controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            decoration: const InputDecoration(
              hintText: "0.0",
              contentPadding: EdgeInsets.symmetric(vertical: 12),
              border: InputBorder.none,
              isDense: true,
            ),
            onChanged: (val) {
              final score = double.tryParse(val);
              if (score != null && score >= 0 && score <= 100) {
                final currentMap = ref.read(gradingStateProvider);
                ref.read(gradingStateProvider.notifier).state = {
                  ...currentMap,
                  widget.student.publicId!: score
                };
              }
            },
          ),
        ),
      ],
    );
  }
}