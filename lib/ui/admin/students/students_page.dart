import 'package:flutter/material.dart';
import '../../../services/api_service.dart';
import '../../../models/student.dart';
import 'add_student_dialog.dart';

class StudentsPage extends StatefulWidget {
  const StudentsPage({super.key});

  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  bool _isLoading = true;
  List<Student> _students = [];
  String? _error;

  // Pagination State
  int _currentPage = 1;
  final int _limit = 20;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _fetchStudents();
  }

  Future<void> _fetchStudents() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final dynamic response = await ApiService.get('/students?page=$_currentPage&limit=$_limit');

      List<dynamic> listData = [];

      if (response is Map<String, dynamic> && response['data'] is List) {
        listData = response['data'];
        // Optional: Handle meta/pagination here
      } else {
        listData = [];
      }

      final newStudents = listData.map((json) => Student.fromJson(json)).toList();

      if (mounted) {
        setState(() {
          _students = newStudents;
          _isLoading = false;
          _hasMore = newStudents.length == _limit;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString().replaceAll("Exception:", "").trim();
          _isLoading = false;
        });
      }
    }
  }

  void _onPageChanged(int newPage) {
    setState(() => _currentPage = newPage);
    _fetchStudents();
  }

  Future<void> _showAddStudentDialog() async {
    final result = await showDialog(
      context: context,
      builder: (context) => const AddStudentDialog(),
    );

    if (result == true) {
      _fetchStudents();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Student registered successfully"), backgroundColor: Colors.green),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- FIXED HEADER ---
            // Changed from Row to Wrap to handle small screens (332px width)
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 20, // Horizontal space between items
              runSpacing: 20, // Vertical space if button drops down
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Students", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text("Manage student enrollments", style: TextStyle(color: Colors.grey)),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: _showAddStudentDialog,
                  icon: const Icon(Icons.add),
                  label: const Text("Register Student"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // --- CONTENT AREA ---
            Expanded(
              child: _buildContent(),
            ),

            // --- PAGINATION CONTROLS ---
            if (!_isLoading && _students.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left),
                      onPressed: _currentPage > 1 ? () => _onPageChanged(_currentPage - 1) : null,
                    ),
                    Text("Page $_currentPage"),
                    IconButton(
                      icon: const Icon(Icons.chevron_right),
                      onPressed: _hasMore ? () => _onPageChanged(_currentPage + 1) : null,
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.redAccent),
            const SizedBox(height: 16),
            Text("Error loading students", style: TextStyle(color: Colors.grey[800])),
            Text(_error!, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _fetchStudents, child: const Text("Retry")),
          ],
        ),
      );
    }

    if (_students.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.school_outlined, size: 64, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            Text("No students found", style: TextStyle(color: Colors.grey[600], fontSize: 18)),
          ],
        ),
      );
    }

    // --- FIXED DATA TABLE ---
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal, // Add horizontal scrolling for small screens
          child: DataTable(
            headingRowColor: MaterialStateProperty.all(Colors.grey.shade50),
            columns: const [
              DataColumn(label: Text("Student ID")),
              DataColumn(label: Text("Name")),
              DataColumn(label: Text("Program")),
              DataColumn(label: Text("Actions")),
            ],
            rows: _students.map((student) {
              return DataRow(cells: [
                DataCell(Text(student.studentId, style: const TextStyle(fontWeight: FontWeight.bold))),

                // Fixed: Defensive coding for Name Column overflow
                DataCell(
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 200), // Limit width
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: 14,
                          backgroundColor: Colors.blue.shade50,
                          child: Text(student.name.isNotEmpty ? student.name[0] : "?",
                              style: TextStyle(color: Colors.blue.shade800, fontSize: 12)),
                        ),
                        const SizedBox(width: 12),
                        Flexible( // Allows text to shrink/wrap
                          child: Text(
                            student.name,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                DataCell(Text(student.program)),

                DataCell(IconButton(
                  icon: const Icon(Icons.edit, size: 20, color: Colors.grey),
                  onPressed: () {},
                )),
              ]);
            }).toList(),
          ),
        ),
      ),
    );
  }
}