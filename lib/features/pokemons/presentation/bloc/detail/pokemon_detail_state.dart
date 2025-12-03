part of 'pokemon_detail_bloc.dart';

sealed class PokemonDetailState {}

class PokemonDetailInitial extends PokemonDetailState {}

class PokemonDetailLoading extends PokemonDetailState {}

class PokemonDetailError extends PokemonDetailState {
  PokemonDetailError(this.message);
  final String message;
}

class PokemonDetailLoaded extends PokemonDetailState {
  PokemonDetailLoaded({
    required this.pokemon,
    this.isCapturing = false,
    this.statusMessage,
    this.isStatusError = false,
  });

  final Pokemon pokemon;
  final bool isCapturing;
  final String? statusMessage;
  final bool isStatusError;

  PokemonDetailLoaded copyWith({
    Pokemon? pokemon,
    bool? isCapturing,
    String? statusMessage,
    bool? isStatusError,
  }) {
    return PokemonDetailLoaded(
      pokemon: pokemon ?? this.pokemon,
      isCapturing: isCapturing ?? this.isCapturing,
      statusMessage: statusMessage,
      isStatusError: isStatusError ?? this.isStatusError,
    );
  }
}
