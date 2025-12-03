part of 'search_pokemon_bloc.dart';

sealed class SearchPokemonState {}

class SearchPokemonInitial extends SearchPokemonState {}

class SearchPokemonLoading extends SearchPokemonState {}

class SearchPokemonError extends SearchPokemonState {
  SearchPokemonError(this.message);
  final String message;
}

class SearchPokemonLoaded extends SearchPokemonState {
  SearchPokemonLoaded({
    required this.pokemon,
    this.isCaptured = false,
    this.isCapturing = false,
    this.statusMessage,
    this.isStatusError = false,
  });

  final Pokemon pokemon;
  final bool isCaptured;
  final bool isCapturing;
  final String? statusMessage;
  final bool isStatusError;

  SearchPokemonLoaded copyWith({
    Pokemon? pokemon,
    bool? isCaptured,
    bool? isCapturing,
    String? statusMessage,
    bool? isStatusError,
  }) {
    return SearchPokemonLoaded(
      pokemon: pokemon ?? this.pokemon,
      isCaptured: isCaptured ?? this.isCaptured,
      isCapturing: isCapturing ?? this.isCapturing,
      statusMessage: statusMessage,
      isStatusError: isStatusError ?? this.isStatusError,
    );
  }
}
