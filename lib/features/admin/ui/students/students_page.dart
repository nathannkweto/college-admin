import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_api/api.dart' as admin; // Alias for clarity
import '../../providers/students_provider.dart';
import 'add_student_dialog.dart';

class StudentsPage extends ConsumerWidget {
  const StudentsPage({super.key});

  Future<void> _showAddStudentDialog(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final result = await showDialog(
      context: context,
      builder: (context) => const AddStudentDialog(),
    );

    if (result == true) {
      ref.invalidate(studentsListProvider);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Student registered successfully"),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the provider (returns the Generated Response Object)
    final studentsAsync = ref.watch(studentsListProvider);
    final filterState = ref.watch(studentFilterProvider);

    final bool isMobile = MediaQuery.of(context).size.width < 900;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: EdgeInsets.all(isMobile ? 16 : 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- HEADER ---
            _buildHeader(context, ref, isMobile),
            const SizedBox(height: 24),

            // --- SEARCH BAR ---
            TextField(
              decoration: InputDecoration(
                hintText: "Search by Name, ID or Program...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                filled: true,
                fillColor: Colors.white,
              ),
              onSubmitted: (value) {
                ref
                    .read(studentFilterProvider.notifier)
                    .update(
                      (state) => state.copyWith(
                        searchQuery: value.isEmpty ? null : value,
                        page: 1,
                      ),
                    );
              },
            ),
            const SizedBox(height: 24),

            // --- DATA AREA ---
            Expanded(
              child: studentsAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => _buildErrorState(ref, err.toString()),
                data: (response) {
                  // Based on YAML: content -> application/json -> schema -> properties -> data
                  final students = response?.data ?? [];

                  // Note: Your current YAML for /students GET does not return 'meta'.
                  // If you update YAML to include PaginationMeta, you can uncomment below.
                  // final meta = response?.meta;
                  const admin.PaginationMeta? meta = null;

                  if (students.isEmpty) return _buildEmptyState();

                  return Column(
                    children: [
                      Expanded(
                        child: isMobile
                            ? _buildMobileList(students)
                            : _buildDataTable(students),
                      ),
                      // Only show pagination if metadata exists
                      if (meta != null)
                        _buildPagination(ref, meta, filterState.page),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGETS ---

  Widget _buildHeader(BuildContext context, WidgetRef ref, bool isMobile) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Students",
                style: TextStyle(
                  fontSize: isMobile ? 22 : 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "Manage student enrollments & records",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
        isMobile
            ? FloatingActionButton.small(
                onPressed: () => _showAddStudentDialog(context, ref),
                backgroundColor: Colors.blue,
                child: const Icon(Icons.add, color: Colors.white),
              )
            : ElevatedButton.icon(
                onPressed: () => _showAddStudentDialog(context, ref),
                icon: const Icon(Icons.add),
                label: const Text("Register Student"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),
      ],
    );
  }

  // DESKTOP TABLE
  Widget _buildDataTable(List<admin.Student> students) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: SingleChildScrollView(
        child: DataTable(
          headingRowColor: WidgetStateProperty.all(Colors.grey.shade50),
          columns: const [
            DataColumn(label: Text("Student ID")),
            DataColumn(label: Text("Name")),
            DataColumn(label: Text("Gender")),
            DataColumn(label: Text("Program")),
            DataColumn(label: Text("Status")),
            DataColumn(label: Text("Actions")),
          ],
          rows: students.map((student) {
            final fullName = "${student.firstName} ${student.lastName}";

            // Handle Enums safely (Generated code usually creates explicit Enum types)
            final genderStr = student.gender?.toString().split('.').last ?? '-';
            final statusStr = student.status?.toString().split('.').last ?? '-';

            return DataRow(
              cells: [
                DataCell(
                  Text(
                    student.studentId ?? "N/A",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataCell(
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.blue.shade100,
                        child: Text(
                          fullName.isNotEmpty ? fullName[0].toUpperCase() : "?",
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(fullName),
                    ],
                  ),
                ),
                DataCell(Text(genderStr)), // New Field
                DataCell(Text(student.program?.name ?? "N/A")),
                DataCell(_buildStatusBadge(statusStr)), // New Field
                DataCell(
                  IconButton(
                    icon: const Icon(Icons.edit_outlined, size: 20),
                    onPressed: () {
                      // TODO: Implement Edit
                    },
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  // MOBILE LIST
  Widget _buildMobileList(List<admin.Student> students) {
    return ListView.builder(
      itemCount: students.length,
      itemBuilder: (context, index) {
        final student = students[index];
        final fullName = "${student.firstName} ${student.lastName}";
        final statusStr =
            student.status?.toString().split('.').last ?? 'active';

        return Card(
          elevation: 0,
          margin: const EdgeInsets.only(bottom: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.grey.shade200),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            leading: CircleAvatar(
              backgroundColor: Colors.blue.shade100,
              child: Text(
                fullName.isNotEmpty ? fullName[0].toUpperCase() : "?",
              ),
            ),
            title: Text(
              fullName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("ID: ${student.studentId}"),
                Text(
                  student.program?.name ?? 'No Program',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            trailing: _buildStatusBadge(statusStr, small: true),
            onTap: () {},
          ),
        );
      },
    );
  }

  // HELPER: Status Badge
  Widget _buildStatusBadge(String status, {bool small = false}) {
    Color color;
    switch (status.toLowerCase()) {
      case 'active':
        color = Colors.green;
        break;
      case 'graduated':
        color = Colors.blue;
        break;
      case 'suspended':
        color = Colors.red;
        break;
      case 'inactive':
        color = Colors.orange;
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: small ? 8 : 12,
        vertical: small ? 4 : 6,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          color: color,
          fontSize: small ? 10 : 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // PAGINATION (Only visible if Meta exists)
  Widget _buildPagination(
    WidgetRef ref,
    admin.PaginationMeta meta,
    int currentPage,
  ) {
    final lastPage = meta.lastPage ?? 1;
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: currentPage > 1
                ? () => ref
                      .read(studentFilterProvider.notifier)
                      .update((s) => s.copyWith(page: currentPage - 1))
                : null,
          ),
          Text(
            "Page $currentPage of $lastPage",
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: currentPage < lastPage
                ? () => ref
                      .read(studentFilterProvider.notifier)
                      .update((s) => s.copyWith(page: currentPage + 1))
                : null,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person_search_outlined,
            size: 64,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 16),
          const Text(
            "No students found",
            style: TextStyle(color: Colors.grey, fontSize: 18),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(WidgetRef ref, String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 40),
          const SizedBox(height: 8),
          Text(
            "Error loading data",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            error.replaceAll("Exception:", "").trim(),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          TextButton.icon(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(studentsListProvider),
            label: const Text("Retry"),
          ),
        ],
      ),
    );
  }
}
