import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:admin_api/api.dart' as admin;

import '../../providers/curriculum_providers.dart';

class ExamsPlanningPage extends ConsumerStatefulWidget {
  final admin.Program program;
  final admin.Semester activeSemester;
  final admin.ExamSeason activeSeason;

  const ExamsPlanningPage({
    super.key,
    required this.program,
    required this.activeSemester,
    required this.activeSeason,
  });

  @override
  ConsumerState<ExamsPlanningPage> createState() => _ExamsPlanningPageState();
}

class _ExamsPlanningPageState extends ConsumerState<ExamsPlanningPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Data State
  List<int> _activeSequences = [];
  Map<int, List<admin.ProgramCourse>> _coursesBySequence = {};
  Map<String, admin.ExamPaper> _existingSchedules = {};

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _calculateSequences();
    _loadData();
  }

  void _calculateSequences() {
    int currentSemNum = 1;
    final rawSemNum = widget.activeSemester.semesterNumber;

    if (rawSemNum != null) {
      final String enumStr = rawSemNum.toString();
      final String digits = enumStr.replaceAll(RegExp(r'[^0-9]'), '');
      currentSemNum = int.tryParse(digits) ?? 1;
    }

    final isEven = currentSemNum % 2 == 0;

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

  Future<void> _loadData() async {
    try {
      final curriculum = await ref.read(curriculumProvider(widget.program.publicId!).future);

      _coursesBySequence = {};
      for (var seq in _activeSequences) {
        _coursesBySequence[seq] = curriculum.where((pc) {
          final dynamic pivot = pc.pivot;
          if (pivot == null) return false;

          int? seqVal;
          try {
            seqVal = pivot.semesterSequence;
          } catch (_) {
            try { seqVal = pivot['semester_sequence']; } catch(__){}
          }

          return (seqVal ?? 0) == seq;
        }).toList();
      }

      final schedules = await ref.read(curriculumControllerProvider.notifier)
          .fetchExamSchedules(widget.program.publicId!, widget.activeSeason.publicId!);

      _existingSchedules = {};
      for (var paper in schedules) {
        final dynamic paperDyn = paper;
        String? cId;
        try {
          if (paperDyn.course != null) {
            cId = paperDyn.course.publicId?.toString();
            cId ??= paperDyn.course['public_id']?.toString();
          }
        } catch (_) {}

        if (cId != null) {
          _existingSchedules[cId] = paper;
        }
      }
    } catch (e) {
      debugPrint("Error loading exam data: $e");
    }

    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50, // Lighter background for better contrast
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Exams: ${widget.program.name}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              "${widget.activeSeason.name} (${widget.activeSemester.academicYear})",
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _activeSequences.isEmpty
          ? const Center(child: Text("No active semesters calculated."))
          : Center(
        // Constraint ensures it doesn't look stretched on Ultra-Wide Monitors
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: TabBarView(
            controller: _tabController,
            children: _activeSequences.map((seq) {
              final courses = _coursesBySequence[seq] ?? [];
              if (courses.isEmpty) {
                return const Center(child: Text("No courses found for this semester."));
              }
              return _buildScheduleList(courses);
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildScheduleList(List<admin.ProgramCourse> courses) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: courses.length,
      separatorBuilder: (ctx, i) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final pc = courses[index];
        final String courseId = pc.publicId ?? "";
        final bool isValid = courseId.isNotEmpty;

        return _ExamRowItem(
          key: ValueKey(isValid ? courseId : "error_${pc.hashCode}"),
          courseName: pc.name ?? "Unknown",
          courseCode: pc.code ?? "???",
          courseId: courseId,
          programId: widget.program.publicId!,
          seasonId: widget.activeSeason.publicId!,
          isValid: isValid,
          existingPaper: _existingSchedules[courseId],
          onSave: (paper) {
            setState(() {
              _existingSchedules[courseId] = paper;
            });
          },
        );
      },
    );
  }
}

class _ExamRowItem extends ConsumerStatefulWidget {
  final String courseName;
  final String courseCode;
  final String courseId;
  final String programId;
  final String seasonId;
  final bool isValid;
  final admin.ExamPaper? existingPaper;
  final Function(admin.ExamPaper) onSave;

  const _ExamRowItem({
    super.key,
    required this.courseName,
    required this.courseCode,
    required this.courseId,
    required this.programId,
    required this.seasonId,
    this.isValid = true,
    this.existingPaper,
    required this.onSave,
  });

  @override
  ConsumerState<_ExamRowItem> createState() => _ExamRowItemState();
}

class _ExamRowItemState extends ConsumerState<_ExamRowItem> {
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _durationController = TextEditingController();
  final _locationController = TextEditingController();

  bool _isDirty = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _populateFields();
  }

  @override
  void didUpdateWidget(covariant _ExamRowItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.existingPaper != oldWidget.existingPaper) {
      _populateFields();
    }
  }

  void _populateFields() {
    if (widget.existingPaper != null) {
      final p = widget.existingPaper!;
      if (p.date != null) _dateController.text = p.date.toString().split(" ")[0];
      if (p.startTime != null) {
        String t = p.startTime.toString();
        if (t.length > 5) t = t.substring(0, 5);
        _timeController.text = t;
      }
      _durationController.text = p.durationMinutes?.toString() ?? "120";
      _locationController.text = p.location ?? "";
    } else {
      _durationController.text = "120";
      _dateController.clear();
      _timeController.clear();
      _locationController.clear();
    }
    _isDirty = false;
  }

  void _markDirty(String val) {
    if (!_isDirty) setState(() => _isDirty = true);
  }

  Future<void> _handleSave() async {
    if (!widget.isValid) return;

    if (_dateController.text.isEmpty || _timeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Date and Time are required.")));
      return;
    }

    setState(() => _isSaving = true);

    final success = await ref.read(curriculumControllerProvider.notifier).scheduleExam(
      seasonId: widget.seasonId,
      programId: widget.programId,
      courseId: widget.courseId,
      date: _dateController.text,
      startTime: _timeController.text,
      duration: int.tryParse(_durationController.text) ?? 120,
      location: _locationController.text,
    );

    if (mounted) {
      setState(() => _isSaving = false);
      if (success) {
        setState(() => _isDirty = false);
        // Visual feedback
        widget.onSave(admin.ExamPaper(
          publicId: "temp",
          date: DateTime.parse(_dateController.text),
          startTime: _timeController.text,
          durationMinutes: int.tryParse(_durationController.text) ?? 120,
          location: _locationController.text,
        ));
      }
    }
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final result = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now.subtract(const Duration(days: 365)),
      lastDate: now.add(const Duration(days: 365)),
    );
    if (result != null) {
      _dateController.text = DateFormat('yyyy-MM-dd').format(result);
      _markDirty("");
    }
  }

  Future<void> _pickTime() async {
    final result = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 9, minute: 0),
    );
    if (result != null) {
      final hour = result.hour.toString().padLeft(2, '0');
      final minute = result.minute.toString().padLeft(2, '0');
      _timeController.text = "$hour:$minute";
      _markDirty("");
    }
  }

  InputDecoration _inputDeco(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      isDense: true,
      prefixIcon: Icon(icon, size: 18, color: Colors.grey.shade600),
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade300)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade300)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Colors.blue)),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isValid) {
      return Card(
        color: Colors.red.shade50,
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text("Error: Course ID missing.", style: TextStyle(color: Colors.red)),
        ),
      );
    }

    // Determine Border Color based on state
    Color borderColor = Colors.transparent;
    if (_isDirty) borderColor = Colors.amber; // Unsaved changes
    else if (widget.existingPaper != null) borderColor = Colors.green.shade200; // Saved

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: borderColor, width: _isDirty ? 2 : 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER: Title + Save Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.courseName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text(widget.courseCode, style: const TextStyle(color: Colors.grey, fontSize: 13)),
                    ],
                  ),
                ),
                if (_isSaving)
                  const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2))
                else if (_isDirty)
                  ElevatedButton.icon(
                    onPressed: _handleSave,
                    icon: const Icon(Icons.save, size: 16),
                    label: const Text("Save"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade700,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                  )
                else if (widget.existingPaper != null)
                    Tooltip(
                      message: "Schedule Saved",
                      child: Icon(Icons.check_circle, color: Colors.green.shade600),
                    )
              ],
            ),

            const SizedBox(height: 16),

            // RESPONSIVE INPUTS
            LayoutBuilder(
              builder: (context, constraints) {
                // If width is > 650, show in one row. Else, stack them.
                if (constraints.maxWidth > 650) {
                  return Row(
                    children: [
                      Expanded(flex: 3, child: TextFormField(controller: _dateController, readOnly: true, onTap: _pickDate, decoration: _inputDeco("Date", Icons.calendar_today))),
                      const SizedBox(width: 12),
                      Expanded(flex: 2, child: TextFormField(controller: _timeController, readOnly: true, onTap: _pickTime, decoration: _inputDeco("Time", Icons.access_time))),
                      const SizedBox(width: 12),
                      Expanded(flex: 2, child: TextFormField(controller: _durationController, keyboardType: TextInputType.number, onChanged: _markDirty, decoration: _inputDeco("Mins", Icons.timer_outlined))),
                      const SizedBox(width: 12),
                      Expanded(flex: 4, child: TextFormField(controller: _locationController, onChanged: _markDirty, decoration: _inputDeco("Location", Icons.location_on_outlined))),
                    ],
                  );
                } else {
                  // Mobile Layout: Stacked Rows
                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(flex: 3, child: TextFormField(controller: _dateController, readOnly: true, onTap: _pickDate, decoration: _inputDeco("Date", Icons.calendar_today))),
                          const SizedBox(width: 12),
                          Expanded(flex: 2, child: TextFormField(controller: _timeController, readOnly: true, onTap: _pickTime, decoration: _inputDeco("Time", Icons.access_time))),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(flex: 2, child: TextFormField(controller: _durationController, keyboardType: TextInputType.number, onChanged: _markDirty, decoration: _inputDeco("Mins", Icons.timer_outlined))),
                          const SizedBox(width: 12),
                          Expanded(flex: 3, child: TextFormField(controller: _locationController, onChanged: _markDirty, decoration: _inputDeco("Location", Icons.location_on_outlined))),
                        ],
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}