part of 'pokemon_detail_bloc.dart';

sealed class PokemonDetailEvent {}

class PokemonDetailRequested extends PokemonDetailEvent {
  PokemonDetailRequested(this.id);
  final int id;
}

class PokemonDetailCaptureRequested extends PokemonDetailEvent {}
