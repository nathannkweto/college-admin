import 'package:flutter/material.dart';

class StatusBadge extends StatelessWidget {
  final String status;
  final bool small;

  const StatusBadge({super.key, required this.status, this.small = false});

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (status.toLowerCase()) {
      case 'active': color = Colors.green; break;
      case 'graduated': color = Colors.blue; break;
      case 'suspended': color = Colors.red; break;
      case 'inactive': color = Colors.orange; break;
      default: color = Colors.grey;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: small ? 8 : 16,
        vertical: small ? 4 : 8,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          color: color,
          fontSize: small ? 10 : 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}