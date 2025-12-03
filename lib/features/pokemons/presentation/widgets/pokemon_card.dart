import 'package:clean_architecture_poke_app/features/pokemons/domain/entities/pokemon.dart';
import 'package:flutter/material.dart';

class PokemonCard extends StatelessWidget {
  const PokemonCard({
    super.key,
    required this.pokemon,
    required this.onCapture,
    required this.onViewDetails,
    this.isCapturing = false,
    this.isCaptured = false,
  });

  final Pokemon pokemon;
  final VoidCallback onCapture;
  final VoidCallback onViewDetails;
  final bool isCapturing;
  final bool isCaptured;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final surface = theme.colorScheme.surface;
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
          const SizedBox(height: 16),
          Row(
            children: [
              _StatTile(
                label: 'Peso',
                value: '${_formatWeight(pokemon.weight)} kg',
                background: surfaceVariant,
                textColor: theme.colorScheme.primary,
              ),
              const SizedBox(width: 10),
              _StatTile(
                label: 'Altura',
                value: '${_formatHeight(pokemon.height)} m',
                background: surfaceVariant,
                textColor: theme.colorScheme.primary,
              ),
              const SizedBox(width: 10),
              _StatTile(
                label: 'EXP Base',
                value: '${pokemon.baseExperience}',
                background: surfaceVariant,
                textColor: theme.colorScheme.primary,
              ),
            ],
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: (isCapturing || isCaptured) ? null : onCapture,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B4CCA),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: isCapturing
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      isCaptured ? 'Capturado' : 'Capturar',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: isCapturing ? null : onViewDetails,
              style: OutlinedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                side: const BorderSide(color: Color(0xFF8A8FA3)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                foregroundColor: const Color(0xFF5A6072),
              ),
              icon: const Icon(Icons.info_outline),
              label: const Text('Ver detalles completos'),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.label,
    required this.value,
    required this.background,
    required this.textColor,
  });

  final String label;
  final String value;
  final Color background;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: background,
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
                color: textColor,
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
