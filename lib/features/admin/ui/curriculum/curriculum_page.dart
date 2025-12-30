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
    final bool isMobile = MediaQuery.of(context).size.width < 800;

    return Scaffold(
      backgroundColor: Colors
          .transparent, // Background should be handled by a parent or Scaffold
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 16 : 32,
          vertical: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- HEADER ---
            Text(
              "Curriculum",
              style: TextStyle(
                fontSize: isMobile ? 24 : 32,
                fontWeight:
                    FontWeight.w800, // Heavier weight for a clean modern look
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
            const SizedBox(height: 32),

            // --- SEAMLESS TAB BAR ---
            // Removed the solid border container, using a soft background instead
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey.shade100.withOpacity(
                  0.5,
                ), // Very faint background
                borderRadius: BorderRadius.circular(12),
              ),
              child: TabBar(
                controller: _tabController,
                labelColor: Colors.blue.shade700,
                unselectedLabelColor: Colors.blueGrey.shade300,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(width: 3, color: Colors.blue.shade700),
                  insets: const EdgeInsets.symmetric(horizontal: 16),
                ),
                isScrollable: isMobile,
                dividerColor:
                    Colors.transparent, // Removes the solid line underneath
                overlayColor: MaterialStateProperty.all(
                  Colors.transparent,
                ), // Cleaner tap effect
                tabs: [
                  _buildTab("Semester", Icons.calendar_today_rounded),
                  _buildTab("Programs", Icons.school_rounded),
                  _buildTab("Deptartments", Icons.grid_view_rounded),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // --- TAB CONTENT ---
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  SemestersExamsTab(),
                  ProgramsTab(),
                  DepartmentsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String label, IconData icon) {
    return Tab(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

// Seamless Placeholder for unfinished tabs
class _PlaceholderTab extends StatelessWidget {
  final String title;
  final IconData icon;
  const _PlaceholderTab({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: Colors.grey.shade200),
          const SizedBox(height: 16),
          Text(
            "$title Management coming soon",
            style: TextStyle(
              color: Colors.grey.shade400,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
