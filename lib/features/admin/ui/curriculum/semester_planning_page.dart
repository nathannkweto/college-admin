import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_api/api.dart' as admin;

// Adjust imports to your specific structure
import 'package:college_admin/core/services/api_service.dart';
import '../../providers/curriculum_providers.dart';
import '../../providers/semester_providers.dart';

// --- CONSTANTS ---
final Map<String, String> _dayMap = {
  'Monday': 'MON',
  'Tuesday': 'TUE',
  'Wednesday': 'WED',
  'Thursday': 'THU',
  'Friday': 'FRI',
  'Saturday': 'SAT',
};

final List<String> _times = [
  '08:00', '09:00', '10:00', '11:00', '12:00',
  '13:00', '14:00', '15:00', '16:00', '17:00'
];

class SemesterPlanningPage extends ConsumerWidget {
  final admin.Program program;
  final admin.Semester activeSemester;

  const SemesterPlanningPage({
    super.key,
    required this.program,
    required this.activeSemester,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = TimetableFilter(
        semesterId: activeSemester.publicId!,
        programId: program.publicId!
    );
    final timetableAsync = ref.watch(timetableEntriesProvider(filter));

    return Scaffold(
      appBar: AppBar(
        title: Text("Planner: ${program.name}"),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.refresh(timetableEntriesProvider(filter)),
          ),
        ],
      ),
      body: timetableAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text("Error: $e")),
        data: (entries) {
          return LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 700) {
                // MOBILE VIEW: Vertical List of Days
                return _MobileListView(
                  entries: entries,
                  program: program,
                  semester: activeSemester,
                );
              } else {
                // DESKTOP VIEW: Grid (Days Vertical, Time Horizontal)
                return _DesktopGridView(
                  entries: entries,
                  program: program,
                  semester: activeSemester,
                );
              }
            },
          );
        },
      ),
    );
  }
}

// ==========================================
// 1. DESKTOP GRID VIEW (FIXED)
// ==========================================
class _DesktopGridView extends StatefulWidget {
  final List<admin.TimetableEntry> entries;
  final admin.Program program;
  final admin.Semester semester;

  const _DesktopGridView({
    required this.entries,
    required this.program,
    required this.semester,
  });

  @override
  State<_DesktopGridView> createState() => _DesktopGridViewState();
}

class _DesktopGridViewState extends State<_DesktopGridView> {
  // [FIX] explicit controllers for scrollbars
  final ScrollController _horizontalController = ScrollController();
  final ScrollController _verticalController = ScrollController();

  @override
  void dispose() {
    _horizontalController.dispose();
    _verticalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 1. Horizontal Scrollbar
    return Scrollbar(
      controller: _horizontalController,
      thumbVisibility: true,
      trackVisibility: true,
      child: SingleChildScrollView(
        controller: _horizontalController, // Attach Horizontal
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          // Ensure width constraint so vertical scrollbar appears at edge
          width: 1540, // 100 (Header) + 144 * 10 (Time slots)
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
              Row(
                children: [
                  const SizedBox(width: 100),
                  ..._times.map((time) => Container(
                    width: 140, // Match slot width
                    padding: const EdgeInsets.only(bottom: 8),
                    alignment: Alignment.center,
                    child: Text(
                      time,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  )),
                ],
              ),

              // 2. Vertical Scrollbar (Wrapped around content)
              Expanded(
                child: Scrollbar(
                  controller: _verticalController,
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    controller: _verticalController, // Attach Vertical
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        ..._dayMap.entries.map((dayEntry) {
                          return Row(
                            children: [
                              // Day Label
                              Container(
                                width: 100,
                                height: 100,
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.only(right: 16),
                                child: Text(
                                  dayEntry.key,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                              ),

                              // Time Slots
                              ..._times.map((time) {
                                final entry = _findEntry(widget.entries, dayEntry.value, time);

                                return Container(
                                  width: 140,
                                  height: 100,
                                  padding: const EdgeInsets.all(4),
                                  child: _TimetableSlotCard(
                                    entry: entry,
                                    onTap: () => _showAssignDialog(
                                        context,
                                        dayEntry.value,
                                        dayEntry.key,
                                        time,
                                        entry,
                                        widget.program,
                                        widget.semester
                                    ),
                                  ),
                                );
                              }),
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 2. MOBILE LIST VIEW
// ==========================================
class _MobileListView extends StatelessWidget {
  final List<admin.TimetableEntry> entries;
  final admin.Program program;
  final admin.Semester semester;

  const _MobileListView({
    required this.entries,
    required this.program,
    required this.semester,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: _dayMap.length,
      itemBuilder: (context, index) {
        final dayEntry = _dayMap.entries.elementAt(index);
        final apiDay = dayEntry.value;

        // Count entries for this day to show a badge or summary
        final dayEntriesCount = entries.where((e) => e.day == apiDay).length;

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ExpansionTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue.shade50,
              child: Text(apiDay.substring(0, 1), style: TextStyle(color: Colors.blue.shade800)),
            ),
            title: Text(dayEntry.key, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text("$dayEntriesCount classes scheduled"),
            children: _times.map((time) {
              final entry = _findEntry(entries, apiDay, time);
              final hasEntry = entry != null;

              return ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                leading: Container(
                  width: 50,
                  alignment: Alignment.centerLeft,
                  child: Text(time, style: const TextStyle(fontWeight: FontWeight.w500)),
                ),
                title: hasEntry
                    ? Text(entry!.course?.name ?? "Unknown Course", maxLines: 1, overflow: TextOverflow.ellipsis)
                    : const Text("Free Slot", style: TextStyle(color: Colors.grey, fontSize: 13)),
                trailing: hasEntry
                    ? const Icon(Icons.edit, size: 16, color: Colors.blue)
                    : const Icon(Icons.add, size: 16, color: Colors.grey),
                onTap: () => _showAssignDialog(
                    context, apiDay, dayEntry.key, time, entry, program, semester
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

// ==========================================
// 3. SHARED COMPONENTS
// ==========================================

class _TimetableSlotCard extends StatelessWidget {
  final admin.TimetableEntry? entry;
  final VoidCallback onTap;

  const _TimetableSlotCard({required this.entry, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final hasEntry = entry != null;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
          color: hasEntry ? Colors.blue.shade50 : Colors.white,
          border: Border.all(color: hasEntry ? Colors.blue.shade200 : Colors.grey.shade200),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(6),
        alignment: Alignment.center,
        child: hasEntry
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              entry!.course?.code ?? "",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.blue),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 2),
            if (entry!.lecturer != null)
              Text(
                entry!.lecturer!.lastName ?? "Unknown",
                style: TextStyle(fontSize: 10, color: Colors.blue.shade900),
                overflow: TextOverflow.ellipsis,
              ),
            const SizedBox(height: 2),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
              child: Text(
                entry!.location ?? "N/A",
                style: TextStyle(fontSize: 9, color: Colors.grey.shade700),
              ),
            )
          ],
        )
            : const Icon(Icons.add, color: Colors.grey, size: 20),
      ),
    );
  }
}

// Helper to find entry in the list
admin.TimetableEntry? _findEntry(List<admin.TimetableEntry> entries, String day, String time) {
  try {
    return entries.firstWhere((e) {
      final entryStart = (e.startTime ?? "").substring(0, 5);
      return e.day == day && entryStart == time;
    });
  } catch (e) {
    return null;
  }
}

// Helper to trigger dialog
void _showAssignDialog(
    BuildContext context,
    String apiDay,
    String displayDay,
    String time,
    admin.TimetableEntry? entry,
    admin.Program program,
    admin.Semester semester,
    ) {
  showDialog(
    context: context,
    builder: (_) => _AssignClassDialog(
      programId: program.publicId!,
      semesterId: semester.publicId!,
      day: apiDay,
      time: time,
      displayDayLabel: displayDay,
      existingEntry: entry,
    ),
  );
}

// ==========================================
// 4. DIALOG (Cleaned Up)
// ==========================================
class _AssignClassDialog extends ConsumerStatefulWidget {
  final String programId;
  final String semesterId;
  final String day; // "MON"
  final String displayDayLabel; // "Monday"
  final String time;
  final admin.TimetableEntry? existingEntry;

  const _AssignClassDialog({
    required this.programId,
    required this.semesterId,
    required this.day,
    required this.displayDayLabel,
    required this.time,
    this.existingEntry,
  });

  @override
  ConsumerState<_AssignClassDialog> createState() => _AssignClassDialogState();
}

class _AssignClassDialogState extends ConsumerState<_AssignClassDialog> {
  String? _selectedCourseId;
  String? _selectedLecturerId;
  String? _selectedRoomId;
  List<admin.ProgramCourse> _loadedProgramCourses = [];

  @override
  void initState() {
    super.initState();
    if (widget.existingEntry != null) {
      // In a real app, you might need to find the ID by matching objects if IDs aren't direct
      // Here we assume simple mapping for the UI state
      _selectedRoomId = widget.existingEntry!.location;
      _selectedCourseId = widget.existingEntry!.course?.publicId;
      _selectedLecturerId = widget.existingEntry!.lecturer?.publicId;
    }
  }

  void _onCourseChanged(String? courseId) {
    setState(() {
      _selectedCourseId = courseId;
      _selectedLecturerId = null;

      // Auto-select default lecturer logic
      if (courseId != null && _loadedProgramCourses.isNotEmpty) {
        try {
          final pCourse = _loadedProgramCourses.firstWhere((pc) => pc.publicId == courseId);
          if (pCourse.pivot?.lecturer?.publicId != null) {
            _selectedLecturerId = pCourse.pivot!.lecturer!.publicId;
          }
        } catch (_) {}
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final allCoursesAsync = ref.watch(coursesProvider);
    final curriculumAsync = ref.watch(curriculumProvider(widget.programId));
    final lecturersAsync = ref.watch(lecturersProvider);

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.existingEntry == null ? "Assign Class" : "Edit Class"),
          const SizedBox(height: 4),
          Text(
            "${widget.displayDayLabel} at ${widget.time}",
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600, fontWeight: FontWeight.normal),
          ),
        ],
      ),
      content: SizedBox(
        width: 400,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),

              // Load Data Wrappers
              allCoursesAsync.when(
                loading: () => const LinearProgressIndicator(),
                error: (e, _) => Text("Error loading courses: $e"),
                data: (allCourses) {
                  return curriculumAsync.when(
                    loading: () => const SizedBox(),
                    error: (e, _) => Text("Error loading curriculum: $e"),
                    data: (programCourses) {
                      _loadedProgramCourses = programCourses.whereType<admin.ProgramCourse>().toList();

                      // Filter valid courses
                      final validCodes = _loadedProgramCourses.map((pc) => pc.code).toSet();
                      final validCourses = allCourses
                          .where((c) => validCodes.contains(c.code) && c.publicId != null)
                          .toList();

                      return Column(
                        children: [
                          DropdownButtonFormField<String>(
                            value: _selectedCourseId,
                            isExpanded: true,
                            decoration: const InputDecoration(
                              labelText: "Course",
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.book, size: 20),
                            ),
                            items: validCourses.map((c) => DropdownMenuItem(
                              value: c.publicId,
                              child: Text("${c.code} - ${c.name}", overflow: TextOverflow.ellipsis),
                            )).toList(),
                            onChanged: _onCourseChanged,
                          ),
                          const SizedBox(height: 16),

                          // Lecturers
                          lecturersAsync.when(
                            loading: () => const LinearProgressIndicator(),
                            error: (_,__) => const Text("Error loading lecturers"),
                            data: (lecturers) => DropdownButtonFormField<String>(
                              value: _selectedLecturerId,
                              isExpanded: true,
                              decoration: const InputDecoration(
                                labelText: "Lecturer",
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.person, size: 20),
                              ),
                              items: lecturers.map((l) => DropdownMenuItem(
                                value: l.publicId,
                                child: Text("${l.firstName} ${l.lastName}"),
                              )).toList(),
                              onChanged: (v) => setState(() => _selectedLecturerId = v),
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Room
                          TextFormField(
                            initialValue: _selectedRoomId,
                            decoration: const InputDecoration(
                              labelText: "Room",
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.room, size: 20),
                            ),
                            onChanged: (v) => _selectedRoomId = v,
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        if (widget.existingEntry != null)
          TextButton(
            onPressed: () {
              // Implement Delete logic
              Navigator.pop(context);
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: (_selectedCourseId == null || _selectedLecturerId == null || _selectedRoomId == null)
              ? null
              : () async {
            // Simple logic: End time is Start Time + 1 hour
            final startParts = widget.time.split(':');
            final endHour = int.parse(startParts[0]) + 1;
            final endTime = "${endHour.toString().padLeft(2, '0')}:${startParts[1]}";

            await ref.read(timetableControllerProvider.notifier).assignClass(
              programId: widget.programId,
              semesterId: widget.semesterId,
              courseId: _selectedCourseId!,
              lecturerId: _selectedLecturerId!,
              day: widget.day,
              startTime: widget.time,
              endTime: endTime,
              location: _selectedRoomId!,
            );

            if (mounted) Navigator.pop(context);
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}