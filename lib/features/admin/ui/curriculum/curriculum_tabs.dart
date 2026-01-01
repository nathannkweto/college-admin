import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:admin_api/api.dart' as admin;

import '../../providers/curriculum_providers.dart';
import 'curriculum_dialogs.dart';

import 'semester_planning_page.dart';
import 'exams_planning_page.dart';

// ==========================================
// STYLING HELPERS
// ==========================================
final _headerStyle = TextStyle(
  color: Colors.blueGrey.shade900,
  fontWeight: FontWeight.bold,
  fontSize: 16,
);
final _subHeaderStyle = TextStyle(
  color: Colors.blueGrey.shade700,
  fontWeight: FontWeight.w600,
  fontSize: 14,
);

Widget _buildSeamlessGroupCard({
  required String title,
  required String subtitle,
  required List<Widget> children,
  Widget? action,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 24),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.grey.shade200),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: _headerStyle),
                    const SizedBox(height: 4),
                    Text(subtitle, style: _subHeaderStyle),
                  ],
                ),
              ),
              if (action != null) action,
            ],
          ),
        ),
        ...children,
      ],
    ),
  );
}

Widget _buildActionBar(String label, VoidCallback onTap) {
  return Align(
    alignment: Alignment.centerRight,
    child: Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: const Icon(Icons.add_rounded, size: 20),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue.shade700,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
      ),
    ),
  );
}

Widget _buildError(WidgetRef ref, ProviderBase provider) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.sync_problem_rounded,
          color: Colors.redAccent,
          size: 32,
        ),
        const SizedBox(height: 12),
        const Text(
          "Failed to load data",
          style: TextStyle(color: Colors.blueGrey),
        ),
        TextButton(
          onPressed: () => ref.invalidate(provider),
          child: const Text("Retry"),
        ),
      ],
    ),
  );
}

// ==========================================
// 1. SEMESTERS & EXAMS TAB
// ==========================================
class SemestersExamsTab extends ConsumerWidget {
  const SemestersExamsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Watch both Semester and Exam Season
    final activeSemAsync = ref.watch(activeSemesterProvider);
    final activeExamAsync = ref.watch(activeExamSeasonProvider);
    final programsAsync = ref.watch(programsProvider);

    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return activeSemAsync.when(
      loading: () => const Center(child: LinearProgressIndicator()),
      error: (e, _) => Center(child: Text("Error: $e")),
      data: (activeSemester) {
        final hasActiveSemester = activeSemester != null;

        // Resolve the exam season state
        // We only care about the data if a semester exists
        final activeExamSeason = activeExamAsync.valueOrNull;
        final isExamMode = activeExamSeason != null && hasActiveSemester;

        return SingleChildScrollView(
          padding: EdgeInsets.all(isMobile ? 16 : 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- RESPONSIVE STATUS HERO ---
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(isMobile ? 20 : 24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: _getGradientColors(hasActiveSemester, isExamMode),
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: (hasActiveSemester
                          ? (isExamMode ? Colors.red : Colors.blue)
                          : Colors.grey)
                          .withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: !hasActiveSemester
                    ? _buildInactiveState(context, isMobile)
                    : _buildActiveState(
                  context,
                  ref,
                  activeSemester,
                  activeExamSeason, // Pass the exam season
                  isMobile,
                ),
              ),

              const SizedBox(height: 32),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isExamMode ? "Exam Schedules" : "Logistics & Timetables",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  if (isExamMode)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.red.shade200)
                      ),
                      child: Text(
                          "READ-ONLY MODE",
                          style: TextStyle(fontSize: 10, color: Colors.red.shade800, fontWeight: FontWeight.bold)
                      ),
                    )
                ],
              ),
              const SizedBox(height: 16),

              programsAsync.when(
                loading: () => const LinearProgressIndicator(),
                error: (_, __) => const Text("Error loading programs"),
                data: (programs) {
                  if (programs.isEmpty) {
                    return const Text("No programs defined yet.");
                  }

                  if (activeSemester == null) {
                    return const Text("Start a semester to view timetables.");
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: programs.length,
                    itemBuilder: (context, index) => _buildProgramCard(
                      context,
                      programs[index],
                      activeSemester,
                      activeExamSeason, // Pass for navigation logic
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // --- BUILDERS ---

  Widget _buildActiveState(
      BuildContext context,
      WidgetRef ref,
      admin.Semester semester,
      admin.ExamSeason? examSeason,
      bool isMobile,
      ) {
    DateTime? startDate;
    try {
      if (semester.startDate is DateTime) {
        startDate = semester.startDate as DateTime;
      } else if (semester.startDate != null) {
        startDate = DateTime.parse(semester.startDate.toString());
      }
    } catch (e) {
      debugPrint("Date parsing error: $e");
    }

    final progress = _calculateSemesterProgress(
      startDate,
      semester.lengthWeeks,
    );
    final semVal = semester.semesterNumber?.toString() ?? "";
    final semNumDisplay = (semVal.contains("2") || semVal.contains("number2"))
        ? "2"
        : "1";

    final isExamMode = examSeason != null;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Status Badge
                  _buildStatusBadge(
                      isExamMode ? "EXAM PERIOD" : "IN PROGRESS",
                      isExamMode ? Colors.redAccent : Colors.greenAccent.shade400
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "${semester.academicYear ?? 'N/A'}",
                    style: TextStyle(color: Colors.blue.shade50, fontSize: 14),
                  ),
                  Text(
                    isExamMode
                        ? (examSeason.name ?? "Exams")
                        : "Semester $semNumDisplay",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isMobile ? 22 : 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isExamMode
                        ? "Grading portals are open for lecturers."
                        : progress['status'] as String,
                    style: TextStyle(color: Colors.blue.shade100, fontSize: 13),
                  ),
                ],
              ),
            ),
            // Hide week display during exams to reduce clutter, or keep it if you prefer
            if (!isExamMode)
              _buildWeekDisplay(progress['current'], progress['total'], isMobile),
          ],
        ),
        const SizedBox(height: 24),
        _buildActionButtons(context, ref, semester.publicId, examSeason, isMobile),
      ],
    );
  }

  Widget _buildActionButtons(
      BuildContext context,
      WidgetRef ref,
      String? semId,
      admin.ExamSeason? examSeason,
      bool isMobile,
      ) {
    final isExamMode = examSeason != null;
    final buttons = <Widget>[];

    if (isExamMode) {
      // --- EXAM MODE ACTIONS ---
      // Only "End Exams" is shown (prominently)
      buttons.add(
        Expanded(
          flex: isMobile ? 0 : 1,
          child: ElevatedButton.icon(
            onPressed: () => _confirmEndExams(context, ref, examSeason.publicId),
            icon: const Icon(Icons.stop_circle_outlined, size: 18),
            label: const Text("End Exams"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.red.shade900,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ),
      );
    } else {
      // --- NORMAL SEMESTER ACTIONS ---
      // 1. Start Exams
      buttons.add(
        Expanded(
          flex: isMobile ? 0 : 1,
          child: ElevatedButton.icon(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const AddExamSeasonDialog(),
              );
            },
            icon: const Icon(Icons.assignment_rounded, size: 18),
            label: const Text("Start Exams"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.blue.shade900,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ),
      );

      buttons.add(SizedBox(width: isMobile ? 0 : 12, height: isMobile ? 12 : 0));

      // 2. End Semester
      buttons.add(
        Expanded(
          flex: isMobile ? 0 : 1,
          child: OutlinedButton.icon(
            onPressed: () => _confirmEndSemester(context, ref, semId),
            icon: const Icon(Icons.power_settings_new_rounded, size: 18),
            label: const Text("End Semester"),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.red.shade100,
              side: BorderSide(color: Colors.red.shade200),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ),
      );
    }

    return isMobile
        ? Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: buttons,
    )
        : Row(children: buttons);
  }

  Widget _buildWeekDisplay(dynamic current, dynamic total, bool isMobile) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Text(
            "WEEK",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "$current",
            style: TextStyle(
              color: Colors.white,
              fontSize: isMobile ? 28 : 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "OF $total",
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInactiveState(BuildContext context, bool isMobile) {
    return Column(
      crossAxisAlignment: isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        const Text(
          "System Idle",
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),
        const SizedBox(height: 8),
        Text(
          "No Active Semester",
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: isMobile ? double.infinity : null,
          child: ElevatedButton.icon(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const AddSemesterDialog(),
              );
            },
            icon: const Icon(Icons.play_arrow_rounded),
            label: const Text("Start New Semester"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.blue.shade800,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProgramCard(
      BuildContext context,
      admin.Program p,
      admin.Semester activeSemester,
      admin.ExamSeason? examSeason, // Added
      ) {

    final isExamMode = examSeason != null;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isExamMode ? Colors.red.shade50 : Colors.blue.shade50,
          child: Icon(
            isExamMode ? Icons.assignment_late_outlined : Icons.school_outlined,
            color: isExamMode ? Colors.red.shade700 : Colors.blue.shade700,
            size: 20,
          ),
        ),
        title: Text(
          p.name ?? "Unknown Program",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(isExamMode ? "View Exam Schedule" : (p.code ?? 'No Code')),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 14,
          color: Colors.grey,
        ),
        onTap: () {
          // LOGIC BRANCHING FOR NAVIGATION
          if (isExamMode) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ExamsPlanningPage(
                  program: p,
                  activeSemester: activeSemester,
                  activeSeason: examSeason!,
                ),
              ),
            );
          } else {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SemesterPlanningPage(
                  program: p,
                  activeSemester: activeSemester,
                ),
              ),
            );
          }
        },
      ),
    );
  }

  // --- ACTIONS ---

  void _confirmEndSemester(BuildContext context, WidgetRef ref, String? semesterId) {
    if (semesterId == null) return;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("End Current Semester?"),
        content: const Text(
          "This action will deactivate the current semester. It cannot be undone easily. Proceed?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              Navigator.pop(ctx);
              await ref.read(curriculumControllerProvider.notifier).endSemester(semesterId);
            },
            child: const Text("End Semester", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _confirmEndExams(BuildContext context, WidgetRef ref, String? examSeasonId) {
    if (examSeasonId == null) return;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("End Exam Season?"),
        content: const Text(
          "This will close the grading portals and finish the exam period. The semester will remain active for final wrapping up.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              Navigator.pop(ctx);
              await ref.read(curriculumControllerProvider.notifier).endExamSession(examSeasonId);
            },
            child: const Text("End Exams", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // --- HELPERS ---

  List<Color> _getGradientColors(bool hasActive, bool isExamMode) {
    if (!hasActive) {
      return [Colors.grey.shade800, Colors.grey.shade700];
    }
    if (isExamMode) {
      return [Colors.red.shade800, Colors.red.shade600];
    }
    return [Colors.blue.shade800, Colors.blue.shade600];
  }

  Widget _buildStatusBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 10,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Map<String, dynamic> _calculateSemesterProgress(
      DateTime? startDate,
      int? lengthWeeks,
      ) {
    if (startDate == null || lengthWeeks == null || lengthWeeks == 0) {
      return {"current": 0, "total": lengthWeeks ?? 0, "status": "Not Started"};
    }

    final now = DateTime.now();
    final difference = now.difference(startDate).inDays;
    int currentWeek = (difference / 7).ceil();

    if (currentWeek < 1) {
      return {"current": 0, "total": lengthWeeks, "status": "Starting Soon"};
    }

    String status = "On Track";
    if (currentWeek > lengthWeeks) {
      currentWeek = lengthWeeks;
      status = "Semester Concluded";
    } else if (currentWeek > lengthWeeks - 2) {
      status = "Finals Approaching";
    }

    return {"current": currentWeek, "total": lengthWeeks, "status": status};
  }
}
// ==========================================
// 2. PROGRAMS TAB
// ==========================================
class ProgramsTab extends ConsumerWidget {
  const ProgramsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final programsAsync = ref.watch(programsProvider);
    final qualsAsync = ref.watch(qualificationsProvider);

    return Column(
      children: [
        // --- ACTION BAR ---
        Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const AddQualificationDialog(),
                  );
                },
                icon: const Icon(Icons.workspace_premium),
                label: const Text("Add Qualification"),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.blue.shade700,
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const AddProgramDialog(),
                  );
                },
                icon: const Icon(Icons.add, size: 18),
                label: const Text("Add Program"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade700,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                ),
              ),
            ],
          ),
        ),

        // --- CONTENT AREA ---
        Expanded(
          child: programsAsync.when(
            loading: () => const Center(child: LinearProgressIndicator()),
            error: (e, s) => _buildErrorWidget(ref, "programs"),
            data: (programs) {
              return qualsAsync.when(
                loading: () => const Center(child: LinearProgressIndicator()),
                error: (e, s) => _buildErrorWidget(ref, "qualifications"),
                data: (qualifications) {
                  //

                  // A. Track which programs have been assigned to a group
                  final assignedProgramIds = <String>{};

                  // B. Create Groups for each Qualification
                  final qualificationGroups = qualifications.map((qual) {
                    final qualId = qual.publicId;

                    // Filter programs that match this qualification
                    final matchingPrograms = programs.where((p) {
                      // FIX: Safe access to the nested object
                      final pQualId = p.qualification?.publicId;

                      // Match check
                      final isMatch = (pQualId != null && pQualId == qualId);

                      if (isMatch) assignedProgramIds.add(p.publicId!);
                      return isMatch;
                    }).toList();

                    // If no programs for this qualification, don't show the group
                    if (matchingPrograms.isEmpty)
                      return const SizedBox.shrink();

                    return _buildSeamlessGroupCard(
                      title: qual.name ?? "Unnamed Qualification",
                      subtitle: "Code: ${qual.code ?? '-'}",
                      children: matchingPrograms
                          .map((p) => _buildProgramTile(context, p))
                          .toList(),
                    );
                  }).toList();

                  // C. Find Unassigned Programs (orphans)
                  final unassignedPrograms = programs
                      .where(
                        (p) =>
                            p.publicId != null &&
                            !assignedProgramIds.contains(p.publicId),
                      )
                      .toList();

                  // D. Empty State
                  if (programs.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.school_outlined,
                            size: 48,
                            color: Colors.grey.shade300,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            "No programs found.\nClick 'Add Program' to get started.",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    );
                  }

                  // E. Render Final List
                  return ListView(
                    padding: const EdgeInsets.only(bottom: 80),
                    children: [
                      ...qualificationGroups,

                      // Show orphans at the bottom if any exist
                      if (unassignedPrograms.isNotEmpty)
                        _buildSeamlessGroupCard(
                          title: "Unassigned Programs",
                          subtitle:
                              "Programs not linked to a specific qualification",
                          children: unassignedPrograms
                              .map((p) => _buildProgramTile(context, p))
                              .toList(),
                        ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProgramTile(BuildContext context, admin.Program p) {
    return ListTile(
      onTap: () {
        if (p.publicId == null) return;

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => ProgramCurriculumDialog(program: p),
        );
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: CircleAvatar(
        backgroundColor: Colors.blue.shade50,
        radius: 18,
        child: Text(
          (p.totalSemesters ?? 0).toString(),
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade800,
          ),
        ),
      ),
      title: Text(
        p.name ?? "Unknown Program",
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
      ),
      subtitle: Text(
        "${p.code ?? "No Code"} • ${p.totalSemesters} Semesters",
        style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
      ),
      trailing: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(
          Icons.edit_calendar_rounded,
          size: 18,
          color: Colors.blueGrey,
        ),
      ),
    );
  }

  Widget _buildErrorWidget(WidgetRef ref, String itemName) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, color: Colors.red),
          const SizedBox(height: 8),
          Text("Error loading $itemName"),
          TextButton(
            onPressed: () {
              ref.invalidate(programsProvider);
              ref.invalidate(qualificationsProvider);
            },
            child: const Text("Retry"),
          ),
        ],
      ),
    );
  }

  Widget _buildSeamlessGroupCard({
    required String title,
    required String subtitle,
    required List<Widget> children,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 24),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            color: Colors.grey.shade50,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, thickness: 1),
          ...children,
        ],
      ),
    );
  }
}

// ==========================================
// 3. DEPARTMENTS TAB
// ==========================================
class DepartmentsTab extends ConsumerWidget {
  const DepartmentsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deptsAsync = ref.watch(departmentsProvider);
    final coursesAsync = ref.watch(coursesProvider);

    return deptsAsync.when(
      loading: () => const Center(child: LinearProgressIndicator()),
      error: (e, st) => _buildErrorView(ref),
      data: (departments) {
        return coursesAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, __) =>
              const SizedBox(), // Fail silently for courses if dept loads
          data: (courses) {
            return Column(
              children: [
                _buildActionBar("Add Department", () {
                  showDialog(
                    context: context,
                    builder: (_) => const AddDepartmentDialog(),
                  );
                }),
                Expanded(
                  child: departments.isEmpty
                      ? const Center(
                          child: Text(
                            "No departments yet.",
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.only(
                            bottom: 80,
                            left: 16,
                            right: 16,
                          ),
                          itemCount: departments.length,
                          itemBuilder: (context, index) {
                            final dept = departments[index];

                            // FILTER LOGIC
                            final deptCourses = courses.where((c) {
                              // We safely check the nested object
                              return c.department?.publicId == dept.publicId;
                            }).toList();

                            return _buildSeamlessGroupCard(
                              title: dept.name ?? "Unknown Department",
                              subtitle: "Code: ${dept.code ?? '-'}",
                              action: IconButton(
                                icon: const Icon(
                                  Icons.add_circle_outline,
                                  color: Colors.blue,
                                ),
                                tooltip: "Add Course to ${dept.code}",
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => AddCourseDialog(
                                      initialDeptId: dept.publicId,
                                    ),
                                  );
                                },
                              ),
                              children: [
                                if (deptCourses.isEmpty)
                                  const Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Text(
                                      "No courses recorded.",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 13,
                                      ),
                                    ),
                                  )
                                else
                                  ...deptCourses.map(
                                    (c) => ListTile(
                                      dense: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            horizontal: 16,
                                          ),
                                      leading: Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color: Colors.blue.shade50,
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.menu_book_rounded,
                                          size: 16,
                                          color: Colors.blue.shade700,
                                        ),
                                      ),
                                      title: Text(
                                        c.name ?? "Unknown Course",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      subtitle: Text(c.code ?? ""),
                                      trailing: const Icon(
                                        Icons.chevron_right,
                                        size: 16,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                              ],
                            );
                          },
                        ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildErrorView(WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 48),
          const SizedBox(height: 16),
          const Text("Error loading departments"),
          TextButton(
            onPressed: () => ref.invalidate(departmentsProvider),
            child: const Text("Retry"),
          ),
        ],
      ),
    );
  }

  Widget _buildActionBar(String label, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton.icon(
            onPressed: onTap,
            icon: const Icon(Icons.add, size: 18),
            label: Text(label),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade700,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSeamlessGroupCard({
    required String title,
    required String subtitle,
    required Widget action,
    required List<Widget> children,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 24),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            color: Colors.grey.shade50,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                action,
              ],
            ),
          ),
          const Divider(height: 1, thickness: 1),
          ...children,
        ],
      ),
    );
  }
}
