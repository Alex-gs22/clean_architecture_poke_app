part of 'captured_pokemons_bloc.dart';

sealed class CapturedPokemonsEvent {}

class CapturedPokemonsRequested extends CapturedPokemonsEvent {}

class LiberatePokemonRequested extends CapturedPokemonsEvent {
  LiberatePokemonRequested(this.id);
  final int id;
}
