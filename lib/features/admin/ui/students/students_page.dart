import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/students_provider.dart';
import '../../../../shared/widgets/error_view.dart';
import 'student_details_page.dart';
import '../widgets/student_data_table.dart';
import 'add_student_dialog.dart'; // Import your dialog

class StudentsPage extends ConsumerStatefulWidget {
  const StudentsPage({super.key});

  @override
  ConsumerState<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends ConsumerState<StudentsPage> {
  final TextEditingController _searchController = TextEditingController();

  void _navigateToDetails(BuildContext context, String publicId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StudentDetailsPage(publicId: publicId)),
    );
  }

  void _showAddStudentDialog() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => const AddStudentDialog(),
    );
    
    // Refresh list if a student was successfully added
    if (result == true) {
      ref.invalidate(studentsListProvider);
    }
  }

  @override
  Widget build(BuildContext context) {
    final studentsAsync = ref.watch(studentsListProvider);
    final bool isMobile = MediaQuery.of(context).size.width < 900;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: EdgeInsets.all(isMobile ? 16 : 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Header ---
            _buildHeader(isMobile),
            const SizedBox(height: 24),
            
            // --- Search Bar ---
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search by Name, ID or Program...",
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty 
                  ? IconButton(
                      icon: const Icon(Icons.clear), 
                      onPressed: () {
                        _searchController.clear();
                        ref.read(studentFilterProvider.notifier).update((s) => s.copyWith(searchQuery: null));
                        setState(() {});
                      }
                    ) 
                  : null,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (value) {
                setState(() {}); // For clear button
                ref.read(studentFilterProvider.notifier).update(
                  (state) => state.copyWith(searchQuery: value.isEmpty ? null : value, page: 1),
                );
              },
            ),
            const SizedBox(height: 24),

            // --- Data Area ---
            Expanded(
              child: studentsAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, _) => ErrorView(
                  error: err.toString(),
                  onRetry: () => ref.invalidate(studentsListProvider),
                ),
                data: (response) {
                  // FIX: Removed unnecessary ?. because response is non-null here
                  final students = response.data ?? [];
                  if (students.isEmpty) return const Center(child: Text("No students found"));

                  return isMobile
                      ? StudentMobileList(students: students, onRowTap: (id) => _navigateToDetails(context, id))
                      : StudentDataTable(students: students, onRowTap: (id) => _navigateToDetails(context, id));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(bool isMobile) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Students", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            Text("Manage registration and student profiles", style: TextStyle(color: Colors.grey)),
          ],
        ),
        ElevatedButton.icon(
          onPressed: _showAddStudentDialog, // Replaced TODO with your logic
          icon: const Icon(Icons.add),
          label: Text(isMobile ? "Add" : "Register Student"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue.shade700,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }
}