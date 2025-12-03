import 'package:clean_architecture_poke_app/core/errors/failures.dart';
import 'package:clean_architecture_poke_app/features/pokemons/data/datasources/pokemons_local_data_source.dart';
import 'package:clean_architecture_poke_app/features/pokemons/data/datasources/pokemons_remote_data_source.dart';
import 'package:clean_architecture_poke_app/features/pokemons/data/models/pokemon_model.dart';
import 'package:clean_architecture_poke_app/features/pokemons/domain/entities/pokemon.dart';
import 'package:clean_architecture_poke_app/features/pokemons/domain/repositories/pokemons_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class PokemonsRepositoryImpl implements PokemonsRepository {
  final PokemonsLocalDataSource pokemonsLocalDataSource;
  final PokemonsRemoteDataSource pokemonsRemoteDataSource;

  PokemonsRepositoryImpl({
    required this.pokemonsLocalDataSource,
    required this.pokemonsRemoteDataSource,
  });

  @override
  Future<Either<Failure, bool>> capturePokemon(Pokemon pokemon) async {
    try {
      final bool resp = await pokemonsLocalDataSource.capturePokemon(pokemon);
      return right(resp);
    } on AlreadyCapturedFailure {
      return left(AlreadyCapturedFailure());
    } on LocalFailure {
      return left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, List<Pokemon>>> getCapturePokemons() async {
    try {
      final List<Pokemon> resp =
          await pokemonsLocalDataSource.getCapturedPokemonsList();
      return right(resp);
    } on LocalFailure {
      return left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, Pokemon>> getPokemon(int id) async {
    try {
      final Pokemon resp = await pokemonsRemoteDataSource.getPokemon(id);
      return right(resp);
    } on DioException {
      return left(ServerFailure());
    } catch (_) {
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> liberatePokemon(int id) async {
    try {
      final bool resp = await pokemonsLocalDataSource.liberatePokemon(id);
      return right(resp);
    } on LocalFailure {
      return left(LocalFailure());
    }
  }
}
