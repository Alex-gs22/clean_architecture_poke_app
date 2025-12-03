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

  factory PokemonModel.fromJson(dynamic json) {
    final map = Map<String, dynamic>.from(json as Map);

    final sprites = (map['sprites'] as Map?) != null
        ? Map<String, dynamic>.from(map['sprites'] as Map)
        : <String, dynamic>{};
    final otherSprites = (sprites['other'] as Map?) != null
        ? Map<String, dynamic>.from(sprites['other'] as Map)
        : <String, dynamic>{};
    final officialArtwork = (otherSprites['official-artwork'] as Map?) != null
        ? Map<String, dynamic>.from(otherSprites['official-artwork'] as Map)
        : <String, dynamic>{};
    final frontDefault = sprites['front_default'] ??
        officialArtwork['front_default'] ??
        '';

    final dynamic rawTypes = map['types'];
    final List<String> types = switch (rawTypes) {
      List<dynamic> list when list.isNotEmpty && list.first is Map =>
        list.map((t) => t['type']['name'].toString()).toList(),
      List<dynamic> list => list.map((t) => t.toString()).toList(),
      _ => <String>[],
    };

    final dynamic rawStats = map['stats'];
    final Map<String, int> stats = <String, int>{};
    if (rawStats is List<dynamic>) {
      for (final stat in rawStats) {
        final key = stat['stat']['name'].toString();
        final value = (stat['base_stat'] as num?)?.toInt() ?? 0;
        stats[key] = value;
      }
    } else if (rawStats is Map) {
      rawStats.forEach((key, value) {
        stats[key.toString()] = (value as num).toInt();
      });
    }

    return PokemonModel(
      id: (map['id'] as num).toInt(),
      name: map['name'].toString(),
      image: frontDefault.toString(),
      weight: (map['weight'] as num).toInt(),
      height: (map['height'] as num).toInt(),
      baseExperience: (map['base_experience'] as num).toInt(),
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
