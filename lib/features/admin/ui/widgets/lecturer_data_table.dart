import 'package:flutter/material.dart';
import 'package:admin_api/api.dart' as admin;

class LecturerDataTable extends StatelessWidget {
  final List<admin.Lecturer> lecturers;
  final Function(String) onRowTap;

  const LecturerDataTable({
    super.key,
    required this.lecturers,
    required this.onRowTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: SingleChildScrollView(
        child: DataTable(
          showCheckboxColumn: false, // Hides checkbox, keeps row clickable
          headingRowColor: WidgetStateProperty.all(Colors.grey.shade50),
          columns: const [
            DataColumn(label: Text("Lecturer ID")),
            DataColumn(label: Text("Name")),
            DataColumn(label: Text("Department")),
            DataColumn(label: Text("Phone")),
            DataColumn(label: Text("Actions")),
          ],
          rows: lecturers.map((lecturer) {
            final String title = lecturer.title?.value ?? "";
            final String fullName = "$title ${lecturer.firstName ?? ''} ${lecturer.lastName ?? ''}".trim();
            // Assuming your API model has a publicId. If it uses lecturerId for fetching details, swap this.
            final String targetId = lecturer.publicId ?? lecturer.lecturerId ?? '';

            return DataRow(
              onSelectChanged: (_) {
                if (targetId.isNotEmpty) onRowTap(targetId);
              },
              cells: [
                DataCell(Text(lecturer.lecturerId ?? 'N/A', style: const TextStyle(fontWeight: FontWeight.bold))),
                DataCell(
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 14,
                        backgroundColor: Colors.blue.shade50,
                        child: Text(
                          lecturer.firstName != null && lecturer.firstName!.isNotEmpty 
                              ? lecturer.firstName![0].toUpperCase() 
                              : "?",
                          style: const TextStyle(fontSize: 12, color: Colors.blue),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(fullName),
                    ],
                  ),
                ),
                DataCell(Text(lecturer.department?.name ?? 'Unassigned')),
                DataCell(Text(lecturer.phoneNumber ?? 'N/A')),
                DataCell(
                  IconButton(
                    icon: const Icon(Icons.chevron_right, size: 20),
                    onPressed: () {
                      if (targetId.isNotEmpty) onRowTap(targetId);
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
}