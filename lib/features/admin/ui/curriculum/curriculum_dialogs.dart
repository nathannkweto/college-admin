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
  String? _selectedLecturerId; // <--- NEW STATE VARIABLE

  @override
  Widget build(BuildContext context) {
    // Watch both providers
    final coursesAsync = ref.watch(coursesProvider);
    final lecturersAsync = ref.watch(lecturersProvider); // <--- NEW WATCH

    return AlertDialog(
      shape: _dialogShape,
      title: Text(
        "Assign Course to Sem ${widget.semesterSeq}",
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      content: SizedBox(
        width: 400,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Select a course and optionally assign a default lecturer.",
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              const SizedBox(height: 20),

              // 1. COURSE SELECTION
              coursesAsync.when(
                loading: () => const LinearProgressIndicator(),
                error: (e, _) => Text("Error loading courses: $e"),
                data: (courses) {
                  final validCourses = courses.where((c) => c.publicId != null).toList();

                  if (validCourses.isEmpty) {
                    return const Text("No courses available to assign.");
                  }

                  return DropdownButtonFormField<String>(
                    value: _selectedCourseId,
                    isExpanded: true,
                    decoration: _buildInputDeco("Select Course", Icons.book),
                    hint: const Text("Choose a course..."),
                    items: validCourses.map((c) {
                      return DropdownMenuItem(
                        value: c.publicId,
                        child: Text(
                          "${c.code ?? 'No Code'} - ${c.name ?? 'Unnamed'}",
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
                    onChanged: (v) => setState(() => _selectedCourseId = v),
                  );
                },
              ),

              const SizedBox(height: 16),

              // 2. LECTURER SELECTION (NEW)
              lecturersAsync.when(
                loading: () => const LinearProgressIndicator(),
                error: (e, _) => Text("Error loading lecturers: $e"),
                data: (lecturers) {
                  return DropdownButtonFormField<String>(
                    value: _selectedLecturerId,
                    isExpanded: true,
                    decoration: _buildInputDeco("Default Lecturer (Optional)", Icons.person),
                    hint: const Text("Select a lecturer..."),
                    items: [
                      // Option to unselect lecturer
                      const DropdownMenuItem(
                        value: null,
                        child: Text("No Default Lecturer"),
                      ),
                      ...lecturers.map((l) {
                        return DropdownMenuItem(
                          value: l.publicId,
                          child: Text(
                            "${l.title ?? ''} ${l.firstName} ${l.lastName}",
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }),
                    ],
                    onChanged: (v) => setState(() => _selectedLecturerId = v),
                  );
                },
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
          onPressed: _selectedCourseId == null
              ? null
              : () async {
            final success = await ref
                .read(curriculumControllerProvider.notifier)
                .addCourseToSemester(
              widget.programId,
              _selectedCourseId!,
              widget.semesterSeq,
              lecturerId: _selectedLecturerId, // <--- PASSING THE LECTURER
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
  ConsumerState<AddExamSeasonDialog> createState() => _AddExamSeasonDialogState();
}

class _AddExamSeasonDialogState extends ConsumerState<AddExamSeasonDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  // To handle the loading state of the button
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _submit(String semesterPublicId) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    // Call the updated controller method
    final success = await ref
        .read(curriculumControllerProvider.notifier)
        .addExamSeason(_nameController.text.trim(), semesterPublicId);

    if (mounted) {
      setState(() => _isSubmitting = false);

      if (success) {
        Navigator.of(context).pop(); // Close dialog
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Exam Season started successfully!"),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        // Error handling is usually done via print/logging in the provider,
        // but you can add a generic error snackbar here if needed.
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to start exam season. Check connection."),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // We need the active semester ID to link the exam season to it
    final activeSemAsync = ref.watch(activeSemesterProvider);

    return activeSemAsync.when(
      loading: () => const AlertDialog(
        content: SizedBox(
            height: 100,
            child: Center(child: CircularProgressIndicator())
        ),
      ),
      error: (e, stack) => AlertDialog(
        title: const Text("Error"),
        content: Text("Could not verify active semester: $e"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ],
      ),
      data: (semester) {
        if (semester == null) {
          return AlertDialog(
            title: const Text("No Active Semester"),
            content: const Text("You cannot start an exam season without an active semester."),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Close"),
              ),
            ],
          );
        }

        // Auto-fill a suggestion if empty (Optional UX enhancement)
        if (_nameController.text.isEmpty) {
          _nameController.text = "Finals ${semester.academicYear ?? ''}";
        }

        return AlertDialog(
          title: const Text("Start Exam Season"),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Semester: ${semester.academicYear} (Sem ${semester.semesterNumber})",
                  style: const TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                const Text(
                  "This will activate 'Exam Mode' for the current semester. "
                      "Lecturers will be able to submit grades.",
                  style: TextStyle(fontSize: 13, color: Colors.black87),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: "Season Name",
                    hintText: "e.g., Finals 2025, Mid-Terms",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: _isSubmitting ? null : () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: _isSubmitting
                  ? null
                  : () => _submit(semester.publicId ?? "NULL"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade800,
                foregroundColor: Colors.white,
              ),
              child: _isSubmitting
                  ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
                  : const Text("Start Exams"),
            ),
          ],
        );
      },
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
    final curriculumAsync = ref.watch(curriculumProvider(program.publicId!));

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 700, // Slightly wider to accommodate lecturer names
        height: 800,
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
                  final safeCourses = courses.whereType<admin.ProgramCourse>().toList();

                  return ListView.separated(
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemCount: program.totalSemesters ?? 8,
                    itemBuilder: (ctx, i) {
                      final semSeq = i + 1;

                      // Filter courses for this specific semester
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
                            // Semester Header
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        builder: (_) => AddCourseToCurriculumDialog(
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

                            // Course List for this Semester
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
                              ...semesterCourses.map((c) {
                                // Extract Lecturer Name safely
                                final lecturerName = c.pivot?.lecturer?.name;

                                return ListTile(
                                  dense: true,
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.blue.shade50,
                                    child: Text(
                                      (c.code ?? "??").substring(0, 2),
                                      style: TextStyle(
                                          color: Colors.blue.shade800,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                  title: Text(c.name ?? '-'),
                                  subtitle: Row(
                                    children: [
                                      // Course Code
                                      Text(
                                        c.code ?? '-',
                                        style: const TextStyle(fontWeight: FontWeight.w500),
                                      ),
                                      if (lecturerName != null) ...[
                                        const SizedBox(width: 8),
                                        const Text("•"),
                                        const SizedBox(width: 8),
                                        // Lecturer Badge
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                          decoration: BoxDecoration(
                                              color: Colors.amber.shade50,
                                              borderRadius: BorderRadius.circular(4),
                                              border: Border.all(color: Colors.amber.shade200)
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(Icons.person, size: 12, color: Colors.amber.shade800),
                                              const SizedBox(width: 4),
                                              Text(
                                                lecturerName,
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    color: Colors.amber.shade900,
                                                    fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ]
                                    ],
                                  ),
                                  trailing: IconButton(
                                    tooltip: "Remove from curriculum",
                                    icon: const Icon(
                                      Icons.remove_circle_outline,
                                      color: Colors.redAccent,
                                      size: 16,
                                    ),
                                    onPressed: () {
                                      if (c.publicId != null) {
                                        ref.read(curriculumControllerProvider.notifier)
                                            .removeCourseFromProgram(
                                          program.publicId!,
                                          c.publicId!,
                                        );
                                      }
                                    },
                                  ),
                                );
                              }),
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