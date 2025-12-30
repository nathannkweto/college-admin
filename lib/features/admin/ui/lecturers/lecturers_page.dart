import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:college_admin/core/services/api_service.dart';
import 'add_lecturer_dialog.dart';

// --- PROVIDER ---

final lecturersListProvider = FutureProvider.autoDispose<List<dynamic>>((
  ref,
) async {
  final response = await ApiService().lecturers.lecturersGetWithHttpInfo();

  if (response.statusCode == 200) {
    final decoded = jsonDecode(response.body);
    if (decoded is Map<String, dynamic> && decoded.containsKey('data')) {
      return decoded['data'] as List<dynamic>;
    } else if (decoded is List) {
      return decoded;
    }
  }
  return [];
});

// --- WIDGET ---

class LecturersPage extends ConsumerStatefulWidget {
  const LecturersPage({super.key});

  @override
  ConsumerState<LecturersPage> createState() => _LecturersPageState();
}

class _LecturersPageState extends ConsumerState<LecturersPage> {
  int _currentPage = 1;
  final int _limit = 20;

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
    // Breakpoint for mobile vs desktop
    final bool isMobile = MediaQuery.of(context).size.width < 800;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: EdgeInsets.all(isMobile ? 16 : 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- HEADER ---
            _buildHeader(isMobile),
            const SizedBox(height: 24),

            // --- CONTENT AREA ---
            Expanded(
              child: lecturersAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => _buildErrorState(err.toString()),
                data: (allLecturers) {
                  if (allLecturers.isEmpty) return _buildEmptyState();

                  final startIndex = (_currentPage - 1) * _limit;
                  final endIndex = (startIndex + _limit < allLecturers.length)
                      ? startIndex + _limit
                      : allLecturers.length;

                  final paginatedLecturers = allLecturers.sublist(
                    startIndex,
                    startIndex > allLecturers.length
                        ? allLecturers.length
                        : endIndex,
                  );

                  return Column(
                    children: [
                      Expanded(
                        // Switch UI based on screen width
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
              const Text(
                "Manage faculty members",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
        isMobile
            ? FloatingActionButton.small(
                onPressed: _showAddLecturerDialog,
                backgroundColor: Colors.blue,
                child: const Icon(Icons.add, color: Colors.white),
              )
            : ElevatedButton.icon(
                onPressed: _showAddLecturerDialog,
                icon: const Icon(Icons.add),
                label: const Text("Add Lecturer"),
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

  // DESKTOP: Traditional Data Table
  Widget _buildDataTable(List<dynamic> lecturers) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: SingleChildScrollView(
        child: DataTable(
          headingRowColor: MaterialStateProperty.all(Colors.grey.shade50),
          columns: const [
            DataColumn(label: Text("Staff ID")),
            DataColumn(label: Text("Name")),
            DataColumn(label: Text("Qualification")),
            DataColumn(label: Text("Actions")),
          ],
          rows: lecturers.map((lecturer) {
            final fullName =
                "${lecturer['first_name'] ?? ''} ${lecturer['last_name'] ?? ''}";
            return DataRow(
              cells: [
                DataCell(Text(lecturer['staff_id'] ?? 'N/A')),
                DataCell(
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 12,
                        child: Text(fullName[0].toUpperCase()),
                      ),
                      const SizedBox(width: 8),
                      Text(fullName),
                    ],
                  ),
                ),
                DataCell(Text(lecturer['qualification'] ?? 'N/A')),
                DataCell(
                  IconButton(
                    icon: const Icon(Icons.edit, size: 20),
                    onPressed: () {},
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  // MOBILE: Vertical Card List
  Widget _buildMobileList(List<dynamic> lecturers) {
    return ListView.builder(
      itemCount: lecturers.length,
      itemBuilder: (context, index) {
        final lecturer = lecturers[index];
        final fullName =
            "${lecturer['first_name'] ?? ''} ${lecturer['last_name'] ?? ''}";

        return Card(
          elevation: 0,
          margin: const EdgeInsets.only(bottom: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: Colors.grey.shade200),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            leading: CircleAvatar(child: Text(fullName[0].toUpperCase())),
            title: Text(
              fullName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "${lecturer['lecturer_id'] ?? 'N/A'}\n${lecturer['email'] ?? ''}",
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              /* Detail view */
            },
          ),
        );
      },
    );
  }

  Widget _buildPagination(int total, int currentEnd) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: _currentPage > 1
                ? () => _onPageChanged(_currentPage - 1)
                : null,
          ),
          Text("Page $_currentPage of ${(total / _limit).ceil()}"),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: currentEnd < total
                ? () => _onPageChanged(_currentPage + 1)
                : null,
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
          Text(
            "Error loading lecturers",
            style: TextStyle(color: Colors.grey[800]),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => ref.invalidate(lecturersListProvider),
            child: const Text("Retry"),
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
          Icon(Icons.people_outline, size: 64, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text(
            "No lecturers found",
            style: TextStyle(color: Colors.grey[600], fontSize: 18),
          ),
        ],
      ),
    );
  }
}
