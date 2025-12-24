import 'package:flutter/material.dart';
import '../../../services/api_service.dart';

// --- ADD DEPARTMENT ---
class AddDepartmentDialog extends StatelessWidget {
  final _nameCtrl = TextEditingController();
  final _codeCtrl = TextEditingController();
  final _numCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  AddDepartmentDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add Department"),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(controller: _nameCtrl, decoration: const InputDecoration(labelText: "Name"), validator: (v) => v!.isEmpty ? "Required" : null),
            TextFormField(controller: _codeCtrl, decoration: const InputDecoration(labelText: "Code (e.g. CS)"), validator: (v) => v!.isEmpty ? "Required" : null),
            TextFormField(controller: _numCtrl, decoration: const InputDecoration(labelText: "Dept Number (ID)"), keyboardType: TextInputType.number, validator: (v) => v!.isEmpty ? "Required" : null),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              await ApiService.post('/courses/departments', {
                "name": _nameCtrl.text,
                "code": _codeCtrl.text,
                "number": int.parse(_numCtrl.text),
              });
              if(context.mounted) Navigator.pop(context, true);
            }
          },
          child: const Text("Create"),
        )
      ],
    );
  }
}

// --- ADD PROGRAM ---
class AddProgramDialog extends StatefulWidget {
  const AddProgramDialog({super.key});

  @override
  State<AddProgramDialog> createState() => _AddProgramDialogState();
}

class _AddProgramDialogState extends State<AddProgramDialog> {
  final _nameCtrl = TextEditingController();
  final _tagCtrl = TextEditingController();
  final _numCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  List<dynamic> _levels = [];
  int? _selectedLevelId;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchLevels();
  }

  Future<void> _fetchLevels() async {
    try {
      final res = await ApiService.get('/courses/levels');
      if (mounted) {
        setState(() {
          _levels = List<dynamic>.from(res['data'] ?? []);
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Pre-compute items for Web stability
    final List<DropdownMenuItem<int>> levelItems = _levels.map((l) {
      return DropdownMenuItem<int>(
        value: l['id'] as int,
        child: Text(l['name'] ?? "Unknown"),
      );
    }).toList();

    return AlertDialog(
      title: const Text("Add Program"),
      content: _isLoading
          ? const SizedBox(height: 100, child: Center(child: CircularProgressIndicator()))
          : Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(controller: _nameCtrl, decoration: const InputDecoration(labelText: "Program Name"), validator: (v) => v!.isEmpty ? "Required" : null),
              TextFormField(controller: _tagCtrl, decoration: const InputDecoration(labelText: "Tag/Code"), validator: (v) => v!.isEmpty ? "Required" : null),
              TextFormField(controller: _numCtrl, decoration: const InputDecoration(labelText: "Program Number"), keyboardType: TextInputType.number, validator: (v) => v!.isEmpty ? "Required" : null),
              const SizedBox(height: 16),
              DropdownButtonFormField<int>(
                value: _selectedLevelId,
                decoration: const InputDecoration(labelText: "Qualification Level", border: OutlineInputBorder()),
                items: levelItems,
                onChanged: (val) => setState(() => _selectedLevelId = val),
                validator: (v) => v == null ? "Required" : null,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
        ElevatedButton(
          onPressed: _isLoading ? null : () async {
            if (_formKey.currentState!.validate()) {
              await ApiService.post('/courses/programs', {
                "name": _nameCtrl.text,
                "tag": _tagCtrl.text,
                "program_number": int.parse(_numCtrl.text),
                "level_id": _selectedLevelId,
              });
              if (context.mounted) Navigator.pop(context, true);
            }
          },
          child: const Text("Add"),
        )
      ],
    );
  }
}

// --- ADD COURSE ---
class AddCourseDialog extends StatefulWidget {
  const AddCourseDialog({super.key});

  @override
  State<AddCourseDialog> createState() => _AddCourseDialogState();
}

class _AddCourseDialogState extends State<AddCourseDialog> {
  final _nameCtrl = TextEditingController();
  final _codeCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  List<dynamic> _depts = [];
  int? _selectedDeptId;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchDepts();
  }

  Future<void> _fetchDepts() async {
    try {
      final res = await ApiService.get('/courses/departments');
      if (mounted) {
        setState(() {
          _depts = List<dynamic>.from(res['data'] ?? []);
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuItem<int>> deptItems = _depts.map((d) {
      return DropdownMenuItem<int>(
        value: d['id'] as int,
        child: Text("${d['code']} - ${d['name']}"),
      );
    }).toList();

    return AlertDialog(
      title: const Text("Add Course"),
      content: _isLoading
          ? const SizedBox(height: 100, child: Center(child: CircularProgressIndicator()))
          : Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(controller: _nameCtrl, decoration: const InputDecoration(labelText: "Course Name"), validator: (v) => v!.isEmpty ? "Required" : null),
            TextFormField(controller: _codeCtrl, decoration: const InputDecoration(labelText: "Code (e.g. CS101)"), validator: (v) => v!.isEmpty ? "Required" : null),
            const SizedBox(height: 16),
            DropdownButtonFormField<int>(
              value: _selectedDeptId,
              decoration: const InputDecoration(labelText: "Department", border: OutlineInputBorder()),
              items: deptItems,
              onChanged: (val) => setState(() => _selectedDeptId = val),
              validator: (v) => v == null ? "Required" : null,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
        ElevatedButton(
          onPressed: _isLoading ? null : () async {
            if (_formKey.currentState!.validate()) {
              await ApiService.post('/courses/courses', {
                "name": _nameCtrl.text,
                "code": _codeCtrl.text,
                "department_id": _selectedDeptId,
              });
              if (context.mounted) Navigator.pop(context, true);
            }
          },
          child: const Text("Add"),
        )
      ],
    );
  }
}

// --- ADD ACADEMIC LEVEL ---
class AddLevelDialog extends StatelessWidget {
  final _nameCtrl = TextEditingController();
  final _tagCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  AddLevelDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add Qualification Level"),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(
                    labelText: "Level Name",
                    hintText: "e.g. Bachelor of Science"
                ),
                validator: (v) => v!.isEmpty ? "Required" : null
            ),
            const SizedBox(height: 16),
            TextFormField(
                controller: _tagCtrl,
                decoration: const InputDecoration(
                    labelText: "Abbreviation / Tag",
                    hintText: "e.g. BSC"
                ),
                textCapitalization: TextCapitalization.characters,
                validator: (v) => v!.isEmpty ? "Required" : null
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              await ApiService.post('/courses/levels', {
                "name": _nameCtrl.text.trim(),
                "tag": _tagCtrl.text.trim(),
              });
              if(context.mounted) Navigator.pop(context, true);
            }
          },
          child: const Text("Create Qualification"),
        )
      ],
    );
  }
}

// --- START SEMESTER ---
class StartSemesterDialog extends StatefulWidget {
  const StartSemesterDialog({super.key});

  @override
  State<StartSemesterDialog> createState() => _StartSemesterDialogState();
}

class _StartSemesterDialogState extends State<StartSemesterDialog> {
  final _formKey = GlobalKey<FormState>();

  List<dynamic> _years = [];
  int? _selectedYearId;
  int? _selectedSemesterNumber; // Changed from Controller to int
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchYears();
  }

  Future<void> _fetchYears() async {
    try {
      final res = await ApiService.get('/courses/academic-years');
      if (mounted) {
        setState(() {
          _years = List<dynamic>.from(res['data'] ?? []);
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Pre-compute items
    final List<DropdownMenuItem<int>> yearItems = _years.map((y) {
      return DropdownMenuItem<int>(
        value: y['id'] as int,
        child: Text(y['display_name'] ?? "${y['start_year']}/${y['end_year']}"),
      );
    }).toList();

    // Fixed options for Semester Number
    final List<DropdownMenuItem<int>> semesterOptions = [
      const DropdownMenuItem(value: 1, child: Text("Semester 1")),
      const DropdownMenuItem(value: 2, child: Text("Semester 2")),
      const DropdownMenuItem(value: 3, child: Text("Summer Semester / 3")),
    ];

    return AlertDialog(
      title: const Text("Start New Semester"),
      content: _isLoading
          ? const SizedBox(height: 100, child: Center(child: CircularProgressIndicator()))
          : Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // --- SEMESTER NUMBER DROPDOWN ---
            DropdownButtonFormField<int>(
              value: _selectedSemesterNumber,
              decoration: const InputDecoration(labelText: "Semester Number", border: OutlineInputBorder()),
              items: semesterOptions,
              onChanged: (val) => setState(() => _selectedSemesterNumber = val),
              validator: (v) => v == null ? "Required" : null,
            ),
            const SizedBox(height: 16),

            // --- ACADEMIC YEAR DROPDOWN ---
            DropdownButtonFormField<int>(
              value: _selectedYearId,
              decoration: const InputDecoration(labelText: "Academic Year", border: OutlineInputBorder()),
              items: yearItems,
              onChanged: (val) => setState(() => _selectedYearId = val),
              validator: (v) => v == null ? "Required" : null,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
        ElevatedButton(
          onPressed: _isLoading ? null : () async {
            if (_formKey.currentState!.validate()) {
              await ApiService.post('/courses/semesters', {
                "semester_number": _selectedSemesterNumber,
                "academic_year_id": _selectedYearId,
              });
              if (context.mounted) Navigator.pop(context, true);
            }
          },
          child: const Text("Start Semester"),
        )
      ],
    );
  }
}
