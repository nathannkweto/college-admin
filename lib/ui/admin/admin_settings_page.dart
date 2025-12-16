import 'package:flutter/material.dart';

class AdminSettingsPage extends StatefulWidget {
  const AdminSettingsPage({super.key});

  @override
  State<AdminSettingsPage> createState() => _AdminSettingsPageState();
}

class _AdminSettingsPageState extends State<AdminSettingsPage> {
  bool _registrationOpen = true;
  String _currentSession = "2024/2025";
  String _currentSemester = "Semester 1";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text("Settings", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView(
        children: [
          _buildHeader("Academic Session"),
          ListTile(
            tileColor: Colors.white,
            title: const Text("Current Academic Year"),
            subtitle: Text(_currentSession),
            trailing: const Icon(Icons.arrow_forward_ios, size: 14),
            onTap: () {
              // Logic to change year
            },
          ),
          const Divider(height: 1),
          ListTile(
            tileColor: Colors.white,
            title: const Text("Current Semester"),
            subtitle: Text(_currentSemester, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
            trailing: OutlinedButton(
              onPressed: () {
                // Logic to close semester
              },
              child: const Text("End Semester"),
            ),
          ),

          _buildHeader("System Controls"),
          SwitchListTile(
            tileColor: Colors.white,
            title: const Text("Allow Student Registration"),
            subtitle: const Text("If disabled, new students cannot be enrolled."),
            value: _registrationOpen,
            onChanged: (val) => setState(() => _registrationOpen = val),
          ),
          const Divider(height: 1),
          SwitchListTile(
            tileColor: Colors.white,
            title: const Text("Portal Maintenance Mode"),
            subtitle: const Text("Disable access for students and lecturers."),
            value: false,
            onChanged: (val) {},
          ),

          _buildHeader("Account"),
          ListTile(
            tileColor: Colors.white,
            leading: const Icon(Icons.lock_outline),
            title: const Text("Change Admin Password"),
            onTap: () {},
          ),

          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text("Version 1.0.0", style: TextStyle(color: Colors.grey[400], fontSize: 12), textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(title, style: TextStyle(color: Colors.blue[800], fontWeight: FontWeight.bold, fontSize: 13)),
    );
  }
}