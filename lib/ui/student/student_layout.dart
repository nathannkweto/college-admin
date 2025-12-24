import 'package:college_admin/ui/admin/results/results_page.dart';
import 'package:flutter/material.dart';
import 'layout/student_drawer.dart';
import 'dashboard/dashboard_page.dart';
import 'curriculum/student_curriculum_page.dart';
import 'fees/fees_page.dart';
import 'exams/student_exams_page.dart';

class StudentLayout extends StatefulWidget {
  const StudentLayout({super.key});

  @override
  State<StudentLayout> createState() => _StudentLayoutState();
}

class _StudentLayoutState extends State<StudentLayout> {
  // Navigation State
  int _selectedIndex = 0;
  bool _isSidebarCollapsed = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // 1. Detect Screen Size
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 800;

    // 2. Define Content Logic
    Widget content;
    switch (_selectedIndex) {
      case 0:
        content = const StudentDashboard();
        break;
      case 1:
        content = const StudentExamsPage();
        break;
      case 2:
        content = const StudentCurriculumPage();
        break;
      case 3:
        content = const FeesPage();
        break;
      default:
        content = const StudentDashboard();
    }

    // 3. Define the Navigation Sidebar
    // We wrap it in a function so we can reuse it for both Mobile (Drawer) and Desktop (Sidebar)
    Widget buildSidebar() {
      return StudentDrawer(
        selectedIndex: _selectedIndex,
        isCollapsed: isMobile ? false : _isSidebarCollapsed, // Always expanded on mobile drawer
        onIndexChanged: (index) {
          setState(() => _selectedIndex = index);
          // If on mobile, close the drawer after selection
          if (isMobile) {
            Navigator.pop(context);
          }
        },
        onToggleCollapse: () {
          setState(() => _isSidebarCollapsed = !_isSidebarCollapsed);
        },
      );
    }

    // 4. Build the Responsive Structure
    return Scaffold(
      key: _scaffoldKey,

      // --- MOBILE APP BAR ---
      // Only show this on small screens
      appBar: isMobile
          ? AppBar(
        title: const Text("MATEM College"),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: Colors.grey.shade200, height: 1),
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
      )
          : null,

      // --- MOBILE DRAWER ---
      // Only used when isMobile is true
      drawer: isMobile ? Drawer(child: buildSidebar()) : null,

      // --- DESKTOP BODY ---
      body: Row(
        children: [
          // Sidebar (Visible only on Desktop)
          if (!isMobile)
            buildSidebar(),

          // Main Content Area
          Expanded(
            child: Container(
              color: Colors.grey.shade50, // Light background for content
              child: content,
            ),
          ),
        ],
      ),
    );
  }
}