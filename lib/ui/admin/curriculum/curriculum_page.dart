import 'package:flutter/material.dart';
import '../../../services/api_service.dart';
import '../../../models/curriculum_models.dart';
import 'curriculum_dialogs.dart';

class CurriculumPage extends StatefulWidget {
  const CurriculumPage({super.key});

  @override
  State<CurriculumPage> createState() => _CurriculumPageState();
}

class _CurriculumPageState extends State<CurriculumPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Data States
  List<Department> _departments = [];
  List<AcademicLevel> _levels = [];
  Semester? _currentSemester;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadAllData();
  }

  Future<void> _loadAllData() async {
    setState(() => _isLoading = true);
    try {
      // 1. Departments
      final deptRes = await ApiService.get('/curriculum/departments');
      if (deptRes is Map && deptRes['data'] is List) {
        _departments = (deptRes['data'] as List).map((x) => Department.fromJson(x)).toList();
      }

      // 2. Levels (Structure)
      final levelRes = await ApiService.get('/curriculum/levels');
      if (levelRes is Map && levelRes['data'] is List) {
        _levels = (levelRes['data'] as List).map((x) => AcademicLevel.fromJson(x)).toList();
      }

      // 3. Current Semester
      try {
        final semRes = await ApiService.get('/curriculum/semesters/current');
        if (semRes is Map && semRes['data'] != null) {
          _currentSemester = Semester.fromJson(semRes['data']);
        }
      } catch (_) {
        _currentSemester = null; // 404 means no active semester
      }

    } catch (e) {
      debugPrint("Error loading curriculum: $e");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // Helper to open dialogs
  Future<void> _openDialog(Widget dialog) async {
    final res = await showDialog(context: context, builder: (_) => dialog);
    if (res == true) _loadAllData();
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
            // Header
            const Text("Curriculum Management", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            // Tabs
            Container(
              decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5))
              ),
              child: TabBar(
                controller: _tabController,
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.grey,
                isScrollable: true,
                tabs: const [
                  Tab(text: "Departments"),
                  Tab(text: "Academic Structure"),
                  Tab(text: "Semesters"),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Tab Content
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : TabBarView(
                controller: _tabController,
                children: [
                  _buildDepartmentsTab(),
                  _buildStructureTab(),
                  _buildSemestersTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- TAB 1: DEPARTMENTS ---
  Widget _buildDepartmentsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton.icon(
              onPressed: () => _openDialog(AddCourseDialog()),
              icon: const Icon(Icons.book),
              label: const Text("Add Course"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
            ),
            const SizedBox(width: 12),
            ElevatedButton.icon(
              onPressed: () => _openDialog(AddDepartmentDialog()),
              icon: const Icon(Icons.add),
              label: const Text("New Department"),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Expanded(
          child: SingleChildScrollView(
            child: DataTable(
              headingRowColor: MaterialStateProperty.all(Colors.grey.shade100),
              columns: const [
                DataColumn(label: Text("ID")),
                DataColumn(label: Text("Department Name")),
                DataColumn(label: Text("Code")),
              ],
              rows: _departments.map((d) => DataRow(cells: [
                DataCell(Text(d.id.toString())),
                DataCell(Text(d.name)),
                DataCell(Text(d.code)),
              ])).toList(),
            ),
          ),
        ),
      ],
    );
  }

  // --- TAB 2: STRUCTURE (Levels & Programs) ---
  Widget _buildStructureTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton.icon(
            onPressed: () => _openDialog(AddProgramDialog()),
            icon: const Icon(Icons.school),
            label: const Text("Add Program"),
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            itemCount: _levels.length,
            itemBuilder: (context, index) {
              final level = _levels[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ExpansionTile(
                  title: Text(level.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text("${level.programs.length} Programs"),
                  children: level.programs.map((p) => ListTile(
                    leading: const Icon(Icons.subdirectory_arrow_right, size: 16),
                    title: Text(p.name),
                    subtitle: Text(p.code),
                    trailing: Chip(label: Text("ID: ${p.id}")),
                  )).toList(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // --- TAB 3: SEMESTERS ---
  Widget _buildSemestersTab() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(32),
        constraints: const BoxConstraints(maxWidth: 500),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.calendar_month, size: 64, color: Colors.blue),
            const SizedBox(height: 24),
            if (_currentSemester != null) ...[
              const Text("Active Semester", style: TextStyle(color: Colors.grey)),
              Text(
                "Semester ${_currentSemester!.number} (${_currentSemester!.academicYear})",
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              const Divider(),
              const SizedBox(height: 16),
              const Text("To start a new semester, the current one will be archived automatically.", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
            ] else ...[
              const Text("No Active Semester", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.redAccent)),
              const SizedBox(height: 16),
              const Text("The academic system is currently paused. Start a new semester to resume operations.", textAlign: TextAlign.center),
            ],
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _openDialog(StartSemesterDialog()),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: const Text("Start New Semester"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}