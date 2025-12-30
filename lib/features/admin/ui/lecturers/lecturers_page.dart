import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_api/api.dart' as admin;
import 'package:college_admin/core/services/api_service.dart';
import 'add_lecturer_dialog.dart';

// --- PROVIDER ---
// Moving from manual JSON decoding to using the generated API client
final lecturersListProvider = FutureProvider.autoDispose<List<admin.Lecturer>>((ref) async {
  final response = await ApiService().lecturers.lecturersGet();
  // Based on your YAML, the response contains a 'data' field which is a List<Lecturer>
  return response?.data ?? [];
});

class LecturersPage extends ConsumerStatefulWidget {
  const LecturersPage({super.key});

  @override
  ConsumerState<LecturersPage> createState() => _LecturersPageState();
}

class _LecturersPageState extends ConsumerState<LecturersPage> {
  int _currentPage = 1;
  final int _limit = 15; // Set to 15 to match your Laravel pagination

  void _onPageChanged(int newPage) {
    setState(() => _currentPage = newPage);
  }

  Future<void> _showAddLecturerDialog() async {
    final result = await showDialog(
      context: context,
      builder: (context) => const AddLecturerDialog(),
    );

    if (result == true) {
      ref.invalidate(lecturersListProvider);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Lecturer registered successfully"),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final lecturersAsync = ref.watch(lecturersListProvider);
    final bool isMobile = MediaQuery.of(context).size.width < 900;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: EdgeInsets.all(isMobile ? 16 : 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(isMobile),
            const SizedBox(height: 24),

            Expanded(
              child: lecturersAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, _) => _buildErrorState(err.toString()),
                data: (allLecturers) {
                  if (allLecturers.isEmpty) return _buildEmptyState();

                  final startIndex = (_currentPage - 1) * _limit;
                  final endIndex = (startIndex + _limit < allLecturers.length)
                      ? startIndex + _limit
                      : allLecturers.length;

                  final paginatedLecturers = allLecturers.sublist(
                    startIndex,
                    startIndex > allLecturers.length ? allLecturers.length : endIndex,
                  );

                  return Column(
                    children: [
                      Expanded(
                        child: isMobile
                            ? _buildMobileList(paginatedLecturers)
                            : _buildDataTable(paginatedLecturers),
                      ),
                      if (allLecturers.length > _limit)
                        _buildPagination(allLecturers.length, endIndex),
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

  Widget _buildHeader(bool isMobile) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Lecturers",
                style: TextStyle(
                  fontSize: isMobile ? 22 : 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text("Manage faculty members and departments", style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
        ElevatedButton.icon(
          onPressed: _showAddLecturerDialog,
          icon: const Icon(Icons.add),
          label: Text(isMobile ? "Add" : "Add Lecturer"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }

  // DESKTOP: Type-safe DataTable
  Widget _buildDataTable(List<admin.Lecturer> lecturers) {
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
            DataColumn(label: Text("Lecturer ID")),
            DataColumn(label: Text("Name")),
            DataColumn(label: Text("Department")),
            DataColumn(label: Text("Phone")),
            DataColumn(label: Text("Actions")),
          ],
          rows: lecturers.map((lecturer) {
            // Using generated model fields (camelCase)
            final String title = lecturer.title?.value ?? "";
            final String fullName = "$title ${lecturer.firstName ?? ''} ${lecturer.lastName ?? ''}".trim();

            return DataRow(
              cells: [
                DataCell(Text(lecturer.lecturerId ?? 'N/A', style: const TextStyle(fontWeight: FontWeight.bold))),
                DataCell(
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 14,
                        backgroundColor: Colors.blue.shade50,
                        child: Text(
                          lecturer.firstName != null ? lecturer.firstName![0].toUpperCase() : "?",
                          style: const TextStyle(fontSize: 12, color: Colors.blue),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(fullName),
                    ],
                  ),
                ),
                DataCell(Text(lecturer.department?.name ?? 'Unassigned')),
                DataCell(Text(lecturer.phone ?? 'N/A')),
                DataCell(
                  IconButton(icon: const Icon(Icons.more_vert, size: 20), onPressed: () {}),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  // MOBILE: Vertical List
  Widget _buildMobileList(List<admin.Lecturer> lecturers) {
    return ListView.builder(
      itemCount: lecturers.length,
      itemBuilder: (context, index) {
        final lecturer = lecturers[index];
        final fullName = "${lecturer.title?.value ?? ''} ${lecturer.firstName ?? ''} ${lecturer.lastName ?? ''}";

        return Card(
          elevation: 0,
          margin: const EdgeInsets.only(bottom: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.grey.shade200),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue.shade100,
              child: Text(lecturer.firstName != null ? lecturer.firstName![0].toUpperCase() : "?"),
            ),
            title: Text(fullName, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text("${lecturer.lecturerId}\n${lecturer.department?.name ?? 'No Dept'}"),
            isThreeLine: true,
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
        );
      },
    );
  }

  // --- HELPER STATES ---

  Widget _buildPagination(int total, int currentEnd) {
    final int totalPages = (total / _limit).ceil();
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text("Showing $currentEnd of $total"),
          const SizedBox(width: 16),
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: _currentPage > 1 ? () => _onPageChanged(_currentPage - 1) : null,
          ),
          Text("$_currentPage / $totalPages"),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: _currentPage < totalPages ? () => _onPageChanged(_currentPage + 1) : null,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.redAccent),
          const SizedBox(height: 16),
          const Text("Error loading data", style: TextStyle(fontWeight: FontWeight.bold)),
          Text(error, textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: () => ref.invalidate(lecturersListProvider), child: const Text("Retry")),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.people_outline, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text("No lecturers found", style: TextStyle(color: Colors.grey, fontSize: 18)),
        ],
      ),
    );
  }
}