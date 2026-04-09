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

class SemesterPlanningPage extends ConsumerStatefulWidget {
  final admin.Program program;
  final admin.Semester activeSemester;

  const SemesterPlanningPage({
    super.key,
    required this.program,
    required this.activeSemester,
  });

  @override
  ConsumerState<SemesterPlanningPage> createState() => _SemesterPlanningPageState();
}

class _SemesterPlanningPageState extends ConsumerState<SemesterPlanningPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<int> _activeSequences = [];

  @override
  void initState() {
    super.initState();
    _calculateSequences();
  }

  void _calculateSequences() {
    int currentSemNum = 1;
    final rawSemNum = widget.activeSemester.semesterNumber;

    // Parse Enum to int (Fall=1, Spring=2)
    if (rawSemNum != null) {
      currentSemNum = rawSemNum.value; // Assuming your Enum has a .value getter or similar logic
      // If .value doesn't exist on your generated enum, use the string parsing logic you had:
      // final String enumStr = rawSemNum.toString();
      // final String digits = enumStr.replaceAll(RegExp(r'[^0-9]'), '');
      // currentSemNum = int.tryParse(digits) ?? 1;
    }

    final isEven = currentSemNum % 2 == 0;

    // Determine total semesters (default to 6 if null)
    final dynamic rawTotal = widget.program.totalSemesters;
    final int totalSemesters = (rawTotal is int)
        ? rawTotal
        : int.tryParse(rawTotal?.toString() ?? '') ?? 6;

    _activeSequences = [];
    for (int i = 1; i <= totalSemesters; i++) {
      if ((i % 2 == 0) == isEven) {
        _activeSequences.add(i);
      }
    }

    _tabController = TabController(length: _activeSequences.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 1. Fetch Timetable Entries (For the whole semester period)
    final filter = TimetableFilter(
        semesterId: widget.activeSemester.publicId!,
        programId: widget.program.publicId!
    );
    final timetableAsync = ref.watch(timetableEntriesProvider(filter));

    // 2. Fetch Curriculum (To know which course belongs to which sequence)
    final curriculumAsync = ref.watch(curriculumProvider(widget.program.publicId!));

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Planner: ${widget.program.name}"),
            Text(
              "${widget.activeSemester.academicYear}",
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
            ),
          ],
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.refresh(timetableEntriesProvider(filter));
              ref.refresh(curriculumProvider(widget.program.publicId!));
            },
          ),
        ],
        bottom: _activeSequences.isEmpty
            ? null
            : TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: Colors.blue.shade700,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blue.shade700,
          tabs: _activeSequences.map((seq) => Tab(text: "Semester $seq")).toList(),
        ),
      ),
      body: timetableAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text("Error loading timetable: $e")),
        data: (allEntries) {
          return curriculumAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text("Error loading curriculum: $e")),
            data: (curriculum) {

              if (_activeSequences.isEmpty) {
                return const Center(child: Text("No active semester sequences found."));
              }

              // Create a quick lookup map: CourseID -> Sequence Number
              final Map<String, int> courseSequenceMap = {};
              for (var pc in curriculum) {
                if (pc.publicId != null && pc.pivot.semesterSequence != null) {
                  courseSequenceMap[pc.publicId!] = pc.pivot.semesterSequence!;
                }
              }

              return TabBarView(
                controller: _tabController,
                physics: const NeverScrollableScrollPhysics(), // Prevent accidental swipes if using drag-drop later
                children: _activeSequences.map((sequence) {

                  // Filter entries for this specific tab/sequence
                  final tabEntries = allEntries.where((e) {
                    final courseId = e.course?.publicId;
                    if (courseId == null) return false;
                    return courseSequenceMap[courseId] == sequence;
                  }).toList();

                  return LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth < 700) {
                        return _MobileListView(
                          entries: tabEntries,
                          program: widget.program,
                          semester: widget.activeSemester,
                          targetSequence: sequence,
                        );
                      } else {
                        return _DesktopGridView(
                          entries: tabEntries,
                          program: widget.program,
                          semester: widget.activeSemester,
                          targetSequence: sequence,
                        );
                      }
                    },
                  );
                }).toList(),
              );
            },
          );
        },
      ),
    );
  }
}

// ==========================================
// 1. DESKTOP GRID VIEW
// ==========================================
class _DesktopGridView extends StatefulWidget {
  final List<admin.TimetableEntry> entries;
  final admin.Program program;
  final admin.Semester semester;
  final int targetSequence; // Passed to dialog

  const _DesktopGridView({
    required this.entries,
    required this.program,
    required this.semester,
    required this.targetSequence,
  });

  @override
  State<_DesktopGridView> createState() => _DesktopGridViewState();
}

class _DesktopGridViewState extends State<_DesktopGridView> {
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
    return Scrollbar(
      controller: _horizontalController,
      thumbVisibility: true,
      trackVisibility: true,
      child: SingleChildScrollView(
        controller: _horizontalController,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: 1540,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
              Row(
                children: [
                  const SizedBox(width: 100),
                  ..._times.map((time) => Container(
                    width: 140,
                    padding: const EdgeInsets.only(bottom: 8),
                    alignment: Alignment.center,
                    child: Text(
                      time,
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade600),
                    ),
                  )),
                ],
              ),

              // Vertical Scrollbar
              Expanded(
                child: Scrollbar(
                  controller: _verticalController,
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    controller: _verticalController,
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
                                        widget.semester,
                                        widget.targetSequence // Pass tab sequence
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
  final int targetSequence;

  const _MobileListView({
    required this.entries,
    required this.program,
    required this.semester,
    required this.targetSequence,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: _dayMap.length,
      itemBuilder: (context, index) {
        final dayEntry = _dayMap.entries.elementAt(index);
        final apiDay = dayEntry.value;
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
                    context, apiDay, dayEntry.key, time, entry, program, semester, targetSequence
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

// ------------------------------------------
// UPDATED: Dialog Trigger
// ------------------------------------------
void _showAssignDialog(
    BuildContext context,
    String apiDay,
    String displayDay,
    String time,
    admin.TimetableEntry? entry,
    admin.Program program,
    admin.Semester semester,
    int targetSequence, // New Param: The sequence of the current Tab
    ) {
  showDialog(
    context: context,
    builder: (_) => _AssignClassDialog(
      programId: program.publicId!,
      semesterId: semester.publicId!,
      targetSequence: targetSequence, // Pass it down
      day: apiDay,
      time: time,
      displayDayLabel: displayDay,
      existingEntry: entry,
    ),
  );
}

// ==========================================
// 4. DIALOG (With Specific Sequence Logic)
// ==========================================
class _AssignClassDialog extends ConsumerStatefulWidget {
  final String programId;
  final String semesterId;
  final int targetSequence;
  final String day;
  final String displayDayLabel;
  final String time;
  final admin.TimetableEntry? existingEntry;

  const _AssignClassDialog({
    required this.programId,
    required this.semesterId,
    required this.targetSequence,
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
  String? _selectedRoomId;

  // Validation state
  bool _isLecturerMissing = false;

  List<admin.ProgramCourse> _loadedProgramCourses = [];

  @override
  void initState() {
    super.initState();
    if (widget.existingEntry != null) {
      _selectedRoomId = widget.existingEntry!.location;
      _selectedCourseId = widget.existingEntry!.course?.publicId;
      // We don't need to load lecturer name anymore
    }
  }

  void _onCourseChanged(String? courseId) {
    setState(() {
      _selectedCourseId = courseId;
      _isLecturerMissing = false;

      // Validation: Check if the selected course has a lecturer assigned in the backend
      if (courseId != null && _loadedProgramCourses.isNotEmpty) {
        try {
          final pCourse = _loadedProgramCourses.firstWhere(
                  (pc) => pc.publicId == courseId
          );

          if (pCourse.pivot.lecturer == null) {
            _isLecturerMissing = true;
          }
        } catch (_) {}
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final allCoursesAsync = ref.watch(coursesProvider);
    final curriculumAsync = ref.watch(curriculumProvider(widget.programId));

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
          Text(
            "Semester ${widget.targetSequence}",
            style: TextStyle(fontSize: 12, color: Colors.blue.shade700, fontWeight: FontWeight.bold),
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

              allCoursesAsync.when(
                loading: () => const LinearProgressIndicator(),
                error: (e, _) => Text("Error loading courses: $e"),
                data: (allCourses) {
                  return curriculumAsync.when(
                    loading: () => const SizedBox(),
                    error: (e, _) => Text("Error loading curriculum: $e"),
                    data: (programCourses) {
                      _loadedProgramCourses = programCourses.whereType<admin.ProgramCourse>().toList();

                      // Filter courses: only showing those in the current Semester Sequence
                      final validCourses = allCourses.where((c) {
                        try {
                          final progMatch = _loadedProgramCourses.firstWhere(
                                  (pc) => pc.code == c.code
                          );
                          // ignore: unnecessary_null_comparison
                          if (progMatch.pivot == null) return false;
                          final int courseSeq = progMatch.pivot.semesterSequence ?? 0;
                          return courseSeq == widget.targetSequence;
                        } catch (e) {
                          return false;
                        }
                      }).toList();

                      if (validCourses.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text("No courses available for this semester.", style: TextStyle(color: Colors.red)),
                        );
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 1. Course Dropdown
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

                          // Warning text if course has no lecturer (Validation only, no extra field)
                          if (_isLecturerMissing)
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0, left: 4),
                              child: Text(
                                "Warning: This course has no lecturer assigned in Curriculum settings.",
                                style: TextStyle(color: Colors.red.shade700, fontSize: 12),
                              ),
                            ),

                          const SizedBox(height: 16),

                          // 2. Room Field
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
              ref.read(timetableControllerProvider.notifier).removeClass(
                  entryId: widget.existingEntry!.publicId!,
                  programId: widget.programId,
                  semesterId: widget.semesterId
              );
              Navigator.pop(context);
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          // Disable save if course missing, room missing, or backend validation would fail
          onPressed: (_selectedCourseId == null || _selectedRoomId == null || _isLecturerMissing)
              ? null
              : () async {
            final startParts = widget.time.split(':');
            final endHour = int.parse(startParts[0]) + 1;
            final endTime = "${endHour.toString().padLeft(2, '0')}:${startParts[1]}";

            await ref.read(timetableControllerProvider.notifier).assignClass(
              programId: widget.programId,
              semesterId: widget.semesterId,
              courseId: _selectedCourseId!,
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