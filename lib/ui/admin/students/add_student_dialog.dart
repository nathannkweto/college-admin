import 'package:flutter/material.dart';
import '../../../services/api_service.dart';

class AddStudentDialog extends StatefulWidget {
  const AddStudentDialog({super.key});

  @override
  State<AddStudentDialog> createState() => _AddStudentDialogState();
}

class _AddStudentDialogState extends State<AddStudentDialog> {
  final _formKey = GlobalKey<FormState>();

  // Text Controllers
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _nationalIdController = TextEditingController();
  final _phoneController = TextEditingController();

  // Dropdown State
  List<dynamic> _levels = [];
  List<dynamic> _filteredPrograms = [];

  int? _selectedLevelId;
  int? _selectedProgramId;

  DateTime _enrollmentDate = DateTime.now();
  bool _isLoadingData = true; // For fetching levels
  bool _isSubmitting = false; // For submitting form
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchLevels();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _nationalIdController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // Fetch Levels and their nested Programs
  Future<void> _fetchLevels() async {
    try {
      final response = await ApiService.get('/courses/levels');
      if (mounted) {
        setState(() {
          _levels = response['data'] ?? [];
          _isLoadingData = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = "Failed to load academic data: $e";
          _isLoadingData = false;
        });
      }
    }
  }

  // Handle Level Change -> Update Programs List
  void _onLevelChanged(int? levelId) {
    if (levelId == null) return;

    setState(() {
      _selectedLevelId = levelId;
      _selectedProgramId = null; // Reset program when level changes

      // Find the selected level object to get its programs
      // Assumes structure: {id: 1, name: "...", programs: [...]}
      final selectedLevel = _levels.firstWhere(
              (lvl) => lvl['id'] == levelId,
          orElse: () => {}
      );

      _filteredPrograms = selectedLevel['programs'] ?? [];
    });
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

    // Manual validation for dropdowns
    if (_selectedLevelId == null || _selectedProgramId == null) {
      setState(() => _error = "Please select both a Study Level and a Program.");
      return;
    }

    setState(() {
      _isSubmitting = true;
      _error = null;
    });

    try {
      final dateString = _enrollmentDate.toIso8601String().split('T')[0];

      final payload = {
        "first_name": _firstNameController.text.trim(),
        "last_name": _lastNameController.text.trim(),
        "email": _emailController.text.trim(),
        "national_id": _nationalIdController.text.trim(),
        "phone": _phoneController.text.trim(),
        "study_level_id": _selectedLevelId, // Send int directly
        "program_id": _selectedProgramId,   // Send int directly
        "enrollment_date": dateString,
      };

      // NOTE: Ensure this endpoint matches your Blueprint prefix (e.g. /people/students)
      await ApiService.post('/students', payload);

      if (mounted) {
        Navigator.pop(context, true);
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
    InputDecoration decoration(String label) => InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    );

    // Loading State
    if (_isLoadingData) {
      return const AlertDialog(
        content: SizedBox(
            height: 100,
            child: Center(child: CircularProgressIndicator())
        ),
      );
    }

    return AlertDialog(
      title: const Text("Register New Student"),
      content: SizedBox(
        width: 500,
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

                // Row 2: Email
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
                const Text("Academic Placement", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey)),
                const SizedBox(height: 16),

                // --- CHANGED: LEVEL DROPDOWN ---
                DropdownButtonFormField<int>(
                  value: _selectedLevelId,
                  decoration: decoration("Study Level"),
                  items: _levels.map<DropdownMenuItem<int>>((level) {
                    return DropdownMenuItem<int>(
                      value: level['id'],
                      // Displays: "Bachelor (BSC)"
                      child: Text("${level['name']} (${level['tag'] ?? ''})"),
                    );
                  }).toList(),
                  onChanged: _onLevelChanged,
                  validator: (v) => v == null ? "Required" : null,
                ),
                const SizedBox(height: 16),

                // --- CHANGED: PROGRAM DROPDOWN ---
                DropdownButtonFormField<int>(
                  value: _selectedProgramId,
                  decoration: decoration("Program"),
                  // Disable dropdown if no level is selected
                  onChanged: _selectedLevelId == null ? null : (val) {
                    setState(() => _selectedProgramId = val);
                  },
                  validator: (v) => v == null ? "Required" : null,
                  // Show "Select Level First" if empty
                  hint: Text(_selectedLevelId == null ? "Select Level First" : "Select Program"),
                  items: _filteredPrograms.map<DropdownMenuItem<int>>((prog) {
                    return DropdownMenuItem<int>(
                      value: prog['id'],
                      child: Text(prog['name']),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),

                // Date
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