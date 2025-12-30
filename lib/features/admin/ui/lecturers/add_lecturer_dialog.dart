import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import '../../providers/add_lecturer_provider.dart';

// --- SEAMLESS STYLE HELPER ---
InputDecoration _decor(String label, {IconData? icon}) => InputDecoration(
  labelText: label,
  prefixIcon: icon != null
      ? Icon(icon, size: 20, color: Colors.blueGrey)
      : null,
  filled: true,
  fillColor: Colors.grey.shade50,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide.none,
  ),
  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  isDense: true,
);

class AddLecturerDialog extends ConsumerStatefulWidget {
  const AddLecturerDialog({super.key});

  @override
  ConsumerState<AddLecturerDialog> createState() => _AddLecturerDialogState();
}

class _AddLecturerDialogState extends ConsumerState<AddLecturerDialog> {
  final _formKey = GlobalKey<FormState>();

  // --- CONTROLLERS ---
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController(); // NEW
  final _nationalIdController = TextEditingController(); // NEW
  final _addressController = TextEditingController(); // NEW
  final _dobController = TextEditingController(); // NEW

  // --- STATE VARIABLES ---
  String? _selectedDepartmentId;
  String _selectedTitle = "Mr";
  String _selectedGender = "M";
  DateTime _dob = DateTime(1980, 1, 1); // Default DOB ~45 years ago

  PlatformFile? _selectedFile;

  @override
  void initState() {
    super.initState();
    _dobController.text = DateFormat('yyyy-MM-dd').format(_dob);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _nationalIdController.dispose();
    _addressController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  // --- LOGIC ---

  Future<void> _pickDob() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dob,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dob = picked;
        _dobController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _submitSingle() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedDepartmentId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a department")),
      );
      return;
    }

    final success = await ref
        .read(addLecturerControllerProvider.notifier)
        .registerLecturer(
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      email: _emailController.text.trim(),
      departmentPublicId: _selectedDepartmentId!,
      title: _selectedTitle,
      gender: _selectedGender,
      // New Fields
      phone: _phoneController.text.trim(),
      nationalId: _nationalIdController.text.trim(),
      address: _addressController.text.trim(),
      dob: _dob,
    );

    if (success && mounted) Navigator.pop(context, true);
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
      withData: true,
    );

    if (result != null) {
      setState(() => _selectedFile = result.files.first);
    }
  }

  Future<void> _submitBatch() async {
    if (_selectedFile == null) return;
    final success = await ref
        .read(addLecturerControllerProvider.notifier)
        .uploadCsv(_selectedFile!);
    if (success && mounted) Navigator.pop(context, true);
  }

  Future<void> _downloadTemplate() async {
    final csvContent = ref
        .read(addLecturerControllerProvider.notifier)
        .generateCsvTemplate();
    final Uri uri = Uri.dataFromString(
      csvContent,
      mimeType: 'text/csv',
      encoding: utf8,
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  // --- BUILD ---

  @override
  Widget build(BuildContext context) {
    final controllerState = ref.watch(addLecturerControllerProvider);
    final departmentsAsync = ref.watch(departmentsProvider);
    final isMobile = MediaQuery.of(context).size.width < 600;

    return DefaultTabController(
      length: 2,
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isMobile ? double.infinity : 600,
            maxHeight: 700,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // --- SEAMLESS TAB BAR ---
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TabBar(
                    labelColor: Colors.blue.shade700,
                    unselectedLabelColor: Colors.blueGrey,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    tabs: const [
                      Tab(text: "Single Lecturer"),
                      Tab(text: "Bulk CSV"),
                    ],
                  ),
                ),
              ),

              // --- ERROR DISPLAY ---
              if (controllerState.error != null)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      controllerState.error!,
                      style: const TextStyle(color: Colors.red, fontSize: 13),
                    ),
                  ),
                ),

              Flexible(
                child: TabBarView(
                  children: [
                    // --- TAB 1: SINGLE ENTRY ---
                    SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 1. Name & Title
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: DropdownButtonFormField<String>(
                                    value: _selectedTitle,
                                    isExpanded: true,
                                    decoration: _decor("Title"),
                                    items: ["Mr", "Ms", "Mrs", "Dr", "Prof"]
                                        .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                                        .toList(),
                                    onChanged: (v) => setState(() => _selectedTitle = v!),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  flex: 3,
                                  child: TextFormField(
                                    controller: _firstNameController,
                                    decoration: _decor("First Name"),
                                    validator: (v) => v!.isEmpty ? "Req" : null,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  flex: 3,
                                  child: TextFormField(
                                    controller: _lastNameController,
                                    decoration: _decor("Last Name"),
                                    validator: (v) => v!.isEmpty ? "Req" : null,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            // 2. Contact
                            TextFormField(
                              controller: _emailController,
                              decoration: _decor("Email Address", icon: Icons.email_outlined),
                              validator: (v) => v!.contains("@") ? null : "Invalid",
                            ),
                            const SizedBox(height: 16),

                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: _phoneController,
                                    decoration: _decor("Phone", icon: Icons.phone_outlined),
                                    validator: (v) => v!.isEmpty ? "Req" : null,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: TextFormField(
                                    controller: _nationalIdController,
                                    decoration: _decor("National ID", icon: Icons.badge_outlined),
                                    validator: (v) => v!.isEmpty ? "Req" : null,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            // 3. Demographics & Dept
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: DropdownButtonFormField<String>(
                                    value: _selectedGender,
                                    decoration: _decor("Gender"),
                                    items: const [
                                      DropdownMenuItem(value: "M", child: Text("Male")),
                                      DropdownMenuItem(value: "F", child: Text("Female")),
                                    ],
                                    onChanged: (v) => setState(() => _selectedGender = v!),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  flex: 2,
                                  child: TextFormField(
                                    controller: _dobController,
                                    readOnly: true,
                                    decoration: _decor("Date of Birth", icon: Icons.cake_outlined),
                                    onTap: _pickDob,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            departmentsAsync.when(
                              loading: () => const LinearProgressIndicator(),
                              error: (e, _) => const Text("Error loading departments"),
                              data: (departments) => DropdownButtonFormField<String>(
                                value: _selectedDepartmentId,
                                decoration: _decor("Department", icon: Icons.business_outlined),
                                items: departments.map<DropdownMenuItem<String>>((d) {
                                  // Adjust dynamic access if generated model differs
                                  final dept = d as dynamic;
                                  return DropdownMenuItem(
                                    value: dept.publicId.toString(),
                                    child: Text(dept.name.toString(), overflow: TextOverflow.ellipsis),
                                  );
                                }).toList(),
                                onChanged: (v) => setState(() => _selectedDepartmentId = v),
                                validator: (v) => v == null ? "Required" : null,
                              ),
                            ),
                            const SizedBox(height: 16),

                            // 4. Address
                            TextFormField(
                              controller: _addressController,
                              decoration: _decor("Physical Address", icon: Icons.location_on_outlined),
                              maxLines: 2,
                              validator: (v) => v!.isEmpty ? "Req" : null,
                            ),
                            const SizedBox(height: 24),

                            // Action Buttons
                            _buildActionButtons(
                              label: controllerState.isLoading ? "Saving..." : "Add Lecturer",
                              onPressed: controllerState.isLoading ? null : _submitSingle,
                            ),
                          ],
                        ),
                      ),
                    ),

                    // --- TAB 2: BULK UPLOAD ---
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          const Icon(Icons.upload_file_rounded, size: 64, color: Colors.blueGrey),
                          const SizedBox(height: 16),
                          const Text(
                            "Upload CSV file for batch registration",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextButton.icon(
                            onPressed: _downloadTemplate,
                            icon: const Icon(Icons.download, size: 18),
                            label: const Text("Template.csv"),
                          ),
                          const SizedBox(height: 24),
                          InkWell(
                            onTap: _pickFile,
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.blue.shade100),
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.blue.shade50.withOpacity(0.3),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    _selectedFile != null ? Icons.check_circle : Icons.attach_file,
                                    color: Colors.blue,
                                  ),
                                  const SizedBox(width: 12),
                                  Flexible(
                                    child: Text(
                                      _selectedFile?.name ?? "Select CSV File",
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Spacer(),
                          _buildActionButtons(
                            label: controllerState.isLoading ? "Uploading..." : "Process Batch",
                            onPressed: (controllerState.isLoading || _selectedFile == null)
                                ? null
                                : _submitBatch,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons({required String label, required VoidCallback? onPressed}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade700,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: onPressed,
            child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(height: 4),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel", style: TextStyle(color: Colors.grey.shade600)),
        ),
      ],
    );
  }
}