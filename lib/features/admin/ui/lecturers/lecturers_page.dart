import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_api/api.dart' as admin;
import 'package:college_admin/core/services/api_service.dart';

import '../../../../shared/widgets/error_view.dart'; // Shared widget
import 'add_lecturer_dialog.dart';
import 'lecturer_details_page.dart';
import '../widgets/lecturer_data_table.dart';
import '../widgets/lecturer_mobile_list.dart';

// --- PROVIDER ---
final lecturersListProvider = FutureProvider.autoDispose<List<admin.Lecturer>>((ref) async {
  final response = await ApiService().lecturers.lecturersGet();
  return response?.data ?? [];
});

class LecturersPage extends ConsumerStatefulWidget {
  const LecturersPage({super.key});

  @override
  ConsumerState<LecturersPage> createState() => _LecturersPageState();
}

class _LecturersPageState extends ConsumerState<LecturersPage> {
  int _currentPage = 1;
  final int _limit = 15; 

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

  void _navigateToDetails(String publicId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LecturerDetailsPage(publicId: publicId),
      ),
    );
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
                error: (err, _) => ErrorView(
                  error: err.toString(),
                  onRetry: () => ref.invalidate(lecturersListProvider),
                ),
                data: (allLecturers) {
                  if (allLecturers.isEmpty) return _buildEmptyState();

                  // Pagination Logic
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
                            ? LecturerMobileList(
                                lecturers: paginatedLecturers,
                                onRowTap: _navigateToDetails,
                              )
                            : LecturerDataTable(
                                lecturers: paginatedLecturers,
                                onRowTap: _navigateToDetails,
                              ),
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
                style: TextStyle(fontSize: isMobile ? 22 : 28, fontWeight: FontWeight.bold),
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