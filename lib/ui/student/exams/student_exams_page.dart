import 'package:flutter/material.dart';

class StudentExamsPage extends StatelessWidget {
  const StudentExamsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Academics", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const TabBar(
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.grey,
              isScrollable: true,
              tabs: [
                Tab(text: "Upcoming Exams"),
                Tab(text: "Results & Transcripts"),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: TabBarView(
                children: [
                  _buildUpcomingExams(),
                  _buildResultsTable(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingExams() {
    return ListView(
      children: const [
        ListTile(
          leading: Icon(Icons.event_note, color: Colors.orange),
          title: Text("Data Structures Final"),
          subtitle: Text("Dec 15, 2024 • 09:00 AM • Main Hall"),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.event_note, color: Colors.orange),
          title: Text("Web Development Project Defense"),
          subtitle: Text("Dec 18, 2024 • 02:00 PM • Lab 3"),
        ),
      ],
    );
  }

  Widget _buildResultsTable() {
    // This replicates the table style from the Admin view but read-only
    return SingleChildScrollView(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Semester 1 Results", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const Divider(),
              Table(
                columnWidths: const {0: FlexColumnWidth(2), 1: FlexColumnWidth(1), 2: FlexColumnWidth(1)},
                children: const [
                  TableRow(children: [
                    Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Text("Course", style: TextStyle(fontWeight: FontWeight.bold))),
                    Text("Grade", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("Points", style: TextStyle(fontWeight: FontWeight.bold)),
                  ]),
                  TableRow(children: [Text("Intro to Programming"), Text("A"), Text("4.0")]),
                  TableRow(children: [SizedBox(height: 8), SizedBox(), SizedBox()]), // Spacer
                  TableRow(children: [Text("Linear Algebra"), Text("B+"), Text("3.5")]),
                  TableRow(children: [SizedBox(height: 8), SizedBox(), SizedBox()]),
                  TableRow(children: [Text("Communication Skills"), Text("A"), Text("4.0")]),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}