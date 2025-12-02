import 'package:clean_architecture_poke_app/features/pokemons/data/models/pokemon_model.dart';
import 'package:dio/dio.dart';

abstract class PokemonsRemoteDataSource {
  Future<PokemonModel> getPokemon(int id);
}

class PokemonsRemoteDataSourceImpl implements PokemonsRemoteDataSource {
  PokemonsRemoteDataSourceImpl({required Dio client}) : dio = client;

  final Dio dio;

  @override
  Future<PokemonModel> getPokemon(int id) async {
    try {
      final resp = await dio.get('/pokemon/$id/');
      return PokemonModel.fromJson(Map<String, dynamic>.from(resp.data));
    } on DioException {
      rethrow;
    } catch (error) {
      throw DioException(
        requestOptions: RequestOptions(path: '/pokemon/$id/'),
        error: error,
        type: DioExceptionType.unknown,
      );
    }
  }
}
