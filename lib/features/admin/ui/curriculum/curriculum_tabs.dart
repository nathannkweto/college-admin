import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart'; // Added for date formatting
import 'package:admin_api/api.dart' as admin;

import '../../providers/curriculum_providers.dart';
import 'curriculum_dialogs.dart'; // Ensure this matches the file name from the previous step

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
    final activeSemAsync = ref.watch(activeSemesterProvider);
    final programsAsync = ref.watch(programsProvider);

    return activeSemAsync.when(
      loading: () => const Center(child: LinearProgressIndicator()),
      error: (e, _) => _buildError(ref, activeSemesterProvider),
      data: (activeSemester) {
        final hasActive = activeSemester != null;

        return SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- STATUS HERO ---
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: hasActive
                        ? [Colors.blue.shade800, Colors.blue.shade600]
                        : [Colors.grey.shade800, Colors.grey.shade700],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: !hasActive
                    ? _buildInactiveState(context)
                    : _buildActiveState(context, ref, activeSemester),
              ),

              const SizedBox(height: 32),

              // --- LOGISTICS & TIMETABLES ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Logistics & Timetables",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  if (hasActive)
                    Chip(
                      label: const Text("Edit Mode"),
                      backgroundColor: Colors.orange.shade50,
                      labelStyle: TextStyle(color: Colors.orange.shade900),
                      avatar: Icon(
                        Icons.edit,
                        size: 14,
                        color: Colors.orange.shade900,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),

              programsAsync.when(
                loading: () => const LinearProgressIndicator(),
                error: (_, __) => const SizedBox(),
                data: (programs) {
                  if (programs.isEmpty)
                    return const Text("No programs defined yet.");

                  return Column(
                    children: programs
                        .map(
                          (p) => Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(color: Colors.grey.shade200),
                        ),
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          title: Text(p.name ?? "Unknown Program"),
                          subtitle: Text(
                            "${p.totalSemesters ?? 0} Semesters • ${p.code ?? ''}",
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Colors.grey,
                          ),
                          onTap: () {
                            // Placeholder: Navigate to Timetable/Exam Schedule management for this specific program
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Timetable management coming soon",
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                        .toList(),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // --- WIDGET STATES ---

  Widget _buildInactiveState(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "System Idle",
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),
        const SizedBox(height: 8),
        const Text(
          "No Active Semester",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),
        ElevatedButton.icon(
          onPressed: () => showDialog(
            context: context,
            builder: (_) => const AddSemesterDialog(),
          ),
          icon: const Icon(Icons.play_arrow_rounded, color: Colors.blue),
          label: const Text("Start New Semester"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.blue.shade800,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildActiveState(
      BuildContext context,
      WidgetRef ref,
      admin.Semester semester,
      ) {
    final progress = _calculateSemesterProgress(
      semester.startDate,
      semester.lengthWeeks,
    );
    final semId = semester.publicId;
    final semNumDisplay =
    semester.semesterNumber?.toString().contains("number2") == true
        ? "2"
        : "1";

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.greenAccent.shade400,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    "In Progress",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "${semester.academicYear ?? 'N/A'} • Semester $semNumDisplay",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  progress['status'] as String,
                  style: TextStyle(color: Colors.blue.shade100, fontSize: 14),
                ),
              ],
            ),

            // Progress Display
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Week",
                  style: TextStyle(color: Colors.blue.shade100, fontSize: 12),
                ),
                Text(
                  "${progress['current']}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "of ${progress['total']}",
                  style: TextStyle(color: Colors.blue.shade100, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                // Opens the dialog which now AUTO-LINKS to this active semester
                onPressed: () => showDialog(
                  context: context,
                  builder: (_) => const AddExamSeasonDialog(),
                ),
                icon: const Icon(Icons.assignment_rounded),
                label: const Text("Start Exams"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue.shade900,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => _confirmEndSemester(context, ref, semId),
                icon: const Icon(Icons.power_settings_new_rounded),
                label: const Text("End Semester"),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red.shade100,
                  side: BorderSide(color: Colors.red.shade200),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _confirmEndSemester(
      BuildContext context,
      WidgetRef ref,
      String? semesterId,
      ) {
    if (semesterId == null) return;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("End Current Semester?"),
        content: const Text(
          "This will deactivate the semester and stop all timetable tracking.\n\n"
              "• Classes will be archived.\n"
              "• Status will change to Inactive.\n\n"
              "Are you sure you want to proceed?",
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
              await ref
                  .read(curriculumControllerProvider.notifier)
                  .endSemester(semesterId);
            },
            child: const Text(
              "End Semester",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> _calculateSemesterProgress(
      DateTime? startDate,
      int? lengthWeeks,
      ) {
    if (startDate == null || lengthWeeks == null) {
      return {"current": 0, "total": 0, "status": "Unknown"};
    }

    final now = DateTime.now();
    final difference = now.difference(startDate).inDays;

    // Calculate current week (1-based index)
    int currentWeek = (difference / 7).ceil();
    if (currentWeek < 1) currentWeek = 1;

    String status = "On Track";
    if (currentWeek > lengthWeeks) {
      currentWeek = lengthWeeks; // Cap it
      status = "Overdue / Finals";
    }

    return {"current": currentWeek, "total": lengthWeeks, "status": status};
  }
}

// ==========================================
// 2. DEPARTMENTS TAB
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
          error: (_, __) => const SizedBox(), // Fail silently for courses if dept loads
          data: (courses) {
            return Column(
              children: [
                _buildActionBar(
                  "Add Department",
                      () {
                    // showDialog(context: context, builder: (_) => const AddDepartmentDialog());
                  },
                ),
                Expanded(
                  child: departments.isEmpty
                      ? const Center(
                    child: Text(
                      "No departments yet.",
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                      : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 80, left: 16, right: 16),
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
                            // showDialog(
                            //   context: context,
                            //   builder: (_) => AddCourseDialog(initialDeptId: dept.publicId),
                            // );
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
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                                leading: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade50,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Icon(
                                    Icons.menu_book_rounded,
                                    size: 16,
                                    color: Colors.blue.shade700,
                                  ),
                                ),
                                title: Text(
                                  c.name ?? "Unknown Course",
                                  style: const TextStyle(fontWeight: FontWeight.w500),
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
          )
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
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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

// ==========================================
// 3. PROGRAMS TAB
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
                  // Add Qualification Logic
                  // showDialog(context: context, builder: (_) => const AddQualificationDialog());
                },
                icon: const Icon(Icons.workspace_premium),
                label: const Text("Add Qualification"),
                style: TextButton.styleFrom(foregroundColor: Colors.blue.shade700),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () {
                  // Add Program Logic
                  // showDialog(context: context, builder: (_) => const AddProgramDialog());
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
                    if (matchingPrograms.isEmpty) return const SizedBox.shrink();

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
                      .where((p) => p.publicId != null && !assignedProgramIds.contains(p.publicId))
                      .toList();

                  // D. Empty State
                  if (programs.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.school_outlined, size: 48, color: Colors.grey.shade300),
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
                          subtitle: "Programs not linked to a specific qualification",
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
        if (p.publicId != null) {
          // Open your drill-down dialog
          // showDialog(context: context, builder: (ctx) => ProgramCurriculumDialog(program: p));
        }
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
          )
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


