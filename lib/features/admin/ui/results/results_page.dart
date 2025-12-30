import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_api/api.dart' as admin;

// Import your services and providers
import 'package:college_admin/core/services/api_service.dart';
import '../../providers/results_provider.dart';

class ResultsPage extends ConsumerStatefulWidget {
  const ResultsPage({super.key});

  @override
  ConsumerState<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends ConsumerState<ResultsPage> {
  // Selection State
  String? _selectedSemesterId;
  String? _selectedProgramId;

  // Dropdown Data State
  List<admin.Semester> _semesters = [];
  List<admin.Program> _programs = [];
  bool _isLoadingFilters = true;

  @override
  void initState() {
    super.initState();
    _loadFilters();
  }

  // Fetch Semesters and Programs for the Dropdowns
  Future<void> _loadFilters() async {
    try {
      // 1. Fetch wrappers
      final semRes = await ApiService().timetables.semestersGet();
      final progRes = await ApiService().academics.programsGet();

      if (mounted) {
        setState(() {
          // 2. Extract .data from wrappers
          _semesters = semRes?.data?.toList() ?? [];
          _programs = progRes?.data?.toList() ?? [];

          // 3. Set Active Semester Default
          if (_semesters.isNotEmpty) {
            try {
              final active = _semesters.firstWhere((s) => s.isActive == true);
              _selectedSemesterId = active.publicId;
            } catch (e) {
              _selectedSemesterId = _semesters.first.publicId;
            }
          }

          // 4. Set Program Default
          if (_programs.isNotEmpty) {
            _selectedProgramId = _programs.first.publicId;
          }

          _isLoadingFilters = false;
        });
      }
    } catch (e) {
      debugPrint("Error loading filters: $e");
      if (mounted) setState(() => _isLoadingFilters = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Academic Results"), elevation: 0),
      body: Column(
        children: [
          // ------------------------------------
          // 1. FILTER SECTION (Semester & Program)
          // ------------------------------------
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: _isLoadingFilters
                ? const LinearProgressIndicator()
                : Row(
              children: [
                // Semester Dropdown
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedSemesterId,
                    decoration: const InputDecoration(
                      labelText: "Semester",
                      border: OutlineInputBorder(),
                    ),
                    items: _semesters.map((s) {
                      return DropdownMenuItem(
                        value: s.publicId!,
                        child: Text(
                          "${s.academicYear} (Sem ${s.semesterNumber})",
                        ),
                      );
                    }).toList(),
                    onChanged: (val) =>
                        setState(() => _selectedSemesterId = val),
                  ),
                ),
                const SizedBox(width: 16),
                // Program Dropdown
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedProgramId,
                    decoration: const InputDecoration(
                      labelText: "Program",
                      border: OutlineInputBorder(),
                    ),
                    items: _programs.map((p) {
                      return DropdownMenuItem(
                        value: p.publicId!,
                        child: Text(
                          p.name ?? 'Unnamed Program',
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
                    onChanged: (val) =>
                        setState(() => _selectedProgramId = val),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),

          // ------------------------------------
          // 2. MAIN CONTENT AREA
          // ------------------------------------
          Expanded(
            child: (_selectedSemesterId == null || _selectedProgramId == null)
                ? const Center(
              child: Text("Please select a Semester and Program"),
            )
                : _ResultsListView(
              programId: _selectedProgramId!,
              semesterId: _selectedSemesterId!,
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// SUB-WIDGET: The List of Students
// ==========================================
class _ResultsListView extends ConsumerWidget {
  final String programId;
  final String semesterId;

  const _ResultsListView({required this.programId, required this.semesterId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Create the Filter Object
    final filter = ResultsFilter(programId: programId, semesterId: semesterId);

    // 2. Watch the Provider using the Filter
    final asyncValue = ref.watch(programResultsProvider(filter));

    return asyncValue.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text("Error: $err")),
      data: (response) {
        // 3. Extract data from the Generated API Response object
        // NOTE: resultsProgramSummaryGet now returns an object with .data and .isPublished
        final List<admin.StudentResultSummary> students =
            response.data?.toList() ?? [];
        final bool isPublished = response.isPublished ?? false;

        if (students.isEmpty) {
          return const Center(
            child: Text("No students found enrolled in this program."),
          );
        }

        return Column(
          children: [
            // --- ACTION BAR (Publish Button) ---
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Colors.grey[50],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${students.length} Students",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),

                  // PUBLISH BUTTON
                  _PublishButton(
                    programId: programId,
                    semesterId: semesterId,
                    isPublished: isPublished,
                  ),
                ],
              ),
            ),

            // --- STUDENT LIST ---
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: students.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final student = students[index];
                  return _StudentSummaryCard(
                    student: student,
                    semesterId: semesterId, // Passed down for the drill-down
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

// ==========================================
// SUB-WIDGET: Publish Button Logic
// ==========================================
class _PublishButton extends ConsumerWidget {
  final String programId;
  final String semesterId;
  final bool isPublished;

  const _PublishButton({
    required this.programId,
    required this.semesterId,
    required this.isPublished,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controllerState = ref.watch(publishResultsControllerProvider);
    final isLoading = controllerState is AsyncLoading;

    return ElevatedButton.icon(
      onPressed: isLoading
          ? null
          : () async {
        await ref
            .read(publishResultsControllerProvider.notifier)
            .togglePublication(
          programId: programId,
          semesterId: semesterId,
          currentStatusIsPublished: isPublished,
        );
      },
      icon: isLoading
          ? const SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(strokeWidth: 2),
      )
          : Icon(isPublished ? Icons.visibility_off : Icons.visibility),
      label: Text(isPublished ? "Unpublish Results" : "Publish Results"),
      style: ElevatedButton.styleFrom(
        backgroundColor: isPublished ? Colors.orange : Colors.green,
        foregroundColor: Colors.white,
      ),
    );
  }
}

// ==========================================
// SUB-WIDGET: Individual Student Card
// ==========================================
class _StudentSummaryCard extends StatelessWidget {
  final admin.StudentResultSummary student;
  final String semesterId;

  const _StudentSummaryCard({required this.student, required this.semesterId});

  Color _getStatusColor(
      admin.StudentResultSummarySemesterDecisionEnum? decision) {
    // UPDATED: Using strongly typed Enums
    switch (decision) {
      case admin.StudentResultSummarySemesterDecisionEnum.PROMOTED:
        return Colors.green;
      case admin.StudentResultSummarySemesterDecisionEnum.REPEAT:
        return Colors.red;
      case admin.StudentResultSummarySemesterDecisionEnum.DISMISSED:
        return Colors.black;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Access Enum Value
    final decisionEnum = student.semesterDecision;
    final decisionText = decisionEnum?.value ?? "PENDING";


    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          // OPEN DETAIL DIALOG
          if (student.studentPublicId != null) {
            showDialog(
              context: context,
              builder: (_) => _StudentTranscriptDialog(
                studentId: student.studentPublicId!,
                semesterId: semesterId,
                studentName: "${student.firstName} ${student.lastName}",
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Avatar / Initials
              CircleAvatar(
                backgroundColor: Colors.blue.shade50,
                child: Text(
                  (student.firstName != null && student.firstName!.isNotEmpty)
                      ? student.firstName![0]
                      : "?",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Name & ID
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${student.firstName ?? ''} ${student.lastName ?? ''}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      student.studentId ?? "No ID",
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    ),
                  ],
                ),
              ),

              // Stats Column
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Avg: ${student.averageScore?.toStringAsFixed(1) ?? '-'}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: _getStatusColor(decisionEnum).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      decisionText,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: _getStatusColor(decisionEnum),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 8),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// DIALOG: Student Transcript (Drill Down)
// ==========================================
class _StudentTranscriptDialog extends ConsumerWidget {
  final String studentId;
  final String semesterId;
  final String studentName;

  const _StudentTranscriptDialog({
    required this.studentId,
    required this.semesterId,
    required this.studentName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Create Filter
    final filter = TranscriptFilter(
      studentId: studentId,
      semesterId: semesterId,
    );

    // 2. Watch Provider
    final asyncValue = ref.watch(studentTranscriptProvider(filter));

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(24),
        constraints: const BoxConstraints(maxWidth: 500, maxHeight: 600),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "Results: $studentName",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const Divider(),
            Expanded(
              child: asyncValue.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, _) => Center(child: Text("Error: $err")),
                data: (transcript) {
                  // No data wrapper here based on spec, direct object
                  final results = transcript.results ?? [];

                  return Column(
                    children: [
                      // Header Stats
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _statTile(
                            "GPA",
                            transcript.semesterGpa?.toStringAsFixed(2) ?? "-",
                          ),
                          _statTile(
                            "Standing",
                            transcript.academicStanding ?? "N/A",
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Data Table
                      Expanded(
                        child: SingleChildScrollView(
                          child: DataTable(
                            columnSpacing: 12,
                            headingRowHeight: 40,
                            columns: const [
                              DataColumn(
                                label: Text(
                                  "Course",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "CA",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                numeric: true,
                              ),
                              DataColumn(
                                label: Text(
                                  "Exam",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                numeric: true,
                              ),
                              DataColumn(
                                label: Text(
                                  "Total",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                numeric: true,
                              ),
                              DataColumn(
                                label: Text(
                                  "Grade",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                            rows: results.map((r) {
                              return DataRow(
                                cells: [
                                  DataCell(
                                    SizedBox(
                                      width: 120,
                                      child: Text(
                                        r.courseName ?? "-",
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  DataCell(Text(r.caScore?.toString() ?? "-")),
                                  DataCell(
                                    Text(r.examScore?.toString() ?? "-"),
                                  ),
                                  DataCell(
                                    Text(
                                      r.totalScore?.toString() ?? "-",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  DataCell(_buildGradeBadge(r.grade)),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statTile(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ],
    );
  }

  Widget _buildGradeBadge(String? grade) {
    if (grade == null) return const Text("-");
    Color color = Colors.grey;
    if (grade.startsWith('A') || grade.startsWith('B')) color = Colors.green;
    if (grade.startsWith('C')) color = Colors.orange;
    if (grade.startsWith('D') || grade == 'F') color = Colors.red;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        grade,
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }
}