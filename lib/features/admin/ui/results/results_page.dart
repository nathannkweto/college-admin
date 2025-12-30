import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_api/api.dart' as admin;
import 'package:college_admin/core/services/api_service.dart';
import '../../providers/results_provider.dart';

class ResultsPage extends ConsumerStatefulWidget {
  const ResultsPage({super.key});

  @override
  ConsumerState<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends ConsumerState<ResultsPage> {
  String? _selectedSemesterId;
  String? _selectedProgramId;
  List<admin.Semester> _semesters = [];
  List<admin.Program> _programs = [];
  bool _isLoadingFilters = true;

  @override
  void initState() {
    super.initState();
    _loadFilters();
  }

  Future<void> _loadFilters() async {
    try {
      final semRes = await ApiService().timetables.semestersGet();
      final progRes = await ApiService().academics.programsGet();

      if (mounted) {
        setState(() {
          _semesters = semRes?.data?.toList() ?? [];
          _programs = progRes?.data?.toList() ?? [];

          if (_semesters.isNotEmpty) {
            try {
              final active = _semesters.firstWhere((s) => s.isActive == true);
              _selectedSemesterId = active.publicId;
            } catch (e) {
              _selectedSemesterId = _semesters.first.publicId;
            }
          }
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
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 650;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text("Academic Results"),
        elevation: 0,
        centerTitle: isMobile,
      ),
      body: Column(
        children: [
          // --- RESPONSIVE FILTER SECTION ---
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
            ),
            child: _isLoadingFilters
                ? const LinearProgressIndicator()
                : Flex(
              direction: isMobile ? Axis.vertical : Axis.horizontal,
              children: [
                Expanded(
                  flex: isMobile ? 0 : 1,
                  child: _buildFilterDropdown(
                    label: "Semester",
                    value: _selectedSemesterId,
                    items: _semesters.map((s) => DropdownMenuItem(
                      value: s.publicId!,
                      child: Text("${s.academicYear} (Sem ${s.semesterNumber})"),
                    )).toList(),
                    onChanged: (val) => setState(() => _selectedSemesterId = val),
                  ),
                ),
                SizedBox(width: isMobile ? 0 : 16, height: isMobile ? 12 : 0),
                Expanded(
                  flex: isMobile ? 0 : 1,
                  child: _buildFilterDropdown(
                    label: "Program",
                    value: _selectedProgramId,
                    items: _programs.map((p) => DropdownMenuItem(
                      value: p.publicId!,
                      child: Text(p.name ?? 'Unnamed Program', overflow: TextOverflow.ellipsis),
                    )).toList(),
                    onChanged: (val) => setState(() => _selectedProgramId = val),
                  ),
                ),
              ],
            ),
          ),

          // --- MAIN CONTENT AREA ---
          Expanded(
            child: (_selectedSemesterId == null || _selectedProgramId == null)
                ? const Center(child: Text("Please select a Semester and Program"))
                : _ResultsListView(
              programId: _selectedProgramId!,
              semesterId: _selectedSemesterId!,
              isMobile: isMobile,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterDropdown({
    required String label,
    required String? value,
    required List<DropdownMenuItem<String>> items,
    required ValueChanged<String?> onChanged
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      isExpanded: true,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      items: items,
      onChanged: onChanged,
    );
  }
}

class _ResultsListView extends ConsumerWidget {
  final String programId;
  final String semesterId;
  final bool isMobile;

  const _ResultsListView({
    required this.programId,
    required this.semesterId,
    required this.isMobile
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ResultsFilter(programId: programId, semesterId: semesterId);
    final asyncValue = ref.watch(programResultsProvider(filter));

    return asyncValue.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(child: Text("Error: $err")),
      data: (response) {
        final List<admin.StudentResultSummary> students = response.data?.toList() ?? [];
        final bool isPublished = response.isPublished ?? false;

        if (students.isEmpty) {
          return const Center(child: Text("No students found in this program."));
        }

        return Column(
          children: [
            // --- ACTION BAR ---
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: Colors.white,
              child: Row(
                children: [
                  Text(
                    "${students.length} Students",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade700),
                  ),
                  const Spacer(),
                  _PublishButton(
                    programId: programId,
                    semesterId: semesterId,
                    isPublished: isPublished,
                    isCompact: isMobile,
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            // --- STUDENT LIST ---
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.all(isMobile ? 12 : 16),
                itemCount: students.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  return _StudentSummaryCard(
                    student: students[index],
                    semesterId: semesterId,
                    isMobile: isMobile,
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
  final bool isCompact;

  const _PublishButton({
    required this.programId,
    required this.semesterId,
    required this.isPublished,
    required this.isCompact,
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
          ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
          : Icon(isPublished ? Icons.visibility_off : Icons.visibility, size: 18),
      label: Text(isCompact
          ? (isPublished ? "Unpublish" : "Publish")
          : (isPublished ? "Unpublish Results" : "Publish Results")),
      style: ElevatedButton.styleFrom(
        backgroundColor: isPublished ? Colors.orange.shade700 : Colors.green.shade700,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: EdgeInsets.symmetric(horizontal: isCompact ? 12 : 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
  final bool isMobile;

  const _StudentSummaryCard({
    required this.student,
    required this.semesterId,
    required this.isMobile
  });

  Color _getStatusColor(admin.StudentResultSummarySemesterDecisionEnum? decision) {
    switch (decision) {
      case admin.StudentResultSummarySemesterDecisionEnum.PROMOTED:
        return Colors.green;
      case admin.StudentResultSummarySemesterDecisionEnum.REPEAT:
        return Colors.red;
      case admin.StudentResultSummarySemesterDecisionEnum.DISMISSED:
        return Colors.black;
      default:
        return Colors.blueGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final decisionEnum = student.semesterDecision;
    final decisionText = decisionEnum?.value ?? "PENDING";

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
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
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              CircleAvatar(
                radius: isMobile ? 18 : 22,
                backgroundColor: Colors.blue.shade50,
                child: Text(
                  (student.firstName?.isNotEmpty ?? false) ? student.firstName![0] : "?",
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue.shade800),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${student.firstName ?? ''} ${student.lastName ?? ''}",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: isMobile ? 14 : 16),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      student.studentId ?? "No ID",
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Avg: ${student.averageScore?.toStringAsFixed(1) ?? '-'}",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: _getStatusColor(decisionEnum).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      decisionText,
                      style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: _getStatusColor(decisionEnum)),
                    ),
                  ),
                ],
              ),
              const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
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
    final filter = TranscriptFilter(studentId: studentId, semesterId: semesterId);
    final asyncValue = ref.watch(studentTranscriptProvider(filter));
    final screenWidth = MediaQuery.of(context).size.width;

    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(20),
        constraints: const BoxConstraints(maxWidth: 700, maxHeight: 600),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: Text(studentName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
              ],
            ),
            const Divider(),
            Expanded(
              child: asyncValue.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, _) => Center(child: Text("Error: $err")),
                data: (transcript) {
                  final results = transcript.results ?? [];
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _statTile("GPA", transcript.semesterGpa?.toStringAsFixed(2) ?? "-"),
                          _statTile("Standing", transcript.academicStanding ?? "N/A"),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // HORIZONTAL SCROLL FIX FOR DATA TABLE
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              columnSpacing: 20,
                              headingRowHeight: 45,
                              columns: const [
                                DataColumn(label: Text("Course")),
                                DataColumn(label: Text("CA"), numeric: true),
                                DataColumn(label: Text("Exam"), numeric: true),
                                DataColumn(label: Text("Total"), numeric: true),
                                DataColumn(label: Text("Grade")),
                              ],
                              rows: results.map((r) => DataRow(cells: [
                                DataCell(SizedBox(width: 140, child: Text(r.courseName ?? "-", overflow: TextOverflow.ellipsis))),
                                DataCell(Text(r.caScore?.toString() ?? "-")),
                                DataCell(Text(r.examScore?.toString() ?? "-")),
                                DataCell(Text(r.totalScore?.toString() ?? "-", style: const TextStyle(fontWeight: FontWeight.bold))),
                                DataCell(_buildGradeBadge(r.grade)),
                              ])).toList(),
                            ),
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
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 11)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue)),
      ],
    );
  }

  Widget _buildGradeBadge(String? grade) {
    if (grade == null) return const Text("-");
    Color color = Colors.grey;
    if (grade.startsWith('A') || grade.startsWith('B')) color = Colors.green;
    else if (grade.startsWith('C')) color = Colors.orange;
    else if (grade.startsWith('D') || grade == 'F') color = Colors.red;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
      child: Text(grade, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12)),
    );
  }
}