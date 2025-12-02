part of 'search_pokemon_bloc.dart';

sealed class SearchPokemonEvent {}

class OnSearchPokemon extends SearchPokemonEvent {}

class OnCapturedPokemon extends SearchPokemonEvent {
  final Pokemon pokemon;

  OnCapturedPokemon({required this.pokemon});
}
