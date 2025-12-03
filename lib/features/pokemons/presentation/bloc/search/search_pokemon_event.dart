part of 'search_pokemon_bloc.dart';

sealed class SearchPokemonEvent {}

class SearchPokemonRequested extends SearchPokemonEvent {
  SearchPokemonRequested(this.id);
  final int id;
}

class SearchPokemonRandomRequested extends SearchPokemonEvent {}

class SearchPokemonReset extends SearchPokemonEvent {}

class CapturePokemonRequested extends SearchPokemonEvent {
  CapturePokemonRequested(this.pokemon);
  final Pokemon pokemon;
}
