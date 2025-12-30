import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Make sure this points to your shared auth provider
import 'package:college_admin/features/auth/providers/auth_provider.dart';
import 'admin_branding.dart';

class AdminDrawer extends ConsumerWidget {
  final int selectedIndex;
  final bool isCollapsed;
  final Function(int) onIndexChanged;
  final VoidCallback onToggleCollapse;

  const AdminDrawer({
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
          AdminBranding(isCollapsed: isMobile ? false : isCollapsed),

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
                _buildNavItem(0, "Dashboard", Icons.dashboard, isMobile),
                _buildNavItem(1, "Students", Icons.people, isMobile),
                _buildNavItem(2, "Lecturers", Icons.co_present, isMobile),
                _buildNavItem(3, "Curriculum", Icons.category, isMobile),
                _buildNavItem(4, "Results", Icons.sticky_note_2, isMobile),
                _buildNavItem(
                  5,
                  "Finances",
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
    final color = isSelected ? Colors.blue : Colors.grey.shade700;
    final bool showFullMenu = isMobile || !isCollapsed;

    return InkWell(
      onTap: () => onIndexChanged(index),
      child: Container(
        height: 48,
        margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade50 : Colors.transparent,
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
