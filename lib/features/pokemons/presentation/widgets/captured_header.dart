import 'package:flutter/material.dart';

class CapturedHeader extends StatelessWidget {
  const CapturedHeader({super.key, required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: const BoxDecoration(
                color: Color(0xFFFFCC00),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                '$count',
                style: const TextStyle(
                  color: Color(0xFF1F2A44),
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
                color: const Color(0xFF1F2A44),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Tu colección de Pokémon\'s',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: const Color(0xFF6E7385),
          ),
        ),
      ],
    );
  }
}
