import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_api/api.dart' as admin;

// Adjust these imports to match your actual file structure
import 'package:college_admin/core/services/api_service.dart';
import '../../providers/curriculum_providers.dart';
import '../../providers/semester_providers.dart';

// ==========================================
// SEMESTER PLANNING PAGE
// ==========================================
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
    // 1. Create the unique filter for this specific timetable
    final filter = TimetableFilter(
        semesterId: activeSemester.publicId!,
        programId: program.publicId!
    );

    // 2. Watch the provider with that filter
    final timetableAsync = ref.watch(timetableEntriesProvider(filter));

    // Define Grid Constants
    final days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];
    final times = [
      '08:00', '09:00', '10:00', '11:00', '12:00',
      '13:00', '14:00', '15:00', '16:00'
    ];

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Timetable Planner", style: TextStyle(fontSize: 16)),
            Text(
              "${program.code} - ${activeSemester.academicYear}",
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            // Force refresh of the data
            onPressed: () => ref.refresh(timetableEntriesProvider(filter)),
          ),
        ],
      ),
      body: timetableAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text("Error: $e")),
        data: (entries) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  // --- HEADER ROW (Days) ---
                  Row(
                    children: [
                      const SizedBox(width: 60), // Spacer for Time column
                      ...days.map((day) => Container(
                        width: 140,
                        padding: const EdgeInsets.all(8),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Text(
                          day,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey,
                          ),
                        ),
                      )),
                    ],
                  ),

                  // --- TIME SLOTS ---
                  ...times.map((time) {
                    return Row(
                      children: [
                        // Time Label
                        Container(
                          width: 60,
                          height: 80,
                          alignment: Alignment.center,
                          child: Text(
                            time,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        // Day Slots for this specific Time
                        ...days.map((day) {
                          // Safe search: Find entry for this day & time
                          final matches = entries.where((e) =>
                          e.day == day &&
                              e.startTime == "$time:00"
                          ).toList();

                          final entry = matches.isNotEmpty ? matches.first : null;
                          final hasEntry = entry != null;

                          return InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (_) => _AssignClassDialog(
                                  programId: program.publicId!,
                                  semesterId: activeSemester.publicId!,
                                  day: day,
                                  time: time,
                                  existingEntry: entry,
                                ),
                              );
                            },
                            child: Container(
                              width: 140,
                              height: 80,
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey.shade200,
                                ),
                                color: hasEntry
                                    ? Colors.blue.shade50
                                    : Colors.white,
                              ),
                              child: hasEntry
                                  ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    entry!.location ?? "Course",
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  if (entry.location != null)
                                    Text(
                                      entry.location!,
                                      style: const TextStyle(
                                        fontSize: 10,
                                        color: Colors.grey,
                                      ),
                                    ),
                                ],
                              )
                                  : const Center(
                                child: Icon(
                                  Icons.add,
                                  size: 16,
                                  color: Colors.grey,
                                ),
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
          );
        },
      ),
    );
  }
}

// ==========================================
// 3. DIALOG TO ASSIGN CLASS
// ==========================================
class _AssignClassDialog extends ConsumerStatefulWidget {
  final String programId;
  final String semesterId;
  final String day;
  final String time;
  final admin.TimetableEntry? existingEntry;

  const _AssignClassDialog({
    required this.programId,
    required this.semesterId,
    required this.day,
    required this.time,
    this.existingEntry,
  });

  @override
  ConsumerState<_AssignClassDialog> createState() => _AssignClassDialogState();
}

class _AssignClassDialogState extends ConsumerState<_AssignClassDialog> {
  String? _selectedCourseId;
  String? _selectedRoomId;

  @override
  void initState() {
    super.initState();
    // Pre-fill if editing an existing entry
    if (widget.existingEntry != null) {
      _selectedCourseId = widget.existingEntry!.location;
      _selectedRoomId = widget.existingEntry!.location;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Fetch Courses for this Program
    final curriculumAsync = ref.watch(curriculumProvider(widget.programId));

    return AlertDialog(
      title: Text("Schedule: ${widget.day} @ ${widget.time}"),
      content: SizedBox(
        width: 350,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            curriculumAsync.when(
              loading: () => const LinearProgressIndicator(),
              error: (e, _) => Text("Error loading courses: $e"),
              data: (courses) {
                // Safely cast to expected type
                final safeCourses = courses.whereType<admin.ProgramCourse>().toList();

                return DropdownButtonFormField<String>(
                  value: _selectedCourseId,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    labelText: "Select Course",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.book),
                  ),
                  items: safeCourses.map((c) {
                    return DropdownMenuItem(
                      value: c.publicId,
                      child: Text(
                        "${c.code ?? ''} - ${c.name ?? ''}",
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),
                  onChanged: (v) => setState(() => _selectedCourseId = v),
                );
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: widget.existingEntry?.location,
              decoration: const InputDecoration(
                labelText: "Room Name (Optional)",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.meeting_room),
              ),
              onChanged: (v) {
                // Room update logic here if needed
              },
            ),
          ],
        ),
      ),
      actions: [
        if (widget.existingEntry != null)
          TextButton(
            onPressed: () async {
              // Delete Action via Controller
              final success = await ref
                  .read(timetableControllerProvider.notifier)
                  .removeClass(
                entryId: widget.existingEntry!.publicId!,
                programId: widget.programId,
                semesterId: widget.semesterId,
              );
              if (success && mounted) Navigator.pop(context);
            },
            child: const Text("Clear Slot", style: TextStyle(color: Colors.red)),
          ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: _selectedCourseId == null
              ? null
              : () async {
            // Assign Action via Controller
            final success = await ref
                .read(timetableControllerProvider.notifier)
                .assignClass(
              programId: widget.programId,
              semesterId: widget.semesterId,
              courseId: _selectedCourseId!,
              day: widget.day,
              startTime: widget.time,
              // roomId: _selectedRoomId, // Pass if IDs implemented
            );

            if (success && mounted) Navigator.pop(context);
          },
          child: const Text("Assign"),
        ),
      ],
    );
  }
}