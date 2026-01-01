import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_api/api.dart' as admin;

// 1. Import your central curriculum providers (contains semestersProvider, programsProvider)
import '../../providers/curriculum_providers.dart';

// 2. Import the Results Providers (for fetching student results & publishing)
import '../../providers/results_provider.dart';

// 3. Import the Transcript Page
import 'student_transcript_page.dart';

class ResultsManagementPage extends ConsumerStatefulWidget {
  const ResultsManagementPage({super.key});

  @override
  ConsumerState<ResultsManagementPage> createState() => _ResultsManagementPageState();
}

class _ResultsManagementPageState extends ConsumerState<ResultsManagementPage> {
  String? _selectedSemesterId;

  @override
  Widget build(BuildContext context) {
    // USE REAL DATA: Watch the semestersProvider from curriculum_providers.dart
    final semestersAsync = ref.watch(semestersProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Exam Results Management")),
      body: Column(
        children: [
          // 1. Semester Selector
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: semestersAsync.when(
              loading: () => const LinearProgressIndicator(),
              error: (err, _) => Text("Error loading semesters: $err", style: const TextStyle(color: Colors.red)),
              data: (semesters) {
                if (semesters.isEmpty) {
                  return const Text("No semesters found.");
                }

                // If no semester is selected yet, optionally auto-select the first one (or active one)
                // For now, we leave it null until user selects.

                return DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                      labelText: "Select Semester",
                      border: OutlineInputBorder()
                  ),
                  value: _selectedSemesterId,
                  items: semesters.map((sem) {
                    return DropdownMenuItem(
                      value: sem.publicId,
                      child: Text("${sem.academicYear} - Semester ${sem.semesterNumber}"),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() => _selectedSemesterId = val);
                  },
                );
              },
            ),
          ),

          // 2. Program List (Only show if semester is selected)
          if (_selectedSemesterId != null)
            Expanded(
              child: _ProgramList(semesterId: _selectedSemesterId!),
            )
          else
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.school, size: 64, color: Colors.grey.shade300),
                    const SizedBox(height: 16),
                    const Text("Please select a semester to view results"),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ProgramList extends ConsumerWidget {
  final String semesterId;
  const _ProgramList({required this.semesterId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // USE REAL DATA: Watch the programsProvider from curriculum_providers.dart
    final programsAsync = ref.watch(programsProvider);

    return programsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(child: Text("Error loading programs: $err")),
      data: (programs) {
        if (programs.isEmpty) {
          return const Center(child: Text("No programs found in the system."));
        }

        return ListView.builder(
          itemCount: programs.length,
          itemBuilder: (context, index) {
            final program = programs[index];
            return _ProgramResultExpansionTile(
              programId: program.publicId!,
              programName: program.name!,
              semesterId: semesterId,
            );
          },
        );
      },
    );
  }
}

class _ProgramResultExpansionTile extends ConsumerWidget {
  final String programId;
  final String programName;
  final String semesterId;

  const _ProgramResultExpansionTile({
    required this.programId,
    required this.programName,
    required this.semesterId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Fetch real results for this specific program/semester combo
    // (This comes from results_providers.dart)
    final resultsAsync = ref.watch(programResultsProvider(
        (programId: programId, semesterId: semesterId)
    ));

    // 2. Watch publishing state
    final publishState = ref.watch(publishResultControllerProvider);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ExpansionTile(
        title: Text(programName, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: resultsAsync.when(
          data: (response) => Row(
            children: [
              Icon(
                response.isPublished == true ? Icons.check_circle : Icons.edit_note,
                size: 16,
                color: response.isPublished == true ? Colors.green : Colors.orange,
              ),
              const SizedBox(width: 4),
              Text(
                response.isPublished == true ? "Published" : "Draft / Pending",
                style: TextStyle(
                    color: response.isPublished == true ? Colors.green : Colors.orange,
                    fontWeight: FontWeight.w500
                ),
              ),
            ],
          ),
          loading: () => const Text("Loading status...", style: TextStyle(fontSize: 12)),
          error: (_,__) => const Text("Error", style: TextStyle(fontSize: 12, color: Colors.red)),
        ),
        children: [
          resultsAsync.when(
            loading: () => const Padding(
              padding: EdgeInsets.all(20),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (err, _) => Padding(
              padding: const EdgeInsets.all(16),
              child: Text("Error: $err", style: const TextStyle(color: Colors.red)),
            ),
            data: (response) {
              final students = response.data ?? [];
              final isPublished = response.isPublished == true;

              if (students.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text("No student results found for this semester."),
                );
              }

              return Column(
                children: [
                  // --- Action Bar ---
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    color: Colors.grey.shade50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${students.length} Students", style: const TextStyle(fontWeight: FontWeight.bold)),

                        // Publish Button
                        if (!isPublished)
                          ElevatedButton.icon(
                            onPressed: publishState.isLoading
                                ? null
                                : () async {
                              await ref.read(publishResultControllerProvider.notifier)
                                  .publish(programId: programId, semesterId: semesterId);
                            },
                            icon: publishState.isLoading
                                ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                                : const Icon(Icons.send, size: 18),
                            label: const Text("Publish Results"),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white
                            ),
                          )
                        else
                          OutlinedButton.icon(
                            onPressed: null,
                            icon: const Icon(Icons.check),
                            label: const Text("Results Published"),
                          )
                      ],
                    ),
                  ),

                  // --- Students Table ---
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width - 64),
                      child: DataTable(
                        showCheckboxColumn: false,
                        headingRowColor: WidgetStateProperty.all(Colors.grey.shade100),
                        columns: const [
                          DataColumn(label: Text("Student ID")),
                          DataColumn(label: Text("Name")),
                          DataColumn(label: Text("Status")),
                          DataColumn(label: Text("Decision")),
                        ],
                        rows: students.map((student) {
                          return DataRow(
                              onSelectChanged: (_) {
                                if (student.studentPublicId == null) return;

                                Navigator.push(context, MaterialPageRoute(builder: (_) =>
                                    StudentTranscriptPage(
                                        studentPublicId: student.studentPublicId!,
                                        semesterPublicId: semesterId
                                    )
                                ));
                              },
                              cells: [
                                DataCell(Text(student.studentId ?? "-", style: const TextStyle(fontWeight: FontWeight.w500))),
                                DataCell(Text("${student.lastName}, ${student.firstName}")),
                                DataCell(_buildStatusBadge(student.status.toString())),
                                DataCell(_buildDecisionIcon(student.semesterDecision.toString())),
                              ]
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildStatusBadge(String status) {
    final cleanStatus = status.contains('.') ? status.split('.').last.toUpperCase() : status.toUpperCase();
    final isComplete = cleanStatus == 'COMPLETE';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
          color: isComplete ? Colors.green.shade50 : Colors.orange.shade50,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: isComplete ? Colors.green.shade200 : Colors.orange.shade200)
      ),
      child: Text(
        cleanStatus,
        style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: isComplete ? Colors.green.shade800 : Colors.orange.shade800
        ),
      ),
    );
  }

  Widget _buildDecisionIcon(String decision) {
    final cleanDecision = decision.contains('.') ? decision.split('.').last.toUpperCase() : decision.toUpperCase();

    if (cleanDecision == 'PROMOTED') {
      return const Icon(Icons.check_circle, color: Colors.green, size: 20);
    } else if (cleanDecision == 'REPEAT' || cleanDecision == 'DISMISSED') {
      return const Icon(Icons.cancel, color: Colors.red, size: 20);
    }
    return const Icon(Icons.help_outline, color: Colors.grey, size: 20);
  }
}