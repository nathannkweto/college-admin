import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Make sure this points to your shared auth provider
import 'package:college_admin/features/auth/providers/auth_provider.dart';
import 'student_branding.dart';

class StudentDrawer extends ConsumerWidget {
  final int selectedIndex;
  final bool isCollapsed;
  final Function(int) onIndexChanged;
  final VoidCallback onToggleCollapse;

  const StudentDrawer({
    super.key,
    required this.selectedIndex,
    required this.isCollapsed,
    required this.onIndexChanged,
    required this.onToggleCollapse,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    final double currentWidth = isMobile ? 304 : (isCollapsed ? 80 : 250);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: currentWidth,
      decoration: BoxDecoration(
        color: Colors.white,
        border: isMobile
            ? null
            : Border(right: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Column(
        children: [
          StudentBranding(isCollapsed: isMobile ? false : isCollapsed),

          if (!isMobile) ...[
            Align(
              alignment: isCollapsed ? Alignment.center : Alignment.centerRight,
              child: IconButton(
                icon: Icon(
                  isCollapsed ? Icons.chevron_right : Icons.chevron_left,
                ),
                onPressed: onToggleCollapse,
                color: Colors.grey,
              ),
            ),
            const Divider(height: 1),
          ],

          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 12),
              // This prevents horizontal overflow during the width animation
              physics: const ClampingScrollPhysics(),
              children: [
                _buildNavItem(0, "Home", Icons.home, isMobile),
                _buildNavItem(1, "Exams", Icons.school_outlined, isMobile),
                _buildNavItem(
                  2,
                  "Curriculum",
                  Icons.chrome_reader_mode_outlined,
                  isMobile,
                ),
                _buildNavItem(
                  3,
                  "Fees",
                  Icons.account_balance_wallet_outlined,
                  isMobile,
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildLogoutButton(ref, isMobile),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, String title, IconData icon, bool isMobile) {
    final isSelected = selectedIndex == index;
    final color = isSelected ? Colors.green : Colors.grey.shade700;
    final bool showFullMenu = isMobile || !isCollapsed;

    return InkWell(
      onTap: () => onIndexChanged(index),
      child: Container(
        height: 48,
        margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green.shade50 : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: isCollapsed && !isMobile
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            const SizedBox(width: 12),
            Icon(icon, color: color, size: 22),
            // We use a conditional and Flexible to prevent overflow
            if (showFullMenu) ...[
              const SizedBox(width: 12),
              Flexible(
                child: Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton(WidgetRef ref, bool isMobile) {
    final bool showFullMenu = isMobile || !isCollapsed;

    return OutlinedButton(
      // Access the provider notifier to call methods
      onPressed: () => ref.read(authProvider.notifier).logout(),
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.red,
        side: BorderSide(color: showFullMenu ? Colors.red : Colors.transparent),
        padding: showFullMenu
            ? const EdgeInsets.symmetric(horizontal: 16, vertical: 12)
            : EdgeInsets.zero,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.logout, size: 18),
          if (showFullMenu) ...[
            const SizedBox(width: 8),
            const Flexible(
              child: Text("Logout", overflow: TextOverflow.ellipsis),
            ),
          ],
        ],
      ),
    );
  }
}
