import 'package:flutter/material.dart';

class LecturerGradingPage extends StatelessWidget {
  const LecturerGradingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Grading & Results", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),

          // Course Selector
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: "Select Course to Grade",
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
            ),
            items: const [
              DropdownMenuItem(value: "CS201", child: Text("CS201 - Data Structures")),
              DropdownMenuItem(value: "CS101", child: Text("CS101 - Intro to Programming")),
            ],
            onChanged: (val) {},
            value: "CS201",
          ),
          const SizedBox(height: 24),

          // Student List
          Expanded(
            child: Card(
              child: ListView.separated(
                itemCount: 8, // Increased count for demo
                separatorBuilder: (ctx, i) => const Divider(height: 1),
                itemBuilder: (ctx, i) {
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue.shade50,
                      child: Text("${i + 1}", style: TextStyle(color: Colors.blue.shade800)),
                    ),
                    title: Text("Student Name ${i + 1}", style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text("ID: 2024-00${i + 1}"),
                    trailing: SizedBox(
                      width: 100,
                      child: TextFormField(
                        initialValue: "", // Empty by default
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: "--",
                          labelText: "Score",
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 24),

          // --- ACTION BUTTONS ---
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min, // Pack items to the right
              children: [
                // 1. SAVE DRAFT BUTTON
                OutlinedButton.icon(
                  onPressed: () {
                    // Logic to save locally/draft
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Draft saved successfully"))
                    );
                  },
                  icon: const Icon(Icons.save_outlined),
                  label: const Text("Save Draft"),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    side: BorderSide(color: Colors.grey.shade400),
                    foregroundColor: Colors.grey.shade700,
                  ),
                ),

                const SizedBox(width: 16),

                // 2. PUBLISH BUTTON
                ElevatedButton.icon(
                  onPressed: () {
                    // Logic to push to live database
                    _showPublishConfirmation(context);
                  },
                  icon: const Icon(Icons.cloud_upload),
                  label: const Text("Publish Results"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade600,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    elevation: 2,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // Helper dialog to confirm publishing (Safety Check)
  void _showPublishConfirmation(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Publish Results?"),
          content: const Text("This will make grades visible to all students enrolled in CS201. Are you sure?"),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text("Cancel")
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Results Published!"), backgroundColor: Colors.orange)
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: const Text("Confirm Publish"),
            ),
          ],
        )
    );
  }
}