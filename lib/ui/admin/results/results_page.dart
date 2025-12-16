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
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Results & Transcripts", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            // Tabs
            Container(
              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5))),
              child: TabBar(
                controller: _tabController,
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.grey,
                isScrollable: true,
                tabs: const [
                  Tab(text: "Upload Grades"),
                  Tab(text: "Student Transcript"),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Tab Content
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
  final _studentIdCtrl = TextEditingController(); // This is DB ID
  final _semesterIdCtrl = TextEditingController();

  // Dynamic list of grades
  final List<Map<String, TextEditingController>> _gradeRows = [];

  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _addGradeRow(); // Start with one empty row
  }

  void _addGradeRow() {
    setState(() {
      _gradeRows.add({
        "course": TextEditingController(),
        "score": TextEditingController(),
      });
    });
  }

  void _removeGradeRow(int index) {
    if (_gradeRows.length > 1) {
      setState(() => _gradeRows.removeAt(index));
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    try {
      final gradesList = _gradeRows.map((row) => {
        "course_id": int.parse(row["course"]!.text),
        "score": double.parse(row["score"]!.text),
      }).toList();

      final payload = {
        "student_db_id": int.parse(_studentIdCtrl.text),
        "semester_id": int.parse(_semesterIdCtrl.text),
        "grades": gradesList,
      };

      await ApiService.post('/results/batch', payload);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Results uploaded successfully!"), backgroundColor: Colors.green),
        );
        // Clear form
        _studentIdCtrl.clear();
        _semesterIdCtrl.clear();
        setState(() {
          _gradeRows.clear();
          _addGradeRow();
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${e.toString().replaceAll("Exception:", "")}"), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 800),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Inputs
              Row(
                children: [
                  Expanded(child: TextFormField(
                    controller: _studentIdCtrl,
                    decoration: const InputDecoration(labelText: "Student Database ID", border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    validator: (v) => v!.isEmpty ? "Required" : null,
                  )),
                  const SizedBox(width: 16),
                  Expanded(child: TextFormField(
                    controller: _semesterIdCtrl,
                    decoration: const InputDecoration(labelText: "Semester ID", border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    validator: (v) => v!.isEmpty ? "Required" : null,
                  )),
                ],
              ),
              const SizedBox(height: 24),
              const Text("Grades", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 8),

              // Dynamic Rows
              ..._gradeRows.asMap().entries.map((entry) {
                int idx = entry.key;
                var controllers = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      Expanded(flex: 2, child: TextFormField(
                        controller: controllers["course"],
                        decoration: InputDecoration(labelText: "Course ID", filled: true, fillColor: Colors.grey.shade50),
                        validator: (v) => v!.isEmpty ? "Req" : null,
                      )),
                      const SizedBox(width: 12),
                      Expanded(flex: 1, child: TextFormField(
                        controller: controllers["score"],
                        decoration: InputDecoration(labelText: "Score (0-100)", filled: true, fillColor: Colors.grey.shade50),
                        validator: (v) => v!.isEmpty ? "Req" : null,
                      )),
                      IconButton(
                        onPressed: () => _removeGradeRow(idx),
                        icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                      )
                    ],
                  ),
                );
              }),

              TextButton.icon(
                  onPressed: _addGradeRow,
                  icon: const Icon(Icons.add),
                  label: const Text("Add Another Course")
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submit,
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16)),
                  child: _isSubmitting ? const CircularProgressIndicator() : const Text("Upload Results"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --------------------------------------------------------------------------
// TAB 2: TRANSCRIPT VIEW
// --------------------------------------------------------------------------
class _TranscriptViewTab extends StatefulWidget {
  const _TranscriptViewTab();

  @override
  State<_TranscriptViewTab> createState() => _TranscriptViewTabState();
}

class _TranscriptViewTabState extends State<_TranscriptViewTab> {
  final _searchCtrl = TextEditingController();
  Transcript? _transcript;
  bool _isLoading = false;
  String? _error;

  Future<void> _fetchTranscript() async {
    if (_searchCtrl.text.isEmpty) return;

    setState(() { _isLoading = true; _error = null; _transcript = null; });

    try {
      final res = await ApiService.get('/results/transcript/${_searchCtrl.text.trim()}');
      if (res is Map && res['data'] != null) {
        setState(() => _transcript = Transcript.fromJson(res['data']));
      } else {
        setState(() => _error = "Invalid data format received");
      }
    } catch (e) {
      setState(() => _error = e.toString().replaceAll("Exception:", "").trim());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search Bar
        Container(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchCtrl,
                  decoration: const InputDecoration(
                    labelText: "Enter Student Database ID",
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.search),
                  ),
                  onSubmitted: (_) => _fetchTranscript(),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: _isLoading ? null : _fetchTranscript,
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20)),
                child: const Text("View Transcript"),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Result Display
        Expanded(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _error != null
              ? Center(child: Text(_error!, style: const TextStyle(color: Colors.red)))
              : _transcript == null
              ? Center(child: Text("Enter a student ID to view results.", style: TextStyle(color: Colors.grey.shade400)))
              : SingleChildScrollView(child: _buildTranscriptCard(_transcript!)),
        ),
      ],
    );
  }

  Widget _buildTranscriptCard(Transcript t) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 800),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Student Info Header
          Card(
            color: Colors.blue.shade50,
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.person)),
              title: Text(t.studentName, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("ID: ${t.studentId} • ${t.program}"),
            ),
          ),
          const SizedBox(height: 16),

          // Loop through semesters (Map entries)
          ...t.records.entries.map((entry) {
            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(entry.key, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
                    const Divider(),
                    Table(
                      columnWidths: const {
                        0: FlexColumnWidth(3),
                        1: FlexColumnWidth(1),
                        2: FlexColumnWidth(1),
                        3: FlexColumnWidth(1),
                      },
                      children: [
                        const TableRow(children: [
                          Text("Course", style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("Code", style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("Score", style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("Grade", style: TextStyle(fontWeight: FontWeight.bold)),
                        ]),
                        const TableRow(children: [SizedBox(height: 8), SizedBox(), SizedBox(), SizedBox()]),
                        ...entry.value.map((course) => TableRow(
                            children: [
                              Padding(padding: const EdgeInsets.symmetric(vertical: 4), child: Text(course.course)),
                              Text(course.code),
                              Text(course.score.toString()),
                              Text(course.grade, style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: course.grade == 'F' ? Colors.red : Colors.green
                              )),
                            ]
                        ))
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}