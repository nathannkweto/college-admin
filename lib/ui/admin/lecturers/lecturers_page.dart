import 'package:flutter/material.dart';
import '../../../models/lecturer.dart';
import 'add_lecturer_dialog.dart';

class LecturersPage extends StatefulWidget {
  const LecturersPage({super.key});

  @override
  State<LecturersPage> createState() => _LecturersPageState();
}

class _LecturersPageState extends State<LecturersPage> {
  bool _isLoading = false;
  List<Lecturer> _lecturers = []; // Empty for now

  // Opens the dialog defined in Step 2
  Future<void> _showAddLecturerDialog() async {
    final result = await showDialog(
      context: context,
      builder: (context) => const AddLecturerDialog(),
    );

    if (result == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lecturer registered successfully"), backgroundColor: Colors.green),
      );
      // _fetchLecturers(); // Uncomment when GET endpoint is ready
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- HEADER ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Lecturers", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text("Manage faculty members", style: TextStyle(color: Colors.grey)),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: _showAddLecturerDialog,
                  icon: const Icon(Icons.add),
                  label: const Text("Register Lecturer"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // --- EMPTY STATE (Until GET spec is provided) ---
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person_pin_outlined, size: 64, color: Colors.grey.shade300),
                      const SizedBox(height: 16),
                      Text("Lecturer list coming soon...", style: TextStyle(color: Colors.grey[600], fontSize: 18)),
                      const SizedBox(height: 8),
                      const Text("Use the button above to register a new lecturer.", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}