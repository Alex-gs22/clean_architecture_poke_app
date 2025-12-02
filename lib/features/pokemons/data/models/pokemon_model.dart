import 'package:clean_architecture_poke_app/features/pokemons/domain/entities/pokemon.dart';

class PokemonModel extends Pokemon {
  PokemonModel({
    required super.id,
    required super.name,
    required super.image,
    required super.weight,
    required super.height,
    required super.baseExperience,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
      id: json['id'],
      name: json['name'],
      image: json['sprites']['front_default'],
      weight: json['weight'],
      height: json['height'],
      baseExperience: json['base_experience'],
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
    );
  }
}
