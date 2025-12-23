import 'package:flutter/material.dart';
import '../../../services/api_service.dart';
import '../../../models/result_models.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage({super.key});

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // Check screen width for responsiveness
    final bool isMobile = MediaQuery.of(context).size.width < 700;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: EdgeInsets.all(isMobile ? 12 : 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Results & Transcripts",
                style: TextStyle(fontSize: isMobile ? 22 : 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            TabBar(
              controller: _tabController,
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.grey,
              isScrollable: true,
              tabs: const [
                Tab(text: "Upload Grades"),
                Tab(text: "Student Transcript"),
              ],
            ),
            const SizedBox(height: 24),

            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  _UploadGradesTab(),
                  _TranscriptViewTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --------------------------------------------------------------------------
// TAB 1: UPLOAD GRADES (Batch Entry)
// --------------------------------------------------------------------------
class _UploadGradesTab extends StatefulWidget {
  const _UploadGradesTab();

  @override
  State<_UploadGradesTab> createState() => _UploadGradesTabState();
}

class _UploadGradesTabState extends State<_UploadGradesTab> {
  final _formKey = GlobalKey<FormState>();
  final _studentCodeCtrl = TextEditingController(); // e.g., "STD-2025-001"

  // Dropdown Data
  List<dynamic> _academicYears = [];
  List<dynamic> _semesters = [];
  List<dynamic> _courses = [];

  int? _selectedYearId;
  int? _selectedSemesterId;

  // Grade Entry Rows
  final List<Map<String, dynamic>> _gradeRows = [];

  bool _isLoadingData = true;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _fetchInitialData();
    _addGradeRow();
  }

  Future<void> _fetchInitialData() async {
    try {
      final yearsRes = await ApiService.get('/curriculum/academic-years');
      final coursesRes = await ApiService.get('/curriculum/courses');

      if (mounted) {
        setState(() {
          _academicYears = List<dynamic>.from(yearsRes['data'] ?? []);
          _courses = List<dynamic>.from(coursesRes['data'] ?? []);
          _isLoadingData = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoadingData = false);
    }
  }

  Future<void> _fetchSemesters(int yearId) async {
    setState(() => _semesters = []); // Clear current semesters
    try {
      final res = await ApiService.get('/curriculum/semesters?year_id=$yearId');
      if (mounted) {
        setState(() {
          _semesters = List<dynamic>.from(res['data'] ?? []);
        });
      }
    } catch (_) {}
  }

  void _addGradeRow() {
    setState(() {
      _gradeRows.add({
        "course_id": null,
        "score_ctrl": TextEditingController(),
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoadingData) return const Center(child: CircularProgressIndicator());

    final isSmall = MediaQuery.of(context).size.width < 600;

    // Pre-compute items
    final yearItems = _academicYears.map((y) => DropdownMenuItem<int>(
        value: y['id'] as int, child: Text(y['display_name'] ?? y['start_year'].toString())
    )).toList();

    final semItems = _semesters.map((s) => DropdownMenuItem<int>(
        value: s['id'] as int, child: Text("Semester ${s['semester_number']}")
    )).toList();

    final courseItems = _courses.map((c) => DropdownMenuItem<int>(
        value: c['id'] as int, child: Text("${c['code']} - ${c['name']}")
    )).toList();

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Student Code and Academic Year
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                SizedBox(
                  width: isSmall ? double.infinity : 250,
                  child: TextFormField(
                    controller: _studentCodeCtrl,
                    decoration: const InputDecoration(labelText: "Student ID (e.g. BSC2510001)", border: OutlineInputBorder()),
                    validator: (v) => v!.isEmpty ? "Required" : null,
                  ),
                ),
                SizedBox(
                  width: isSmall ? double.infinity : 200,
                  child: DropdownButtonFormField<int>(
                    value: _selectedYearId,
                    decoration: const InputDecoration(labelText: "Academic Year", border: OutlineInputBorder()),
                    items: yearItems,
                    onChanged: (val) {
                      setState(() => _selectedYearId = val);
                      if (val != null) _fetchSemesters(val);
                    },
                    validator: (v) => v == null ? "Required" : null,
                  ),
                ),
                SizedBox(
                  width: isSmall ? double.infinity : 200,
                  child: DropdownButtonFormField<int>(
                    value: _selectedSemesterId,
                    decoration: const InputDecoration(labelText: "Semester", border: OutlineInputBorder()),
                    items: semItems,
                    onChanged: (val) => setState(() => _selectedSemesterId = val),
                    validator: (v) => v == null ? "Required" : null,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),
            const Text("Course Grades", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const Divider(),

            // Grade Rows
            ..._gradeRows.asMap().entries.map((entry) {
              int idx = entry.key;
              var row = entry.value;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: isSmall
                    ? _buildMobileRow(idx, row, courseItems) // Stacks for mobile
                    : _buildDesktopRow(idx, row, courseItems), // Inline for desktop
              );
            }),

            const SizedBox(height: 16),
            TextButton.icon(onPressed: _addGradeRow, icon: const Icon(Icons.add), label: const Text("Add Another Course")),
            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _submit,
                child: _isSubmitting ? const CircularProgressIndicator() : const Text("Upload Student Results"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopRow(int idx, Map<String, dynamic> row, List<DropdownMenuItem<int>> courseItems) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: DropdownButtonFormField<int>(
            value: row['course_id'],
            decoration: const InputDecoration(labelText: "Course", border: OutlineInputBorder()),
            items: courseItems,
            onChanged: (v) => setState(() => _gradeRows[idx]['course_id'] = v),
            validator: (v) => v == null ? "Req" : null,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 1,
          child: TextFormField(
            controller: row['score_ctrl'],
            decoration: const InputDecoration(labelText: "Score", border: OutlineInputBorder()),
            keyboardType: TextInputType.number,
            validator: (v) => v!.isEmpty ? "Req" : null,
          ),
        ),
        IconButton(
          onPressed: () => setState(() => _gradeRows.removeAt(idx)),
          icon: const Icon(Icons.delete_outline, color: Colors.red),
        )
      ],
    );
  }

  Widget _buildMobileRow(int idx, Map<String, dynamic> row, List<DropdownMenuItem<int>> courseItems) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            DropdownButtonFormField<int>(
              value: row['course_id'],
              decoration: const InputDecoration(labelText: "Course"),
              items: courseItems,
              onChanged: (v) => setState(() => _gradeRows[idx]['course_id'] = v),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: TextFormField(controller: row['score_ctrl'], decoration: const InputDecoration(labelText: "Score"))),
                IconButton(onPressed: () => setState(() => _gradeRows.removeAt(idx)), icon: const Icon(Icons.delete, color: Colors.red)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSubmitting = true);
    try {
      final grades = _gradeRows.map((r) => {
        "course_id": r['course_id'],
        "score": double.parse(r['score_ctrl'].text),
      }).toList();

      await ApiService.post('/exams/batch', {
        "student_code": _studentCodeCtrl.text.trim(),
        "semester_id": _selectedSemesterId,
        "grades": grades,
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Success!")));
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }
}

// --------------------------------------------------------------------------
// TAB 2: TRANSCRIPT VIEW (Simplified Search)
// --------------------------------------------------------------------------
class _TranscriptViewTab extends StatefulWidget {
  const _TranscriptViewTab();
  @override
  State<_TranscriptViewTab> createState() => _TranscriptViewTabState();
}

class _TranscriptViewTabState extends State<_TranscriptViewTab> {
  final _searchCtrl = TextEditingController();
  // ... Keep your existing Logic for fetching transcript, just update the Search UI ...

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: TextField(
              controller: _searchCtrl,
              decoration: InputDecoration(
                  labelText: "Search by Student ID (e.g. BSC2510001)",
                  prefixIcon: const Icon(Icons.badge),
                  suffixIcon: IconButton(icon: const Icon(Icons.search), onPressed: () {}),
                  border: const OutlineInputBorder()
              ),
            ),
          ),
        ),
        const Expanded(child: Center(child: Text("Search for a student to view their transcript.")))
      ],
    );
  }
}