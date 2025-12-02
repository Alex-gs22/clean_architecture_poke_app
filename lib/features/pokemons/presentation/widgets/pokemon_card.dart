import 'package:clean_architecture_poke_app/features/pokemons/domain/entities/pokemon.dart';
import 'package:flutter/material.dart';

class PokemonCard extends StatelessWidget {
  const PokemonCard({super.key, required this.pokemon});

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
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
              color: const Color(0xFFF2F3FB),
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
              color: const Color(0xFF1F2A44),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(
            '#${pokemon.id}',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF6E7385),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _StatTile(
                label: 'Peso',
                value: '${_formatWeight(pokemon.weight)} kg',
              ),
              const SizedBox(width: 10),
              _StatTile(
                label: 'Altura',
                value: '${_formatHeight(pokemon.height)} m',
              ),
              const SizedBox(width: 10),
              _StatTile(
                label: 'EXP Base',
                value: '${pokemon.baseExperience}',
              ),
            ],
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B4CCA),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Capturar',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
              side: const BorderSide(color: Color(0xFF8A8FA3)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              foregroundColor: const Color(0xFF5A6072),
            ),
            icon: const Icon(Icons.info_outline),
            label: const Text('Ver detalles completos'),
          ),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F6FB),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: const Color(0xFF7A7F90),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: theme.textTheme.titleMedium?.copyWith(
                color: const Color(0xFF3B4CCA),
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
