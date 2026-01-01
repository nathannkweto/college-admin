import 'package:flutter/material.dart';

class AdminBranding extends StatelessWidget {
  final bool isCollapsed;

  const AdminBranding({super.key, this.isCollapsed = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Padding logic remains the same
    final EdgeInsets padding = isCollapsed
        ? const EdgeInsets.symmetric(vertical: 24)
        : const EdgeInsets.symmetric(vertical: 24, horizontal: 24);

    return Container(
      width: double.infinity,
      padding: padding,
      child: isCollapsed
          ? Center(child: _LogoIcon())
          : Row(
              // Removed SingleChildScrollView
              mainAxisSize: MainAxisSize.min,
              children: [
                _LogoIcon(),
                const SizedBox(width: 12),
                // Expanded forces the Column to take only the *remaining* space
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "MATEM COLLEGE",
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: Colors.grey,
                          letterSpacing: 1.1,
                        ),
                        softWrap: false,
                        overflow:
                            TextOverflow.ellipsis, // <--- Prevents overflow
                      ),
                      const Text(
                        "Admin Portal",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          height: 1.1,
                        ),
                        softWrap: false,
                        overflow:
                            TextOverflow.ellipsis, // <--- Prevents overflow
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class _LogoIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo.png',
      height: 50,
      fit: BoxFit.contain,
    );
  }
}
