import 'package:flutter/material.dart';

class ResponsiveShell extends StatelessWidget {
  final String title;
  final List<Widget>? actions;
  final int currentIndex;
  final ValueChanged<int> onTabChanged;
  final List<NavigationDestination> destinations;
  final Widget child;

  const ResponsiveShell({
    super.key,
    required this.title,
    required this.currentIndex,
    required this.onTabChanged,
    required this.destinations,
    required this.child,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWeb = constraints.maxWidth > 800;
        final colorScheme = Theme.of(context).colorScheme;

        if (isWeb) {
          // Check if we should extend (expand) the side bar
          final isExtended = constraints.maxWidth > 1100;

          return Scaffold(
            backgroundColor: colorScheme.surfaceContainerLowest,
            body: Row(
              children: [
                NavigationRail(
                  backgroundColor: colorScheme.surface,
                  selectedIndex: currentIndex,
                  onDestinationSelected: onTabChanged,

                  // --- FIX IS HERE ---
                  // If extended, type MUST be 'none' (text shows automatically).
                  // If compact, type is 'all' (text shows under icons).
                  extended: isExtended,
                  labelType: isExtended
                      ? NavigationRailLabelType.none
                      : NavigationRailLabelType.all,
                  // -------------------

                  leading: Padding(
                    padding: const EdgeInsets.only(bottom: 24.0, top: 16),
                    child: Icon(Icons.school, size: 40, color: colorScheme.primary),
                  ),
                  destinations: destinations.map((d) {
                    return NavigationRailDestination(
                      icon: d.icon,
                      selectedIcon: d.selectedIcon,
                      label: Text(d.label),
                    );
                  }).toList(),
                ),

                const VerticalDivider(thickness: 1, width: 1),

                Expanded(
                  child: Column(
                    children: [
                      AppBar(
                        title: Text(title),
                        actions: actions,
                        backgroundColor: Colors.transparent,
                        scrolledUnderElevation: 0,
                        elevation: 0,
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 1000),
                            child: child,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return Scaffold(
            backgroundColor: colorScheme.surfaceContainerLowest,
            appBar: AppBar(title: Text(title), actions: actions),
            body: child,
            bottomNavigationBar: NavigationBar(
              selectedIndex: currentIndex,
              onDestinationSelected: onTabChanged,
              destinations: destinations,
            ),
          );
        }
      },
    );
  }
}