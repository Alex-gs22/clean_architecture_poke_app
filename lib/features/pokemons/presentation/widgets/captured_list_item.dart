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
    final surface = theme.colorScheme.surface;
    final onSurface = theme.colorScheme.onSurface;
    final surfaceVariant = theme.colorScheme.surfaceVariant;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: surfaceVariant,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  pokemon.image,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => Icon(
                    Icons.catching_pokemon,
                    color: theme.colorScheme.primary,
                    size: 28,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _capitalize(pokemon.name),
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: onSurface,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '#${pokemon.id}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _ChipStat(
                        label: '${_formatWeight(pokemon.weight)} kg',
                        color: surfaceVariant,
                        textColor: theme.colorScheme.primary,
                      ),
                      _ChipStat(
                        label: '${_formatHeight(pokemon.height)} m',
                        color: surfaceVariant,
                        textColor: theme.colorScheme.primary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: pokemon.types
                  .map(
                    (t) => Container(
                      margin: const EdgeInsets.only(bottom: 6),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: surfaceVariant,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        _capitalize(t),
                        style: TextStyle(
                          color: onSurface,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
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
