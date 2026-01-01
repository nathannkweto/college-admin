import 'package:flutter/material.dart';

class StudentBranding extends StatelessWidget {
  final bool isCollapsed;

  const StudentBranding({super.key, this.isCollapsed = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // --- FIX: Dynamic Padding ---
    // We remove horizontal padding when collapsed to give the icons room to breathe.
    // 80px (Drawer) - 0px (Padding) = 80px available for the 40px icons.
    final EdgeInsets padding = isCollapsed
        ? const EdgeInsets.symmetric(vertical: 24)
        : const EdgeInsets.symmetric(vertical: 24, horizontal: 24);

    return Container(
      width: double.infinity,
      padding: padding,
      child: isCollapsed
          ? Center(
              // Center ensures the icons is perfectly aligned in the 80px width
              child: _LogoIcon(),
            )
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _LogoIcon(),
                  const SizedBox(width: 12),
                  Flexible(
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
                        ),
                        const Text(
                          "Student Portal",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            height: 1.1,
                          ),
                          softWrap: false,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
