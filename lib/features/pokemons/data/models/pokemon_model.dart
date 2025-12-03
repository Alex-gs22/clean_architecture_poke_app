import 'package:clean_architecture_poke_app/features/pokemons/domain/entities/pokemon.dart';

class PokemonModel extends Pokemon {
  PokemonModel({
    required super.id,
    required super.name,
    required super.image,
    required super.weight,
    required super.height,
    required super.baseExperience,
    required super.types,
    required super.stats,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    final sprites = json['sprites'] as Map<String, dynamic>? ?? {};
    final otherSprites = sprites['other'] as Map<String, dynamic>? ?? {};
    final officialArtwork =
        (otherSprites['official-artwork'] as Map<String, dynamic>?) ?? {};
    final frontDefault = sprites['front_default'] ??
        officialArtwork['front_default'] ??
        '';

    final dynamic rawTypes = json['types'];
    final List<String> types = switch (rawTypes) {
      List<dynamic> list when list.isNotEmpty && list.first is Map =>
        list.map((t) => t['type']['name'] as String).toList(),
      List<dynamic> list => list.map((t) => t.toString()).toList(),
      _ => <String>[],
    };

    final dynamic rawStats = json['stats'];
    final Map<String, int> stats = <String, int>{};
    if (rawStats is List<dynamic>) {
      for (final stat in rawStats) {
        stats[stat['stat']['name'] as String] =
            (stat['base_stat'] as num).toInt();
      }
    } else if (rawStats is Map<String, dynamic>) {
      rawStats.forEach((key, value) {
        stats[key] = (value as num).toInt();
      });
    }

    return PokemonModel(
      id: json['id'],
      name: json['name'],
      image: frontDefault as String,
      weight: (json['weight'] as num).toInt(),
      height: (json['height'] as num).toInt(),
      baseExperience: (json['base_experience'] as num).toInt(),
      types: types,
      stats: stats,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'sprites': {'front_default': image},
      'weight': weight,
      'height': height,
      'base_experience': baseExperience,
      'types': types,
      'stats': stats,
    };
  }

  factory PokemonModel.fromEntity(Pokemon pokemon) {
    return PokemonModel(
      id: pokemon.id,
      name: pokemon.name,
      image: pokemon.image,
      weight: pokemon.weight,
      height: pokemon.height,
      baseExperience: pokemon.baseExperience,
      types: pokemon.types,
      stats: pokemon.stats,
    );
  }
}
