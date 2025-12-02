import 'package:flutter/material.dart';

class SearchHeader extends StatelessWidget {
  const SearchHeader({super.key});

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
              child: const Icon(
                Icons.catching_pokemon,
                color: Color(0xFF26395A),
                size: 28,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'PokéApp',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1F2A44),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Descubre y captura tus Pokémon favoritos',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: const Color(0xFF6E7385),
          ),
        ),
      ],
    );
  }
}
