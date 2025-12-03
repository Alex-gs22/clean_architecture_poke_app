import 'package:flutter/material.dart';

class CapturedHeader extends StatelessWidget {
  const CapturedHeader({super.key, required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onBackground = theme.colorScheme.onBackground;
    final isDark = theme.brightness == Brightness.dark;
    final circleColor =
        isDark ? theme.colorScheme.primary : const Color(0xFFF8D7DA);
    const iconColor = Colors.white;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: circleColor,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                '$count',
                style: TextStyle(
                  color: iconColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Capturados',
              style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: onBackground,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Tu colección de Pokémon',
          style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
        ),
      ],
    );
  }
}
