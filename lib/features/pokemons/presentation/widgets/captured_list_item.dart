import 'package:clean_architecture_poke_app/features/pokemons/domain/entities/pokemon.dart';
import 'package:flutter/material.dart';

class CapturedListItem extends StatelessWidget {
  const CapturedListItem({
    super.key,
    required this.pokemon,
    required this.onDelete,
    this.isProcessing = false,
  });

  final Pokemon pokemon;
  final VoidCallback onDelete;
  final bool isProcessing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
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
          IconButton(
            onPressed: isProcessing ? null : onDelete,
            style: IconButton.styleFrom(
              backgroundColor: const Color(0xFFFFEFEF),
            ),
            icon: isProcessing
                ? const SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Color(0xFFE53935),
                    ),
                  )
                : const Icon(
                    Icons.delete_outline,
                    color: Color(0xFFE53935),
                  ),
          ),
        ],
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
