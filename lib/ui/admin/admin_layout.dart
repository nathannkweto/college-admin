import 'package:college_admin/ui/admin/results/results_page.dart';
import 'package:flutter/material.dart';
import 'layout/admin_drawer.dart';
import 'dashboard/dashboard_page.dart';
import 'students/students_page.dart';
import 'lecturers/lecturers_page.dart';
import 'curriculum/curriculum_page.dart';
import 'finance/finance_page.dart';

class AdminLayout extends StatefulWidget {
  const AdminLayout({super.key});

  @override
  State<AdminLayout> createState() => _AdminLayoutState();
}

class _AdminLayoutState extends State<AdminLayout> {
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
        content = const DashboardPage();
        break;
      case 1:
        content = const StudentsPage();
        break;
      case 2:
        content = const LecturersPage();
        break;
      case 3:
        content = const CurriculumPage();
        break;
      case 4:
        content = const ResultsPage();
        break;
      case 5:
        content = const FinancePage();
        break;
      default:
        content = const DashboardPage();
    }

    // 3. Define the Navigation Sidebar
    // We wrap it in a function so we can reuse it for both Mobile (Drawer) and Desktop (Sidebar)
    Widget buildSidebar() {
      return AdminDrawer(
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
        title: const Text("College Admin"),
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