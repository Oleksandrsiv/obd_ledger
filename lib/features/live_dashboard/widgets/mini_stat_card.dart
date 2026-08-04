import 'package:flutter/material.dart';

class MiniStatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String unit;
  final Color? iconColor;

  const MiniStatCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.unit,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Calculate the width: (Screen width - side padding - distance between cards) / 2
    final cardWidth = (MediaQuery.of(context).size.width - 48 - 16) / 2;

    return SizedBox(
      width: cardWidth,
      child: Card(
        elevation: 0,
        color: isDark ? Colors.white10 : Colors.black12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: iconColor ?? Theme.of(context).colorScheme.primary,
                size: 28,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 2),
                  Text(unit, style: TextStyle(fontSize: 12, color: isDark ? Colors.white54 : Colors.black54)),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                title,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: isDark ? Colors.white60 : Colors.black87),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}