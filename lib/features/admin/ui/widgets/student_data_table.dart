import 'package:flutter/material.dart';
import 'package:admin_api/api.dart' as admin;
import '../../../../shared/widgets/status_badge.dart';

class StudentDataTable extends StatelessWidget {
  final List<admin.Student> students;
  final Function(String) onRowTap;

  const StudentDataTable({super.key, required this.students, required this.onRowTap});

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
          showCheckboxColumn: false,
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
            final genderStr = student.gender?.toString().split('.').last ?? '-';
            final statusStr = student.status?.toString().split('.').last ?? '-';

            return DataRow(
              onSelectChanged: (_) {
                if (student.publicId != null) onRowTap(student.publicId!);
              },
              cells: [
                DataCell(Text(student.studentId ?? "N/A", style: const TextStyle(fontWeight: FontWeight.bold))),
                DataCell(Row(
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.blue.shade100,
                      child: Text(fullName.isNotEmpty ? fullName[0].toUpperCase() : "?", style: const TextStyle(fontSize: 12)),
                    ),
                    const SizedBox(width: 8),
                    Text(fullName),
                  ],
                )),
                DataCell(Text(genderStr)),
                DataCell(Text(student.program?.name ?? "N/A")),
                DataCell(StatusBadge(status: statusStr, small: true)),
                DataCell(IconButton(
                  icon: const Icon(Icons.edit_outlined, size: 20),
                  onPressed: () {
                    if (student.publicId != null) onRowTap(student.publicId!);
                  },
                )),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}

class StudentMobileList extends StatelessWidget {
  final List<admin.Student> students;
  final Function(String) onRowTap;

  const StudentMobileList({required this.students, required this.onRowTap});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: students.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final student = students[index];
        final fullName = "${student.firstName} ${student.lastName}";
        
        return Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.grey.shade200),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            leading: CircleAvatar(
              backgroundColor: Colors.blue.shade50,
              child: Text(fullName.isNotEmpty ? fullName[0].toUpperCase() : "?"),
            ),
            title: Text(fullName, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("ID: ${student.studentId}"),
                Text(student.program?.name ?? "No Program", style: const TextStyle(fontSize: 12)),
              ],
            ),
            trailing: const Icon(Icons.chevron_right, color: Colors.grey),
            onTap: () {
              if (student.publicId != null) onRowTap(student.publicId!);
            },
          ),
        );
      },
    );
  }
}
