import 'package:flutter/material.dart';

class CapturedHeader extends StatelessWidget {
  const CapturedHeader({super.key, required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Capturados',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF1F2A44),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Tu colección de Pokémon',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF6E7385),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 34,
          height: 34,
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
            ),
          ),
        ),
      ],
    );
  }
}
