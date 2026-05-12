import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_api/api.dart' as admin;
import '../../providers/students_provider.dart';
import '../../../../shared/widgets/error_view.dart';
import '../widgets/student_info_cards.dart';

class StudentDetailsPage extends ConsumerWidget {
  final String publicId;

  const StudentDetailsPage({super.key, required this.publicId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studentAsync = ref.watch(studentDetailProvider(publicId));
    final bool isMobile = MediaQuery.of(context).size.width < 900;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text("Student Details"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(height: 1, color: Colors.grey.shade200),
        ),
      ),
      body: studentAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => ErrorView(
          error: error.toString(), 
          onRetry: () => ref.invalidate(studentDetailProvider(publicId))
        ),
        data: (response) {
          final student = response?.data;
          if (student == null) return const Center(child: Text("Student not found."));

          return SingleChildScrollView(
            padding: EdgeInsets.all(isMobile ? 16 : 24),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1000),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- Inline Profile Header ---
                    _buildHeader(student),
                    const SizedBox(height: 24),
                    
                    // --- Responsive Layout ---
                    if (isMobile) ...[
                      AcademicInfoCard(student: student),
                      const SizedBox(height: 16),
                      PersonalInfoCard(student: student),
                    ] else
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 3, child: AcademicInfoCard(student: student)),
                          const SizedBox(width: 20),
                          Expanded(flex: 2, child: PersonalInfoCard(student: student)),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(admin.Student student) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.blue.shade100,
            child: Text(
              student.firstName?[0].toUpperCase() ?? "?",
              style: TextStyle(fontSize: 32, color: Colors.blue.shade800, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${student.firstName} ${student.lastName}",
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  student.email ?? "No email provided",
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                ),
                const SizedBox(height: 8),
                _StatusChip(status: student.status?.value ?? "Active"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Simple status chip for the header
class _StatusChip extends StatelessWidget {
  final String status;
  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: status.toLowerCase() == 'active' ? Colors.green.shade50 : Colors.orange.shade50,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: status.toLowerCase() == 'active' ? Colors.green.shade200 : Colors.orange.shade200),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          color: status.toLowerCase() == 'active' ? Colors.green.shade700 : Colors.orange.shade700,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}