import 'package:flutter/material.dart';
import 'package:admin_api/api.dart' as admin;

class LecturerMobileList extends StatelessWidget {
  final List<admin.Lecturer> lecturers;
  final Function(String) onRowTap;

  const LecturerMobileList({
    super.key,
    required this.lecturers,
    required this.onRowTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: lecturers.length,
      itemBuilder: (context, index) {
        final lecturer = lecturers[index];
        final fullName = "${lecturer.title?.value ?? ''} ${lecturer.firstName ?? ''} ${lecturer.lastName ?? ''}".trim();
        final String targetId = lecturer.publicId ?? lecturer.lecturerId ?? '';

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
              child: Text(
                lecturer.firstName != null && lecturer.firstName!.isNotEmpty 
                    ? lecturer.firstName![0].toUpperCase() 
                    : "?"
              ),
            ),
            title: Text(fullName, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text("${lecturer.lecturerId}\n${lecturer.department?.name ?? 'No Dept'}"),
            isThreeLine: true,
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              if (targetId.isNotEmpty) onRowTap(targetId);
            },
          ),
        );
      },
    );
  }
}