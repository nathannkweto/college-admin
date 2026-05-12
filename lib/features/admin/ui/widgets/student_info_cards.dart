import 'package:flutter/material.dart';
import 'package:admin_api/api.dart' as admin;

class AcademicInfoCard extends StatelessWidget {
  final admin.Student student;
  const AcademicInfoCard({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return _BaseInfoCard(
      title: "Academic Information",
      children: [
        _InfoRow(icon: Icons.badge_outlined, label: "Student ID", value: student.studentId ?? "N/A"),
        const SizedBox(height: 16),
        _InfoRow(
          icon: Icons.school_outlined, 
          label: "Program", 
          value: student.program?.name ?? "N/A", 
          subtitle: student.program?.code != null ? "Code: ${student.program!.code}" : null
        ),
        const SizedBox(height: 16),
        _InfoRow(
          icon: Icons.format_list_numbered, 
          label: "Current Semester Sequence", 
          value: student.currentSemesterSequence?.toString() ?? "N/A"
        ),
      ],
    );
  }
}

class PersonalInfoCard extends StatelessWidget {
  final admin.Student student;
  const PersonalInfoCard({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return _BaseInfoCard(
      title: "Personal Information",
      children: [
        _InfoRow(icon: Icons.credit_card, label: "National ID / NRC", value: student.nationalId ?? "N/A"),
        const SizedBox(height: 16),
        _InfoRow(
          icon: Icons.person_outline, 
          label: "Gender", 
          value: _formatGender(student.gender?.toString())
        ),
        const SizedBox(height: 16),
        _InfoRow(icon: Icons.phone_outlined, label: "Phone Number", value: student.phone ?? "N/A"),
      ],
    );
  }

  String _formatGender(String? raw) {
    if (raw == null) return "N/A";
    if (raw.contains('M')) return "Male";
    if (raw.contains('F')) return "Female";
    return raw;
  }
}

// --- Helpers remains mostly the same, just slightly tightened for spacing ---

class _BaseInfoCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _BaseInfoCard({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String? subtitle;

  const _InfoRow({required this.icon, required this.label, required this.value, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(8)),
          child: Icon(icon, size: 18, color: Colors.blueGrey.shade400),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(fontSize: 12, color: Colors.grey.shade500, fontWeight: FontWeight.w500)),
              const SizedBox(height: 2),
              Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black87)),
              if (subtitle != null) ...[
                const SizedBox(height: 2),
                Text(subtitle!, style: TextStyle(fontSize: 12, color: Colors.grey.shade400)),
              ],
            ],
          ),
        ),
      ],
    );
  }
}