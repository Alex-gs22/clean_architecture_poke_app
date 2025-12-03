import 'package:clean_architecture_poke_app/core/errors/failures.dart';
import 'package:clean_architecture_poke_app/features/pokemons/domain/entities/pokemon.dart';
import 'package:clean_architecture_poke_app/features/pokemons/domain/repositories/pokemons_repository.dart';
import 'package:dartz/dartz.dart';

class GetCapturedPokemonsUseCase {
  final PokemonsRepository repository;

  GetCapturedPokemonsUseCase({required this.repository});

  Future<Either<Failure, List<Pokemon>>> call() {
    return repository.getCapturedPokemons();
  }
}
