import 'package:clean_architecture_poke_app/features/pokemons/domain/entities/pokemon.dart';
import 'package:flutter/material.dart';

class PokemonDetailSummaryCard extends StatelessWidget {
  const PokemonDetailSummaryCard({super.key, required this.pokemon});

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final surface = theme.colorScheme.brightness == Brightness.dark
        ? theme.colorScheme.surface.withOpacity(0.12)
        : theme.colorScheme.surface;
    final onSurface = theme.colorScheme.onSurface;
    final surfaceVariant = theme.colorScheme.surfaceVariant;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 12,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: surfaceVariant,
              borderRadius: BorderRadius.circular(24),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.network(
                pokemon.image,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.catching_pokemon,
                  color: Color(0xFF3B4CCA),
                  size: 48,
                ),
              ),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            _capitalize(pokemon.name),
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(
            '#${pokemon.id}',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          if (pokemon.types.isNotEmpty) ...[
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: pokemon.types
                  .map(
                    (t) => Chip(
                      backgroundColor: theme.colorScheme.primary,
                      labelPadding: const EdgeInsets.symmetric(horizontal: 10),
                      label: Text(
                        _capitalize(t),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      shape: const StadiumBorder(),
                    ),
                  )
                  .toList(),
            ),
          ],
          const SizedBox(height: 16),
          Row(
            children: [
              _DetailStat(label: 'Peso', value: '${_formatWeight(pokemon.weight)} kg'),
              const SizedBox(width: 10),
              _DetailStat(label: 'Altura', value: '${_formatHeight(pokemon.height)} m'),
              const SizedBox(width: 10),
              _DetailStat(label: 'EXP Base', value: '${pokemon.baseExperience}'),
            ],
          ),
        ],
      ),
    );
  }
}

class _DetailStat extends StatelessWidget {
  const _DetailStat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
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
