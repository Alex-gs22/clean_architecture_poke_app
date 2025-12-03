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
    required this.isCaptured,
    this.isCapturing = false,
    this.isProcessing = false,
    this.statusMessage,
    this.isStatusError = false,
  });

  final Pokemon pokemon;
  final bool isCaptured;
  final bool isCapturing;
  final bool isProcessing;
  final String? statusMessage;
  final bool isStatusError;

  PokemonDetailLoaded copyWith({
    Pokemon? pokemon,
    bool? isCaptured,
    bool? isCapturing,
    bool? isProcessing,
    String? statusMessage,
    bool? isStatusError,
  }) {
    return PokemonDetailLoaded(
      pokemon: pokemon ?? this.pokemon,
      isCaptured: isCaptured ?? this.isCaptured,
      isCapturing: isCapturing ?? this.isCapturing,
      isProcessing: isProcessing ?? this.isProcessing,
      statusMessage: statusMessage,
      isStatusError: isStatusError ?? this.isStatusError,
    );
  }
}
