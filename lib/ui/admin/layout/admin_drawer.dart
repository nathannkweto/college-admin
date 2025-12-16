import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_provider.dart';
import 'admin_branding.dart';

class AdminDrawer extends StatelessWidget {
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
  Widget build(BuildContext context) {
    // Check if we are in a mobile context (Drawer) or Desktop (Sidebar)
    // We can infer this: if the parent is a Drawer, width is constrained differently.
    // However, simpler is checking media query again or passing a flag.
    // Let's rely on MediaQuery for consistency.
    final isMobile = MediaQuery.of(context).size.width < 800;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      // On mobile, the drawer width is fixed by the parent Drawer widget usually,
      // but we set it here to be safe.
      width: isMobile ? 304 : (isCollapsed ? 80 : 250),
      decoration: BoxDecoration(
        color: Colors.white,
        border: isMobile
            ? null
            : Border(right: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Column(
        children: [
          // 1. BRANDING
          // On mobile, we always show full branding
          AdminBranding(isCollapsed: isMobile ? false : isCollapsed),

          // 2. TOGGLE BUTTON (Desktop Only)
          // We hide the collapse arrow on mobile because it's a slide-out drawer
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

          // 3. MENU ITEMS
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 12),
              children: [
                _buildNavItem(
                  context,
                  0,
                  "Dashboard",
                  Icons.dashboard,
                  isMobile,
                ),
                _buildNavItem(context, 1, "Students", Icons.people, isMobile),
                _buildNavItem(
                  context,
                  2,
                  "Lecturers",
                  Icons.co_present,
                  isMobile,
                ),
                _buildNavItem(
                  context,
                  3,
                  "Curriculum",
                  Icons.category,
                  isMobile,
                ),
                _buildNavItem(
                    context,
                    4,
                    "Results",
                    Icons.analytics_outlined,
                    isMobile
                ),
                _buildNavItem(
                    context,
                    5,
                    "Finances",
                    Icons.account_balance_wallet_outlined,
                    isMobile
                ),
              ],
            ),
          ),

          // 4. LOGOUT BUTTON
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildLogoutButton(context, isMobile),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    int index,
    String title,
    IconData icon,
    bool isMobile,
  ) {
    final isSelected = selectedIndex == index;
    final color = isSelected ? Colors.blue : Colors.grey.shade700;

    // Determine if we should show icon only (Collapsed Desktop)
    final showIconOnly = !isMobile && isCollapsed;

    if (showIconOnly) {
      return IconButton(
        icon: Icon(icon, color: color),
        tooltip: title,
        onPressed: () => onIndexChanged(index),
      );
    }

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: TextStyle(
          color: color,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      selectedTileColor: Colors.blue.shade50,
      onTap: () => onIndexChanged(index),
    );
  }

  Widget _buildLogoutButton(BuildContext context, bool isMobile) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final showIconOnly = !isMobile && isCollapsed;

    if (showIconOnly) {
      return IconButton(
        icon: const Icon(Icons.logout, color: Colors.red),
        tooltip: "Logout",
        onPressed: () => auth.logout(),
      );
    }

    return OutlinedButton.icon(
      icon: const Icon(Icons.logout, size: 18),
      label: const Text("Logout"),
      onPressed: () => auth.logout(),
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.red,
        side: const BorderSide(color: Colors.red),
      ),
    );
  }
}
