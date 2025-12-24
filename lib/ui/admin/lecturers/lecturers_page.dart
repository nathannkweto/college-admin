import 'package:flutter/material.dart';
import '../../../services/api_service.dart';
import '../../../models/lecturer.dart';
import 'add_lecturer_dialog.dart';

class LecturersPage extends StatefulWidget {
  const LecturersPage({super.key});

  @override
  State<LecturersPage> createState() => _LecturersPageState();
}

class _LecturersPageState extends State<LecturersPage> {
  bool _isLoading = true;
  List<Lecturer> _lecturers = [];
  String? _error;

  // Pagination State
  int _currentPage = 1;
  final int _limit = 20;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _fetchLecturers();
  }

  Future<void> _fetchLecturers() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final dynamic response = await ApiService.get('/lecturers?page=$_currentPage&limit=$_limit');

      List<dynamic> listData = [];

      if (response is Map<String, dynamic> && response['data'] is List) {
        listData = response['data'];
      } else {
        listData = [];
      }

      final newLecturers = listData.map((json) => Lecturer.fromJson(json)).toList();

      if (mounted) {
        setState(() {
          _lecturers = newLecturers;
          _isLoading = false;
          _hasMore = newLecturers.length == _limit;
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
    _fetchLecturers();
  }

  Future<void> _showAddLecturerDialog() async {
    final result = await showDialog(
      context: context,
      builder: (context) => const AddLecturerDialog(),
    );

    if (result == true) {
      _fetchLecturers();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lecturer registered successfully"), backgroundColor: Colors.green),
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
            // --- FIXED HEADER (Uses Wrap to prevent overflow) ---
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 20, // Horizontal space
              runSpacing: 20, // Vertical space
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Lecturers", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text("Manage lecturers", style: TextStyle(color: Colors.grey)),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: _showAddLecturerDialog,
                  icon: const Icon(Icons.add),
                  label: const Text("Add Lecturer"),
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
            if (!_isLoading && _lecturers.isNotEmpty)
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
            Text("Error loading lecturers", style: TextStyle(color: Colors.grey[800])),
            Text(_error!, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _fetchLecturers, child: const Text("Retry")),
          ],
        ),
      );
    }

    if (_lecturers.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.school_outlined, size: 64, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            Text("No lecturers found", style: TextStyle(color: Colors.grey[600], fontSize: 18)),
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
          scrollDirection: Axis.horizontal, // Enables horizontal scrolling on small screens
          child: DataTable(
            headingRowColor: MaterialStateProperty.all(Colors.grey.shade50),
            columns: const [
              DataColumn(label: Text("Lecturer ID")),
              DataColumn(label: Text("Name")),
              DataColumn(label: Text("Department")),
              DataColumn(label: Text("Action")),
            ],
            rows: _lecturers.map((lecturer) {
              return DataRow(cells: [
                DataCell(Text(lecturer.staffId, style: const TextStyle(fontWeight: FontWeight.bold))),

                // Fixed Name Cell: Prevents overflow
                DataCell(
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 200),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: 14,
                          backgroundColor: Colors.blue.shade50,
                          child: Text(lecturer.name.isNotEmpty ? lecturer.name[0] : "?",
                              style: TextStyle(color: Colors.blue.shade800, fontSize: 12)),
                        ),
                        const SizedBox(width: 12),
                        Flexible( // Allows text to shrink
                          child: Text(
                            lecturer.name,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                DataCell(Text(lecturer.department)),

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