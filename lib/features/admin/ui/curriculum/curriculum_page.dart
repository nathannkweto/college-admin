import 'package:flutter/material.dart';
import 'curriculum_tabs.dart';

class CurriculumPage extends StatefulWidget {
  const CurriculumPage({super.key});

  @override
  State<CurriculumPage> createState() => _CurriculumPageState();
}

class _CurriculumPageState extends State<CurriculumPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Breakpoints for better layout control
    final double width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 600;
    final bool isTablet = width >= 600 && width < 1024;

    return Scaffold(
      backgroundColor: Colors.grey[50], // Standardize background
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : (isTablet ? 24 : 32),
            vertical: isMobile ? 16 : 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- HEADER ---
              _buildHeader(isMobile),

              const SizedBox(height: 32),

              // --- SEAMLESS TAB BAR ---
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: TabBar(
                  controller: _tabController,
                  labelColor: Colors.blue.shade700,
                  unselectedLabelColor: Colors.blueGrey.shade300,
                  indicatorSize: TabBarIndicatorSize.tab, // Changed to tab for better touch target
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.blue.shade50.withOpacity(0.5),
                  ),
                  isScrollable: isMobile, // Allows horizontal swipe on small screens
                  dividerColor: Colors.transparent,
                  tabAlignment: isMobile ? TabAlignment.start : TabAlignment.fill,
                  tabs: [
                    _buildTab("Semester", Icons.calendar_today_rounded, isMobile),
                    _buildTab("Programs", Icons.school_rounded, isMobile),
                    _buildTab("Departments", Icons.grid_view_rounded, isMobile),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // --- TAB CONTENT ---
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    SemestersExamsTab(),
                    ProgramsTab(), // Ensure these are responsive too!
                    DepartmentsTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Curriculum",
          style: TextStyle(
            fontSize: isMobile ? 24 : 32,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "Manage departments, courses, and academic calendar.",
          style: TextStyle(
            color: Colors.blueGrey.shade400,
            fontSize: isMobile ? 13 : 15,
          ),
        ),
      ],
    );
  }

  Widget _buildTab(String label, IconData icon, bool isMobile) {
    return Tab(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: isMobile ? 16 : 18),
            const SizedBox(width: 8),
            Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: isMobile ? 13 : 14,
                )
            ),
          ],
        ),
      ),
    );
  }
}