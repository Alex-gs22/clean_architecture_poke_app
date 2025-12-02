import 'package:clean_architecture_poke_app/core/errors/failures.dart';
import 'package:clean_architecture_poke_app/features/pokemons/domain/repositories/pokemons_repository.dart';
import 'package:dartz/dartz.dart';

class LiberatePokemonUseCase {
  final PokemonsRepository repository;

  LiberatePokemonUseCase({required this.repository});

  Future<Either<Failure, bool>> call(int id) {
    return repository.liberatePokemon(id);
  }
}
