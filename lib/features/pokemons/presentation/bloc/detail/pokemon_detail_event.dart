part of 'pokemon_detail_bloc.dart';

sealed class PokemonDetailEvent {}

class PokemonDetailRequested extends PokemonDetailEvent {
  PokemonDetailRequested(this.id, {required this.isCaptured});
  final int id;
  final bool isCaptured;
}

class PokemonDetailCaptureRequested extends PokemonDetailEvent {}

class PokemonDetailLiberateRequested extends PokemonDetailEvent {}
