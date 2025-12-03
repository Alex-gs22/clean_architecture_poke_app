import 'package:clean_architecture_poke_app/features/pokemons/domain/entities/pokemon.dart';
import 'package:flutter/material.dart';

class CapturedListItem extends StatelessWidget {
  const CapturedListItem({
    super.key,
    required this.pokemon,
    required this.onTap,
  });

  final Pokemon pokemon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1A000000),
              blurRadius: 10,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: const Color(0xFFF2F3FB),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  pokemon.image,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.catching_pokemon,
                    color: Color(0xFF3B4CCA),
                    size: 28,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _capitalize(pokemon.name),
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1F2A44),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '#${pokemon.id}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF6E7385),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _ChipStat(
                        label: '${_formatWeight(pokemon.weight)} kg',
                        color: const Color(0xFFD6E7FF),
                        textColor: const Color(0xFF3B4CCA),
                      ),
                      const SizedBox(width: 8),
                      _ChipStat(
                        label: '${_formatHeight(pokemon.height)} m',
                        color: const Color(0xFFF0E4FF),
                        textColor: const Color(0xFF8A5BFF),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: pokemon.types
                  .map(
                    (t) => Container(
                      margin: const EdgeInsets.only(bottom: 6),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE6E9F4),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        _capitalize(t),
                        style: const TextStyle(
                          color: Color(0xFF1F2A44),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChipStat extends StatelessWidget {
  const _ChipStat({
    required this.label,
    required this.color,
    required this.textColor,
  });

  final String label;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

String _capitalize(String value) {
  if (value.isEmpty) return value;
  return value[0].toUpperCase() + value.substring(1);
}

String _formatWeight(int weightHectograms) {
  final double kg = weightHectograms / 10;
  return kg.toStringAsFixed(1);
}

String _formatHeight(int heightDecimeters) {
  final double meters = heightDecimeters / 10;
  return meters.toStringAsFixed(1);
}
