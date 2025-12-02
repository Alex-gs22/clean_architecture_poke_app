part of 'search_pokemon_bloc.dart';

sealed class SearchPokemonState {}

class SearchPokemonInitial extends SearchPokemonState {}

class SearchPokemonLoading extends SearchPokemonState {}

class SearchPokemonSuccess extends SearchPokemonState {
  SearchPokemonSuccess(this.pokemon);
  final Pokemon pokemon;
}

class SearchPokemonError extends SearchPokemonState {
  SearchPokemonError(this.message);
  final String message;
}
