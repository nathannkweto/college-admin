import 'package:flutter/material.dart';
import '../../../services/api_service.dart';

class AddStudentDialog extends StatefulWidget {
  const AddStudentDialog({super.key});

  @override
  State<AddStudentDialog> createState() => _AddStudentDialogState();
}

class _AddStudentDialogState extends State<AddStudentDialog> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _nationalIdController = TextEditingController();
  final _phoneController = TextEditingController();
  final _programIdController = TextEditingController();
  final _studyLevelIdController = TextEditingController();

  DateTime _enrollmentDate = DateTime.now();

  bool _isSubmitting = false;
  String? _error;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _nationalIdController.dispose();
    _phoneController.dispose();
    _programIdController.dispose();
    _studyLevelIdController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _enrollmentDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => _enrollmentDate = picked);
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSubmitting = true;
      _error = null;
    });

    try {
      // Format date as YYYY-MM-DD
      final dateString = _enrollmentDate.toIso8601String().split('T')[0];

      final payload = {
        "first_name": _firstNameController.text.trim(),
        "last_name": _lastNameController.text.trim(),
        "email": _emailController.text.trim(),
        "national_id": _nationalIdController.text.trim(),
        "phone": _phoneController.text.trim(),
        "program_id": int.parse(_programIdController.text.trim()),
        "study_level_id": int.parse(_studyLevelIdController.text.trim()),
        "enrollment_date": dateString,
      };

      await ApiService.post('/students', payload);

      if (mounted) {
        Navigator.pop(context, true); // Return true to trigger refresh
      }
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
    // Helper for input decoration
    InputDecoration decoration(String label) => InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    );

    return AlertDialog(
      title: const Text("Register New Student"),
      content: SizedBox(
        width: 500, // Wider dialog for more fields
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_error != null)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(bottom: 16),
                    color: Colors.red.shade50,
                    child: Text(_error!, style: TextStyle(color: Colors.red.shade800)),
                  ),

                // Row 1: Names
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _firstNameController,
                        decoration: decoration("First Name"),
                        validator: (v) => v!.isEmpty ? "Required" : null,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _lastNameController,
                        decoration: decoration("Last Name"),
                        validator: (v) => v!.isEmpty ? "Required" : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Row 2: Contact
                TextFormField(
                  controller: _emailController,
                  decoration: decoration("Email Address"),
                  validator: (v) => v!.contains("@") ? null : "Invalid email",
                ),
                const SizedBox(height: 16),

                // Row 3: ID & Phone
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _nationalIdController,
                        decoration: decoration("National ID"),
                        validator: (v) => v!.isEmpty ? "Required" : null,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _phoneController,
                        decoration: decoration("Phone Number"),
                        validator: (v) => v!.isEmpty ? "Required" : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                const Divider(),
                const SizedBox(height: 8),
                const Text("Academic Details", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                const SizedBox(height: 16),

                // Row 4: IDs
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _programIdController,
                        decoration: decoration("Program ID"),
                        keyboardType: TextInputType.number,
                        validator: (v) => int.tryParse(v ?? "") == null ? "Number required" : null,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _studyLevelIdController,
                        decoration: decoration("Study Level ID"),
                        keyboardType: TextInputType.number,
                        validator: (v) => int.tryParse(v ?? "") == null ? "Number required" : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Row 5: Date
                InkWell(
                  onTap: _pickDate,
                  child: InputDecorator(
                    decoration: decoration("Enrollment Date"),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_enrollmentDate.toIso8601String().split('T')[0]),
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
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: _isSubmitting ? null : _submit,
          child: _isSubmitting
              ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
              : const Text("Register Student"),
        ),
      ],
    );
  }
}