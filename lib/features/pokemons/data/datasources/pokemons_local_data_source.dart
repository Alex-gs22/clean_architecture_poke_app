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
  HivePokemonLocalDataSourceImpl({this.boxName = 'pokemons'});

  final String boxName;
  Box<dynamic>? _box;

  Future<Box<dynamic>> _getBox() async {
    if (_box?.isOpen == true) return _box!;
    _box = await Hive.openBox(boxName);
    return _box!;
  }

  @override
  Future<bool> capturePokemon(Pokemon pokemon) async {
    try {
      final box = await _getBox();
      if (box.containsKey(pokemon.id)) {
        throw AlreadyCapturedFailure();
      }
      await box.put(pokemon.id, PokemonModel.fromEntity(pokemon).toJson());
      return true;
    } catch (error) {
      debugPrint(error.toString());
      if (error is AlreadyCapturedFailure) {
        throw error;
      }
      throw LocalFailure();
    }
  }

  @override
  Future<List<PokemonModel>> getCapturedPokemonsList() async {
    try {
      final box = await _getBox();
      return box.values.map((p) => PokemonModel.fromJson(p)).toList();
    } catch (error) {
      debugPrint(error.toString());
      throw LocalFailure();
    }
  }

  @override
  Future<bool> liberatePokemon(int id) async {
    try {
      final box = await _getBox();
      await box.delete(id);
      return true;
    } catch (error) {
      debugPrint(error.toString());
      throw LocalFailure();
    }
  }
}
