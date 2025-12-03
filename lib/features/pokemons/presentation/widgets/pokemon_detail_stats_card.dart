import 'package:clean_architecture_poke_app/features/pokemons/domain/entities/pokemon.dart';
import 'package:flutter/material.dart';

class PokemonDetailStatsCard extends StatelessWidget {
  const PokemonDetailStatsCard({super.key, required this.pokemon});

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    final stats = pokemon.stats;
    final surface = Theme.of(context).colorScheme.surface;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Estadísticas Base',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          ..._statOrder.map(
            (key) => _StatRow(
              label: _statLabel[key] ?? key,
              value: stats[key] ?? 0,
              color: _statColor[key] ?? Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  const _StatRow({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final int value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF555B6B),
                    ),
              ),
              Text(
                '$value',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF3B4CCA),
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: (value / 150).clamp(0, 1).toDouble(),
              minHeight: 6,
              backgroundColor: const Color(0xFFE1E4EC),
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ],
      ),
    );
  }
}

const List<String> _statOrder = [
  'hp',
  'attack',
  'defense',
  'special-attack',
  'special-defense',
  'speed',
];

const Map<String, String> _statLabel = {
  'hp': 'HP',
  'attack': 'Attack',
  'defense': 'Defense',
  'special-attack': 'Special Attack',
  'special-defense': 'Special Defense',
  'speed': 'Speed',
};

const Map<String, Color> _statColor = {
  'hp': Color(0xFFE56464),
  'attack': Color(0xFFF5A45B),
  'defense': Color(0xFFE4C55E),
  'special-attack': Color(0xFF8AA6FF),
  'special-defense': Color(0xFF7AC187),
  'speed': Color(0xFFF79AC1),
};
