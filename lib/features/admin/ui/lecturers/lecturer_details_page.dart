import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_api/api.dart' as admin;
import '../../providers/lecturers_provider.dart'; // Adjust path as needed
import '../../../../shared/widgets/error_view.dart'; // Reusing from the previous step

class LecturerDetailsPage extends ConsumerWidget {
  final String publicId;

  const LecturerDetailsPage({super.key, required this.publicId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Assuming you have a provider for a single lecturer
    final lecturerAsync = ref.watch(lecturerDetailProvider(publicId));
    final bool isMobile = MediaQuery.of(context).size.width < 900;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text("Lecturer Details"),
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.grey.shade100,
        iconTheme: const IconThemeData(color: Colors.black87),
        titleTextStyle: const TextStyle(color: Colors.black87, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      body: lecturerAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => ErrorView(
          error: error.toString(),
          onRetry: () => ref.invalidate(lecturerDetailProvider(publicId)),
        ),
        data: (response) {
          final lecturer = response?.data;
          
          if (lecturer == null) {
            return const Center(child: Text("Lecturer not found."));
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(isMobile ? 16 : 24),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1000),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProfileHeader(lecturer),
                    const SizedBox(height: 24),
                    isMobile
                        ? Column(
                            children: [
                              _buildProfessionalInfoCard(lecturer),
                              const SizedBox(height: 24),
                              _buildContactInfoCard(lecturer),
                            ],
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(flex: 3, child: _buildProfessionalInfoCard(lecturer)),
                              const SizedBox(width: 24),
                              Expanded(flex: 2, child: _buildContactInfoCard(lecturer)),
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

  // --- LOCAL WIDGETS ---
  // (You can extract these to `widgets/lecturer_info_cards.dart` if they get too large)

  Widget _buildProfileHeader(admin.Lecturer lecturer) {
    final title = lecturer.title?.value ?? "";
    final fullName = "$title ${lecturer.firstName ?? ''} ${lecturer.lastName ?? ''}".trim();

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
              lecturer.firstName != null && lecturer.firstName!.isNotEmpty 
                  ? lecturer.firstName![0].toUpperCase() 
                  : "?",
              style: TextStyle(fontSize: 32, color: Colors.blue.shade800),
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(fullName, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(
                  lecturer.department?.name ?? "No Department Assigned",
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfessionalInfoCard(admin.Lecturer lecturer) {
    return _buildCardBase(
      title: "Professional Information",
      children: [
        _buildInfoRow(Icons.badge_outlined, "Lecturer ID", lecturer.lecturerId ?? "N/A"),
        const SizedBox(height: 16),
        _buildInfoRow(Icons.account_balance_outlined, "Department", lecturer.department?.name ?? "N/A"),
        const SizedBox(height: 16),
        _buildInfoRow(Icons.work_outline, "Title", lecturer.title?.value ?? "N/A"),
      ],
    );
  }

  Widget _buildContactInfoCard(admin.Lecturer lecturer) {
    return _buildCardBase(
      title: "Contact Information",
      children: [
        _buildInfoRow(Icons.phone_outlined, "Phone Number", lecturer.phoneNumber ?? "N/A"),
        const SizedBox(height: 16),
        // Add email here if your API model supports it:
        // _buildInfoRow(Icons.email_outlined, "Email", lecturer.email ?? "N/A"),
      ],
    );
  }

  Widget _buildCardBase({required String title, required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const Divider(height: 32),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.grey.shade500),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
              const SizedBox(height: 4),
              Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ],
    );
  }
}