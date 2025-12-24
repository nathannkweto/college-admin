import 'package:flutter/material.dart';
import '../../../services/api_service.dart';

class AddLecturerDialog extends StatefulWidget {
  const AddLecturerDialog({super.key});

  @override
  State<AddLecturerDialog> createState() => _AddLecturerDialogState();
}

class _AddLecturerDialogState extends State<AddLecturerDialog> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  // Data State
  List<dynamic> _departments = [];
  int? _selectedDepartmentId;
  DateTime _employmentDate = DateTime.now();

  bool _isLoadingData = true;
  bool _isSubmitting = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchDepartments();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // Fetch departments for the dropdown
  Future<void> _fetchDepartments() async {
    try {
      // Adjust this endpoint if your backend uses a different path
      final response = await ApiService.get('/courses/departments');
      if (mounted) {
        setState(() {
          _departments = List<dynamic>.from(response['data'] ?? []);
          _isLoadingData = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = "Failed to load departments: $e";
          _isLoadingData = false;
        });
      }
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _employmentDate,
      firstDate: DateTime(1980),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => _employmentDate = picked);
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedDepartmentId == null) {
      setState(() => _error = "Please select a department");
      return;
    }

    setState(() {
      _isSubmitting = true;
      _error = null;
    });

    try {
      final dateString = _employmentDate.toIso8601String().split('T')[0];

      await ApiService.post('/people/lecturers', {
        "first_name": _firstNameController.text.trim(),
        "last_name": _lastNameController.text.trim(),
        "email": _emailController.text.trim(),
        "phone": _phoneController.text.trim(),
        "department_id": _selectedDepartmentId,
        "employment_date": dateString,
      });

      if (mounted) Navigator.pop(context, true);
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString().replaceAll("Exception:", "").trim();
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // PRE-COMPUTE dropdown items to prevent JS map errors on Web
    final List<DropdownMenuItem<int>> departmentItems = _departments.map((dept) {
      return DropdownMenuItem<int>(
        value: dept['id'] as int,
        child: Text(dept['name']?.toString() ?? "Unnamed Dept"),
      );
    }).toList();

    InputDecoration decoration(String label) => InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    );

    if (_isLoadingData) {
      return const AlertDialog(
        content: SizedBox(
          height: 100,
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    return AlertDialog(
      title: const Text("Register New Lecturer"),
      content: SizedBox(
        width: 500,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_error != null)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(bottom: 16),
                    color: Colors.red.shade50,
                    child: Text(_error!, style: TextStyle(color: Colors.red.shade800)),
                  ),

                // Name Fields
                Row(
                  children: [
                    Expanded(child: TextFormField(controller: _firstNameController, decoration: decoration("First Name"), validator: (v) => v!.isEmpty ? "Required" : null)),
                    const SizedBox(width: 16),
                    Expanded(child: TextFormField(controller: _lastNameController, decoration: decoration("Last Name"), validator: (v) => v!.isEmpty ? "Required" : null)),
                  ],
                ),
                const SizedBox(height: 16),

                // Contact Fields
                TextFormField(controller: _emailController, decoration: decoration("Email"), validator: (v) => v!.contains("@") ? null : "Invalid email"),
                const SizedBox(height: 16),
                TextFormField(controller: _phoneController, decoration: decoration("Phone Number"), validator: (v) => v!.isEmpty ? "Required" : null),

                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Divider(),
                ),

                // --- DEPARTMENT DROPDOWN ---
                DropdownButtonFormField<int>(
                  value: _selectedDepartmentId,
                  decoration: decoration("Department"),
                  items: departmentItems,
                  onChanged: (val) => setState(() => _selectedDepartmentId = val),
                  validator: (v) => v == null ? "Required" : null,
                ),
                const SizedBox(height: 16),

                // Employment Date
                InkWell(
                  onTap: _pickDate,
                  child: InputDecorator(
                    decoration: decoration("Employment Date"),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_employmentDate.toIso8601String().split('T')[0]),
                        const Icon(Icons.calendar_today, size: 18, color: Colors.grey),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
        ElevatedButton(
          onPressed: _isSubmitting ? null : _submit,
          child: _isSubmitting
              ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
              : const Text("Register Lecturer"),
        ),
      ],
    );
  }
}