import 'package:clean_architecture_poke_app/core/errors/failures.dart';
import 'package:clean_architecture_poke_app/features/pokemons/data/models/pokemon_model.dart';
import 'package:clean_architecture_poke_app/features/pokemons/domain/entities/pokemon.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class PokemonsLocalDataSource {
  Future<bool> capturePokemon(Pokemon pokemon);
  Future<List<PokemonModel>> getCapturedPokemonsList();
  Future<bool> liberatePokemon(int id);
}

class HivePokemonLocalDataSourceImpl implements PokemonsLocalDataSource {
  HivePokemonLocalDataSourceImpl() {
    Hive.initFlutter();
  }
  @override
  Future<bool> capturePokemon(Pokemon pokemon) async {
    try {
      Box<dynamic> box = await Hive.openBox('pokemons');
      await box.put(pokemon.id, PokemonModel.fromEntity(pokemon).toJson());
      return true;
    } catch (error) {
      debugPrint(error.toString());
      throw LocalFailure();
    }
  }

  @override
  Future<List<PokemonModel>> getCapturedPokemonsList() async {
    try {
      Box<dynamic> box = await Hive.openBox('pokemons');
      return box.values.map((p) => PokemonModel.fromJson(p)).toList();
    } catch (error) {
      debugPrint(error.toString());
      throw LocalFailure();
    }
  }

  @override
  Future<bool> liberatePokemon(int id) async {
    try {
      Box<dynamic> box = await Hive.openBox('pokemons');
      await box.deleteAt(id);
      return true;
    } catch (error) {
      debugPrint(error.toString());
      throw LocalFailure();
    }
  }
}
