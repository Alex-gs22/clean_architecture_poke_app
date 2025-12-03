import 'package:clean_architecture_poke_app/features/pokemons/data/datasources/pokemons_local_data_source.dart';
import 'package:clean_architecture_poke_app/features/pokemons/data/datasources/pokemons_remote_data_source.dart';
import 'package:clean_architecture_poke_app/features/pokemons/data/repositories/pokemons_repository_impl.dart';
import 'package:clean_architecture_poke_app/features/pokemons/domain/repositories/pokemons_repository.dart';
import 'package:clean_architecture_poke_app/features/pokemons/domain/use_cases/capture_pokemon.dart';
import 'package:clean_architecture_poke_app/features/pokemons/domain/use_cases/get_captured_pokemons.dart';
import 'package:clean_architecture_poke_app/features/pokemons/domain/use_cases/liberate_pokemon.dart';
import 'package:clean_architecture_poke_app/features/pokemons/domain/use_cases/search_pokemon.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

final GetIt getIt = GetIt.instance;

Future<void> initDependencies() async {
  await Hive.initFlutter();

  getIt.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: 'https://pokeapi.co/api/v2',
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
      ),
    ),
  );

  getIt.registerLazySingleton<PokemonsRemoteDataSource>(
    () => PokemonsRemoteDataSourceImpl(client: getIt()),
  );

  getIt.registerLazySingleton<PokemonsLocalDataSource>(
    () => HivePokemonLocalDataSourceImpl(),
  );

  getIt.registerLazySingleton<PokemonsRepository>(
    () => PokemonsRepositoryImpl(
      pokemonsLocalDataSource: getIt(),
      pokemonsRemoteDataSource: getIt(),
    ),
  );

  getIt.registerLazySingleton(
    () => SearchPokemonUseCase(repository: getIt()),
  );
  getIt.registerLazySingleton(
    () => CapturePokemonUseCase(repository: getIt()),
  );
  getIt.registerLazySingleton(
    () => GetCapturedPokemonsUseCase(repository: getIt()),
  );
  getIt.registerLazySingleton(
    () => LiberatePokemonUseCase(repository: getIt()),
  );
}
