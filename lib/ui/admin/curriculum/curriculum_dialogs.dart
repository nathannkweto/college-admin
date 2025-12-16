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
              await ApiService.post('/curriculum/departments', {
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
class AddProgramDialog extends StatelessWidget {
  final _nameCtrl = TextEditingController();
  final _tagCtrl = TextEditingController();
  final _numCtrl = TextEditingController();
  final _levelCtrl = TextEditingController(); // User types Level ID manually for now
  final _formKey = GlobalKey<FormState>();

  AddProgramDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add Program"),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(controller: _nameCtrl, decoration: const InputDecoration(labelText: "Program Name"), validator: (v) => v!.isEmpty ? "Required" : null),
            TextFormField(controller: _tagCtrl, decoration: const InputDecoration(labelText: "Tag/Code"), validator: (v) => v!.isEmpty ? "Required" : null),
            TextFormField(controller: _numCtrl, decoration: const InputDecoration(labelText: "Program Number"), keyboardType: TextInputType.number, validator: (v) => v!.isEmpty ? "Required" : null),
            TextFormField(controller: _levelCtrl, decoration: const InputDecoration(labelText: "Level ID"), keyboardType: TextInputType.number, validator: (v) => v!.isEmpty ? "Required" : null),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              await ApiService.post('/curriculum/programs', {
                "name": _nameCtrl.text,
                "tag": _tagCtrl.text,
                "program_number": int.parse(_numCtrl.text),
                "level_id": int.parse(_levelCtrl.text),
              });
              if(context.mounted) Navigator.pop(context, true);
            }
          },
          child: const Text("Add"),
        )
      ],
    );
  }
}

// --- ADD COURSE ---
class AddCourseDialog extends StatelessWidget {
  final _nameCtrl = TextEditingController();
  final _codeCtrl = TextEditingController();
  final _deptCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  AddCourseDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add Course"),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(controller: _nameCtrl, decoration: const InputDecoration(labelText: "Course Name"), validator: (v) => v!.isEmpty ? "Required" : null),
            TextFormField(controller: _codeCtrl, decoration: const InputDecoration(labelText: "Code (e.g. CS101)"), validator: (v) => v!.isEmpty ? "Required" : null),
            TextFormField(controller: _deptCtrl, decoration: const InputDecoration(labelText: "Department ID"), keyboardType: TextInputType.number, validator: (v) => v!.isEmpty ? "Required" : null),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              await ApiService.post('/curriculum/courses', {
                "name": _nameCtrl.text,
                "code": _codeCtrl.text,
                "department_id": int.parse(_deptCtrl.text),
              });
              if(context.mounted) Navigator.pop(context, true);
            }
          },
          child: const Text("Add"),
        )
      ],
    );
  }
}

// --- START SEMESTER ---
class StartSemesterDialog extends StatelessWidget {
  final _semNumCtrl = TextEditingController();
  final _yearIdCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  StartSemesterDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Start New Semester"),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(controller: _semNumCtrl, decoration: const InputDecoration(labelText: "Semester Number (e.g. 1 or 2)"), keyboardType: TextInputType.number, validator: (v) => v!.isEmpty ? "Required" : null),
            TextFormField(controller: _yearIdCtrl, decoration: const InputDecoration(labelText: "Academic Year ID"), keyboardType: TextInputType.number, validator: (v) => v!.isEmpty ? "Required" : null),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              await ApiService.post('/curriculum/semesters', {
                "semester_number": int.parse(_semNumCtrl.text),
                "academic_year_id": int.parse(_yearIdCtrl.text),
              });
              if(context.mounted) Navigator.pop(context, true);
            }
          },
          child: const Text("Start"),
        )
      ],
    );
  }
}