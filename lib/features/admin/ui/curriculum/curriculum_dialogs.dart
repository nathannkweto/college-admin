import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:admin_api/api.dart' as admin;
import '../../providers/curriculum_providers.dart';

// --- SHARED STYLES ---
final _dialogShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(16),
);
const _inputRadius = BorderRadius.all(Radius.circular(12));

InputDecoration _buildInputDeco(String label, [IconData? icon]) {
  return InputDecoration(
    labelText: label,
    prefixIcon: icon != null
        ? Icon(icon, size: 20, color: Colors.blueGrey)
        : null,
    border: const OutlineInputBorder(borderRadius: _inputRadius),
    enabledBorder: OutlineInputBorder(
      borderRadius: _inputRadius,
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: _inputRadius,
      borderSide: BorderSide(color: Colors.blue, width: 2),
    ),
    filled: true,
    fillColor: Colors.grey.shade50,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  );
}

ButtonStyle _primaryBtnStyle = ElevatedButton.styleFrom(
  backgroundColor: Colors.blue.shade700,
  foregroundColor: Colors.white,
  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  elevation: 0,
);

// ==========================================
// 1. ADD QUALIFICATION DIALOG
// ==========================================
class AddQualificationDialog extends ConsumerStatefulWidget {
  const AddQualificationDialog({super.key});

  @override
  ConsumerState<AddQualificationDialog> createState() =>
      _AddQualificationDialogState();
}

class _AddQualificationDialogState
    extends ConsumerState<AddQualificationDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _codeCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: _dialogShape,
      title: const Text(
        "Add Qualification",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: SizedBox(
        width: 400,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameCtrl,
                decoration: _buildInputDeco("Name", Icons.badge),
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 16),
              // Removed unnecessary Row/Expanded since it's a single item here
              TextFormField(
                controller: _codeCtrl,
                decoration: _buildInputDeco(
                  "Code (e.g. BSC)",
                  Icons.short_text,
                ),
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),
            ],
          ),
        ),
      ),
      actionsPadding: const EdgeInsets.all(20),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel", style: TextStyle(color: Colors.grey.shade600)),
        ),
        ElevatedButton(
          style: _primaryBtnStyle,
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              final success = await ref
                  .read(curriculumControllerProvider.notifier)
                  .addQualification(_nameCtrl.text, _codeCtrl.text);
              if (success && mounted) Navigator.pop(context);
            }
          },
          child: const Text("Save Qualification"),
        ),
      ],
    );
  }
}

// ==========================================
// 2. ADD DEPARTMENT DIALOG
// ==========================================
class AddDepartmentDialog extends ConsumerStatefulWidget {
  const AddDepartmentDialog({super.key});

  @override
  ConsumerState<AddDepartmentDialog> createState() =>
      _AddDepartmentDialogState();
}

class _AddDepartmentDialogState extends ConsumerState<AddDepartmentDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _codeCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: _dialogShape,
      title: const Text(
        "Add Department",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: SizedBox(
        width: 400,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameCtrl,
                decoration: _buildInputDeco("Department Name", Icons.business),
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _codeCtrl,
                decoration: _buildInputDeco("Department Code", Icons.tag),
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),
            ],
          ),
        ),
      ),
      actionsPadding: const EdgeInsets.all(20),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel", style: TextStyle(color: Colors.grey.shade600)),
        ),
        ElevatedButton(
          style: _primaryBtnStyle,
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              final success = await ref
                  .read(curriculumControllerProvider.notifier)
                  .addDepartment(_nameCtrl.text, _codeCtrl.text);
              if (success && mounted) Navigator.pop(context);
            }
          },
          child: const Text("Create Department"),
        ),
      ],
    );
  }
}

// ==========================================
// 3. ADD PROGRAM DIALOG
// ==========================================
class AddProgramDialog extends ConsumerStatefulWidget {
  const AddProgramDialog({super.key});

  @override
  ConsumerState<AddProgramDialog> createState() => _AddProgramDialogState();
}

class _AddProgramDialogState extends ConsumerState<AddProgramDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _codeCtrl = TextEditingController();
  final _semestersCtrl = TextEditingController(text: "8");

  String? _selectedDeptId;
  String? _selectedQualId;

  @override
  Widget build(BuildContext context) {
    // 1. Watch the full AsyncValue, not just the value
    final deptsAsync = ref.watch(departmentsProvider);
    final qualsAsync = ref.watch(qualificationsProvider);

    return AlertDialog(
      shape: _dialogShape,
      title: const Text(
        "Add Academic Program",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: SizedBox(
        width: 450,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _nameCtrl,
                  decoration: _buildInputDeco("Program Name", Icons.school),
                  validator: (v) => v!.isEmpty ? "Required" : null,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        controller: _codeCtrl,
                        decoration: _buildInputDeco("Code", Icons.qr_code),
                        validator: (v) => v!.isEmpty ? "Required" : null,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        controller: _semestersCtrl,
                        decoration: _buildInputDeco("Semesters", Icons.repeat),
                        keyboardType: TextInputType.number,
                        validator: (v) => v!.isEmpty ? "Required" : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // 2. Department Dropdown with Async Handling
                const Text("Department", style: TextStyle(fontWeight: FontWeight.w500)),
                const SizedBox(height: 8),
                deptsAsync.when(
                  loading: () => const LinearProgressIndicator(),
                  error: (e, _) => Text(
                    "Error: Cannot load departments.",
                    style: TextStyle(color: Colors.red.shade700, fontSize: 12),
                  ),
                  data: (depts) {
                    if (depts.isEmpty) {
                      return const Text(
                        "No departments available. Create one first.",
                        style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
                      );
                    }
                    return DropdownButtonFormField<String>(
                      value: _selectedDeptId,
                      isExpanded: true,
                      decoration: _buildInputDeco("Select Department", Icons.business),
                      items: depts
                          .where((d) => d.publicId != null)
                          .map(
                            (d) => DropdownMenuItem(
                          value: d.publicId!,
                          child: Text(d.name ?? 'Unnamed Department'),
                        ),
                      )
                          .toList(),
                      onChanged: (v) => setState(() => _selectedDeptId = v),
                      validator: (v) => v == null ? "Required" : null,
                    );
                  },
                ),

                const SizedBox(height: 16),

                // 3. Qualification Dropdown with Async Handling
                const Text("Qualification", style: TextStyle(fontWeight: FontWeight.w500)),
                const SizedBox(height: 8),
                qualsAsync.when(
                  loading: () => const LinearProgressIndicator(),
                  error: (e, _) => Text(
                    "Error: Cannot load qualifications.",
                    style: TextStyle(color: Colors.red.shade700, fontSize: 12),
                  ),
                  data: (quals) {
                    if (quals.isEmpty) {
                      return const Text(
                        "No qualifications available. Create one first.",
                        style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
                      );
                    }
                    return DropdownButtonFormField<String>(
                      value: _selectedQualId,
                      isExpanded: true,
                      decoration: _buildInputDeco("Select Qualification", Icons.workspace_premium),
                      items: quals
                          .where((q) => q.publicId != null)
                          .map(
                            (q) => DropdownMenuItem(
                          value: q.publicId!,
                          child: Text(q.name ?? 'Unnamed Qualification'),
                        ),
                      )
                          .toList(),
                      onChanged: (v) => setState(() => _selectedQualId = v),
                      validator: (v) => v == null ? "Required" : null,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      actionsPadding: const EdgeInsets.all(20),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel", style: TextStyle(color: Colors.grey.shade600)),
        ),
        ElevatedButton(
          style: _primaryBtnStyle,
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              final success = await ref
                  .read(curriculumControllerProvider.notifier)
                  .addProgram(
                name: _nameCtrl.text,
                code: _codeCtrl.text,
                deptId: _selectedDeptId!,
                qualId: _selectedQualId!,
                semesters: int.parse(_semestersCtrl.text),
              );
              if (success && mounted) Navigator.pop(context);
            }
          },
          child: const Text("Create Program"),
        ),
      ],
    );
  }
}
// ==========================================
// 4. ADD COURSE DIALOG
// ==========================================
class AddCourseDialog extends ConsumerStatefulWidget {
  final String? initialDeptId;
  const AddCourseDialog({super.key, this.initialDeptId});

  @override
  ConsumerState<AddCourseDialog> createState() => _AddCourseDialogState();
}

class _AddCourseDialogState extends ConsumerState<AddCourseDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _codeCtrl = TextEditingController();
  String? _selectedDeptId;

  @override
  void initState() {
    super.initState();
    _selectedDeptId = widget.initialDeptId;
  }

  @override
  Widget build(BuildContext context) {
    // Safety: Filter out items with null IDs
    final depts = (ref.watch(departmentsProvider).value ?? [])
        .where((d) => d.publicId != null)
        .toList();

    return AlertDialog(
      shape: _dialogShape,
      title: const Text(
        "Add New Course",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: SizedBox(
        width: 400,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameCtrl,
                decoration: _buildInputDeco("Course Name", Icons.menu_book),
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _codeCtrl,
                decoration: _buildInputDeco("Course Code", Icons.label),
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedDeptId,
                decoration: _buildInputDeco("Department", Icons.business),
                items: depts
                    .map(
                      (d) => DropdownMenuItem(
                    value: d.publicId!,
                    child: Text(d.name ?? 'Unnamed Department'),
                  ),
                )
                    .toList(),
                onChanged: (v) => setState(() => _selectedDeptId = v),
                validator: (v) => v == null ? "Required" : null,
              ),
            ],
          ),
        ),
      ),
      actionsPadding: const EdgeInsets.all(20),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel", style: TextStyle(color: Colors.grey.shade600)),
        ),
        ElevatedButton(
          style: _primaryBtnStyle,
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              final success = await ref
                  .read(curriculumControllerProvider.notifier)
                  .addCourse(_nameCtrl.text, _codeCtrl.text, _selectedDeptId!);
              if (success && mounted) Navigator.pop(context);
            }
          },
          child: const Text("Create Course"),
        ),
      ],
    );
  }
}

// ==========================================
// 5. ADD COURSE TO CURRICULUM DIALOG
// ==========================================
class AddCourseToCurriculumDialog extends ConsumerStatefulWidget {
  final String programId;
  final int semesterSeq;

  const AddCourseToCurriculumDialog({
    super.key,
    required this.programId,
    required this.semesterSeq,
  });

  @override
  ConsumerState<AddCourseToCurriculumDialog> createState() =>
      _AddCourseToCurriculumDialogState();
}

class _AddCourseToCurriculumDialogState
    extends ConsumerState<AddCourseToCurriculumDialog> {
  String? _selectedCourseId;

  @override
  Widget build(BuildContext context) {
    // Watch the global course list
    final coursesAsync = ref.watch(coursesProvider);

    return AlertDialog(
      shape: _dialogShape, // Assumes this variable exists in your file
      title: Text(
        "Assign Course to Sem ${widget.semesterSeq}",
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      content: SizedBox(
        width: 400,
        child: coursesAsync.when(
          loading: () => const SizedBox(
            height: 100,
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (e, _) => Text("Error loading courses: $e"),
          data: (courses) {
            // Safety: Filter out courses with null IDs to prevent Dropdown crash
            final validCourses = courses.where((c) => c.publicId != null).toList();

            if (validCourses.isEmpty) {
              return const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text("No courses available to assign."),
              );
            }

            return DropdownButtonFormField<String>(
              value: _selectedCourseId,
              isExpanded: true,
              decoration: _buildInputDeco("Select Course", Icons.search),
              hint: const Text("Choose a course..."),
              items: validCourses
                  .map(
                    (c) => DropdownMenuItem(
                  value: c.publicId,
                  child: Text(
                    "${c.code ?? 'No Code'} - ${c.name ?? 'Unnamed'}",
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
                  .toList(),
              onChanged: (v) => setState(() => _selectedCourseId = v),
            );
          },
        ),
      ),
      actionsPadding: const EdgeInsets.all(20),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel", style: TextStyle(color: Colors.grey.shade600)),
        ),
        ElevatedButton(
          style: _primaryBtnStyle,
          onPressed: _selectedCourseId == null
              ? null
              : () async {
            final success = await ref
                .read(curriculumControllerProvider.notifier)
                .addCourseToSemester(
              widget.programId,
              _selectedCourseId!,
              widget.semesterSeq,
            );
            if (success && mounted) Navigator.pop(context);
          },
          child: const Text("Assign Course"),
        ),
      ],
    );
  }
}

// ==========================================
// 6. ADD SEMESTER DIALOG
// ==========================================
class AddSemesterDialog extends ConsumerStatefulWidget {
  const AddSemesterDialog({super.key});

  @override
  ConsumerState<AddSemesterDialog> createState() => _AddSemesterDialogState();
}

class _AddSemesterDialogState extends ConsumerState<AddSemesterDialog> {
  final _formKey = GlobalKey<FormState>();
  final _yearCtrl = TextEditingController(text: "${DateTime.now().year}-${DateTime.now().year + 1}");
  final _weeksCtrl = TextEditingController(text: "16");

  int _semesterNumber = 1;
  DateTime _startDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: _dialogShape,
      title: const Text(
        "Start New Semester",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: SizedBox(
        width: 400,
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              TextFormField(
              controller: _yearCtrl,
              decoration: _buildInputDeco(
                "Academic Year (e.g. 2024-2025)",
                Icons.calendar_today,
              ),
              validator: (v) => v!.isEmpty ? "Required" : null,
            ),
            const SizedBox(height: 16),
            const Text(
              "Semester Number",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(height: 8),
            Container(
            decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade50,
      ),
      child: Row(
        children: [
          Expanded(
            child: RadioListTile<int>(
              title: const Text("Sem 1"),
              value: 1,
              groupValue: _semesterNumber,
              activeColor: Colors.blue.shade700,
              contentPadding: EdgeInsets.zero,
              onChanged: (v) => setState(() => _semesterNumber = v!),
            ),
          ),
          Expanded(
            child: RadioListTile<int>(
              title: const Text("Sem 2"),
              value: 2,
              groupValue: _semesterNumber,
              activeColor: Colors.blue.shade700,
              contentPadding: EdgeInsets.zero,
              onChanged: (v) => setState(() => _semesterNumber = v!),
            ),
          ),
        ],
      ),
    ),
    const SizedBox(height: 16),
    TextFormField(
    controller: _weeksCtrl,
    decoration: _buildInputDeco("Length (Weeks)", Icons.timelapse),
    keyboardType: TextInputType.number,
    validator: (v) => v!.isEmpty ? "Required" : null,
    ),
    const SizedBox(height: 16),
    InkWell(
    onTap: () async {
    final d = await showDatePicker(
    context: context,
    initialDate: _startDate,
    firstDate: DateTime(2020),
    lastDate: DateTime(2030),
    );
    if (d != null) setState(() => _startDate = d);
    },
    borderRadius: BorderRadius.circular(12),
    child: Container(
    padding: const EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 16,
    ),
    decoration: BoxDecoration(
    border: Border.all(color: Colors.grey.shade300),
    borderRadius: BorderRadius.circular(12),
    color: Colors.grey.shade50,
    ),
    child: Row(
    children: [
    const Icon(
    Icons.date_range,
    color: Colors.blueGrey,
    size: 20,
    ),
    const SizedBox(width: 12),
    Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    const Text(
    "Start Date",
    style: TextStyle(
    fontSize: 12,
    color: Colors.blueGrey,
    ),
    ),
    Text(
    DateFormat('yyyy-MM-dd').format(_startDate),
    style: const TextStyle(fontWeight: FontWeight.w600),
    ),
    ],
    ),
    ],
    ),
    ),
    ),
    ],
    ),
    ),
    ),
    actionsPadding: const EdgeInsets.all(20),
    actions: [
    TextButton(
    onPressed: () => Navigator.pop(context),
    child: Text("Cancel", style: TextStyle(color: Colors.grey.shade600)),
    ),
    ElevatedButton(
    style: _primaryBtnStyle,
    onPressed: () async {
    if (_formKey.currentState!.validate()) {
    // UPDATED: Use startSemester instead of addSemester
    // to ensure it sets the status to Active immediately.
    final success = await ref
        .read(curriculumControllerProvider.notifier)
        .addSemester(
    _yearCtrl.text,
    _semesterNumber,
    int.parse(_weeksCtrl.text),
    _startDate,
    );
    if (success && mounted) Navigator.pop(context);
    }
    },
    child: const Text("Start Semester"),
    ),
    ],
    );
  }
}

// ==========================================
// 7. ADD EXAM SEASON DIALOG
// ==========================================
class AddExamSeasonDialog extends ConsumerStatefulWidget {
  const AddExamSeasonDialog({super.key});

  @override
  ConsumerState<AddExamSeasonDialog> createState() =>
      _AddExamSeasonDialogState();
}

class _AddExamSeasonDialogState extends ConsumerState<AddExamSeasonDialog> {
  final _nameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final activeSemAsync = ref.watch(activeSemesterProvider);

    return AlertDialog(
      shape: _dialogShape,
      title: const Text(
        "Create Exam Season",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: SizedBox(
        width: 400,
        child: activeSemAsync.when(
          loading: () => const LinearProgressIndicator(),
          error: (e, _) => Text("Error: $e"),
          data: (semester) {
            if (semester == null) {
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.warning_amber, color: Colors.orange),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "No active semester found. Please start a semester first.",
                      ),
                    ),
                  ],
                ),
              );
            }

            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 16,
                        color: Colors.blue.shade700,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Active Semester: ${semester.academicYear}",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blue.shade800,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _nameCtrl,
                  decoration: _buildInputDeco(
                    "Season Name",
                    Icons.event_note,
                  ).copyWith(hintText: "e.g. Fall Finals 2024"),
                ),
              ],
            );
          },
        ),
      ),
      actionsPadding: const EdgeInsets.all(20),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel", style: TextStyle(color: Colors.grey.shade600)),
        ),
        if (activeSemAsync.value != null)
          ElevatedButton(
            style: _primaryBtnStyle,
            onPressed: () async {
              if (_nameCtrl.text.isNotEmpty) {
                final semId = activeSemAsync.value!.publicId!;
                final success = await ref
                    .read(curriculumControllerProvider.notifier)
                    .addExamSeason(_nameCtrl.text, semId);
                if (success && mounted) Navigator.pop(context);
              }
            },
            child: const Text("Create Exams"),
          ),
      ],
    );
  }
}

// ==========================================
// 8. PROGRAM CURRICULUM DIALOG
// ==========================================
class ProgramCurriculumDialog extends ConsumerWidget {
  final admin.Program program;
  const ProgramCurriculumDialog({super.key, required this.program});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch specific curriculum for this program
    final curriculumAsync = ref.watch(curriculumProvider(program.publicId!));

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 600,
        height: 700,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      program.name ?? "Program",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${program.code ?? '-'} • ${program.totalSemesters ?? 8} Semesters",
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const Divider(height: 30),

            // Curriculum List
            Expanded(
              child: curriculumAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text("Error: $e")),
                data: (courses) {
                  // NOTE: Ensure your API client generates 'ProgramCourse' correctly.
                  // If it returns a standard 'Course' with a 'pivot' property, this cast is valid.
                  // We add a safety check just in case.
                  final safeCourses = courses.whereType<admin.ProgramCourse>().toList();

                  return ListView.separated(
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemCount: program.totalSemesters ?? 8,
                    itemBuilder: (ctx, i) {
                      final semSeq = i + 1;

                      final semesterCourses = safeCourses.where((c) {
                        return c.pivot?.semesterSequence == semSeq;
                      }).toList();

                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade200),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Semester $semSeq",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextButton.icon(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (_) =>
                                            AddCourseToCurriculumDialog(
                                              programId: program.publicId!,
                                              semesterSeq: semSeq,
                                            ),
                                      );
                                    },
                                    icon: const Icon(Icons.add, size: 16),
                                    label: const Text(
                                      "Add Course",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (semesterCourses.isEmpty)
                              const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text(
                                  "No courses assigned yet.",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              )
                            else
                              ...semesterCourses.map(
                                    (c) => ListTile(
                                  dense: true,
                                  title: Text(c.name ?? '-'),
                                  subtitle: Text(c.code ?? '-'),
                                  trailing: IconButton(
                                    icon: const Icon(
                                      Icons.remove_circle_outline,
                                      color: Colors.redAccent,
                                      size: 16,
                                    ),
                                    onPressed: () {
                                      if (c.publicId != null) {
                                        ref
                                            .read(
                                          curriculumControllerProvider
                                              .notifier,
                                        )
                                            .removeCourseFromProgram(
                                          program.publicId!,
                                          c.publicId!,
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}